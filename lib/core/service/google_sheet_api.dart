import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetService {
  static const _spreadsheetId = "16-VVgAtsOs_oEsvmkIAEVEbDhDMfKcBkZbFEO9KsS7c";
  late GSheets _gsheets;
  Spreadsheet? _spreadsheet;
  Worksheet? _worksheet;

  Future<void> init() async {
    try {
      final credsJson = await rootBundle.loadString('asset/credentials.json');
      final creds = jsonDecode(credsJson);
      _gsheets = GSheets(creds);
      _spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _worksheet = _spreadsheet!.worksheetByTitle('Users');

      if (_worksheet == null) {
        _worksheet = await _spreadsheet!.addWorksheet('Users');
        // Add header row
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
}