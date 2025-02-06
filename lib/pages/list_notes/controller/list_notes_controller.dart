import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../model/list_note.dart';
import '../../../service/local_database/shared_pref.dart';

class ListNotesController extends GetxController {
  SharedPreferencesIml sharedPreferencesIml = GetIt.instance.get();
  var noteDetails = ListNote(list: []).obs;

  @override
  void onInit() {
    noteDetails.value = sharedPreferencesIml.listNote ?? ListNote(list: []);
    super.onInit();
  }

  void saveNotes() {
    sharedPreferencesIml.saveNote(noteDetails.value);
  }

  void addNote(NoteDetail note) {
    noteDetails.update((val) {
      val?.list?.add(note);
    });
    saveNotes();
  }

  void deleteItem(int index) {
    noteDetails.update((val) {
      val?.list?.removeAt(index);
    });
    saveNotes();
  }

  void changeNoteState(int index, NoteDetail note) {
    noteDetails.update((val) {
      val?.list?[index] = note;
    });
    saveNotes();
  }
}
