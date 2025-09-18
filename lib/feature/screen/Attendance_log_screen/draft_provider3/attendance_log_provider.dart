import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final attendanceLogProvider = StateNotifierProvider<AttendanceLogNotifier, Map<String, dynamic>>((ref) {
  return AttendanceLogNotifier();
});

class AttendanceLogNotifier extends StateNotifier<Map<String, dynamic>> {
  AttendanceLogNotifier() : super({}) {
    loadDraft();
  }

  final String _draftKey = 'attendance_log_draft';
  final Box _box = Hive.box('draftBox');

  void loadDraft() {
    final savedData = _box.get(_draftKey, defaultValue: {});
    state = Map<String, dynamic>.from(savedData);
  }

  void saveDraft(Map<String, dynamic> draftData) async {
    draftData['createdAt'] = DateTime.now().toString();
    await _box.put(_draftKey, draftData);
    state = Map<String, dynamic>.from(draftData);
  }

  void clearDraft() async {
    await _box.delete(_draftKey);
    state = {};
  }
}
