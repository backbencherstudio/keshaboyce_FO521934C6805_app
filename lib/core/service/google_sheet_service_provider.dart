import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'google_sheet_api.dart';

final googleSheetServiceProvider = Provider<GoogleSheetService>((ref) {
  final service = GoogleSheetService();
  service.init(); // Initialize the service
  return service;
});