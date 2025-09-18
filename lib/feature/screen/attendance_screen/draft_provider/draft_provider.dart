import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final draftProvider = StateNotifierProvider<DraftNotifier, List<Map<String, dynamic>>>((ref) {
  return DraftNotifier();
});

class DraftNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  DraftNotifier() : super([]) {
    loadDrafts();
  }

  Future<void> loadDrafts() async {
    final box = Hive.box('draftBox');
    state = box.values.cast<Map<String, dynamic>>().toList();
  }

  Future<void> saveDraft(Map<String, dynamic> data) async {
    final box = Hive.box('draftBox');
    await box.add(data);
    loadDrafts();
  }

  Future<void> deleteDraft(int index) async {
    final box = Hive.box('draftBox');
    await box.deleteAt(index);
    loadDrafts();
  }
}
