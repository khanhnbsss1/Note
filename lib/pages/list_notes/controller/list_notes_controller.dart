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
    noteDetails.value.list!.insert(0, note);
    saveNotes();
  }

  void deleteItem(int index) {
    noteDetails.value.list!.removeAt(index);
    saveNotes();
  }

  void changeNoteState(int index, NoteDetail note) {
    noteDetails.value.list!.replaceRange(index, index + 1, [note]);
    saveNotes();
  }
}
