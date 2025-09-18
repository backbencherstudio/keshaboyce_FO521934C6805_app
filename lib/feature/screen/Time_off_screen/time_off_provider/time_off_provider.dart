import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final timeOffDraftProvider =
StateNotifierProvider<TimeOffDraftNotifier, Map<String, String>>(
        (ref) => TimeOffDraftNotifier());

class TimeOffDraftNotifier extends StateNotifier<Map<String, String>> {
  static const String _boxName = 'draftBox';
  static const String _key = 'time_off_draft';

  TimeOffDraftNotifier() : super({}) {
    _loadDraft();
  }

  /// Load draft from Hive
  Future<void> _loadDraft() async {
    // Ensure the box is open
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox(_boxName);
    }
    final box = Hive.box(_boxName);
    final savedData = box.get(_key);
    if (savedData != null) {
      state = Map<String, String>.from(savedData);
    }
  }

  /// Save draft to Hive
  Future<void> saveDraft(Map<String, String> draftData) async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox(_boxName);
    }
    final box = Hive.box(_boxName);
    await box.put(_key, draftData);
    state = draftData;
  }

  /// Clear draft
  Future<void> clearDraft() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox(_boxName);
    }
    final box = Hive.box(_boxName);
    await box.delete(_key);
    state = {};
  }
}
