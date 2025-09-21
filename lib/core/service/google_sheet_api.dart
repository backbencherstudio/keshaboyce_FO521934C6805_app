import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetService {
  static const _spreadsheetId = "16-VVgAtsOs_oEsvmkIAEVEbDhDMfKcBkZbFEO9KsS7c";
  // static const _spreadsheetId = "16-VVgAtsOs_oEsvmkIAEVEbDhDMfKcBkZbFEO9KsS7c";
  late GSheets _gsheets;
  Spreadsheet? _spreadsheet;
  Worksheet? _worksheet;
  Worksheet? _worksheetUser2;
  Worksheet? _worksheetUser3;

  Future<void> init() async {
    try {
      final credsJson = await rootBundle.loadString('asset/credentials.json');
      final creds = jsonDecode(credsJson);
      _gsheets = GSheets(creds);
      _spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);

      // Initialize Users worksheet
      _worksheet = _spreadsheet!.worksheetByTitle('Tom_Report');
      if (_worksheet == null) {
        _worksheet = await _spreadsheet!.addWorksheet('Tom_Report');
        await _worksheet!.values.insertRow(1, [
          'Client Name',
          'Caregiver Name',
          'Date',
          'Observations',
          'Start Time',
          'End Time',
          'Timestamp'
        ]);
      }

      // Initialize User2 worksheet for Time-off Requests
      // Initialize User2 worksheet for Time-off Requests
      _worksheetUser2 = _spreadsheet!.worksheetByTitle('RTO'); // Change 'User' to 'User2'
      if (_worksheetUser2 == null) {
        _worksheetUser2 = await _spreadsheet!.addWorksheet('RTO');
        await _worksheetUser2!.values.insertRow(1, [
          'From Date',
          'To Date',
          'Notes',
          'Status',
          'Additional Notes',
          'Timestamp'
        ]);
      }

      // Initialize User3 worksheet for Attendance Log
      _worksheetUser3 = _spreadsheet!.worksheetByTitle('Attendence_log');
      if (_worksheetUser3 == null) {
        _worksheetUser3 = await _spreadsheet!.addWorksheet('Attendence_log');
        await _worksheetUser3!.values.insertRow(1, [
          'Date',
          'Scheduled Shift',
          'Clock In',
          'Clock Out',
          'Status',
          'Notes',
          'Violation',
          'Timestamp'
        ]);
      }
    } catch (e) {
      throw Exception('Failed to initialize Google Sheets: $e');
    }
  }

  Future<void> insertUser({
    required String clientname,
    required String caregivername,
    required String date,
    required String start_time,
    required String end_time,
    required String observation,
  }) async {
    if (_worksheet == null) {
      throw Exception('Worksheet not initialized');
    }
    try {
      await _worksheet!.values.appendRow([
        clientname,
        caregivername,
        date,
        observation,
        start_time,
        end_time,
        DateTime.now().toIso8601String(),
      ]);
    } catch (e) {
      throw Exception('Failed to insert data: $e');
    }
  }

  Future<void> insertTimeOffRequest({
    required String fromDate,
    required String toDate,
    required String notes,
    required String status,
    required String additionalNotes,
  }) async {
    if (_worksheetUser2 == null) {
      throw Exception('User2 worksheet not initialized');
    }
    try {
      await _worksheetUser2!.values.appendRow([
        fromDate,
        toDate,
        notes,
        status,
        additionalNotes,
        DateTime.now().toIso8601String(),
      ]);
    } catch (e) {
      throw Exception('Failed to insert time-off request data: $e');
    }
  }

  Future<void> insertAttendanceLog({
    required String date,
    required String scheduledShift,
    required String clockIn,
    required String clockOut,
    required String status,
    required String notes,
    required String violation,
  }) async {
    if (_worksheetUser3 == null) {
      throw Exception('User3 worksheet not initialized');
    }
    try {
      await _worksheetUser3!.values.appendRow([
        date,
        scheduledShift,
        clockIn,
        clockOut,
        status,
        notes,
        violation,
        DateTime.now().toIso8601String(),
      ]);
    } catch (e) {
      throw Exception('Failed to insert attendance log data: $e');
    }
  }
}



// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:gsheets/gsheets.dart';
//
// class GoogleSheetService {
//   static const _spreadsheetId = "16-VVgAtsOs_oEsvmkIAEVEbDhDMfKcBkZbFEO9KsS7c";
//   late GSheets _gsheets;
//   Spreadsheet? _spreadsheet;
//   Worksheet? _worksheet;
//
//   Future<void> init() async {
//     try {
//       final credsJson = await rootBundle.loadString('asset/credentials.json');
//       final creds = jsonDecode(credsJson);
//       _gsheets = GSheets(creds);
//       _spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
//       _worksheet = _spreadsheet!.worksheetByTitle('Users');
//
//       if (_worksheet == null) {
//         _worksheet = await _spreadsheet!.addWorksheet('Users');
//         // Add header row
//         await _worksheet!.values.insertRow(1, [
//           'Client Name',
//           'Caregiver Name',
//           'Date',
//           'Observations',
//           'Start Time',
//           'End Time',
//           'Timestamp'
//         ]);
//       }
//     } catch (e) {
//       throw Exception('Failed to initialize Google Sheets: $e');
//     }
//   }
//
//   Future<void> insertUser({
//     required String clientname,
//     required String caregivername,
//     required String date,
//     required String start_time,
//     required String end_time,
//     required String observation,
//   }) async {
//     if (_worksheet == null) {
//       throw Exception('Worksheet not initialized');
//     }
//     try {
//       await _worksheet!.values.appendRow([
//         clientname,
//         caregivername,
//         date,
//         observation,
//         start_time,
//         end_time,
//         DateTime.now().toIso8601String(),
//       ]);
//     } catch (e) {
//       throw Exception('Failed to insert data: $e');
//     }
//   }
// }