import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:workmanager/workmanager.dart';

import '../../../generated/l10n.dart';
import '../../../model/list_note.dart';
import '../../../service/background_service/work_manager.dart';
import '../../../service/local_database/shared_pref.dart';

class ListNotesController extends GetxController {
  SharedPreferencesIml sharedPreferencesIml = GetIt.instance.get();
  var noteDetails = ListNote(list: []).obs;
  var shownNotes = ListNote(list: []).obs;
  var listType = TypeList.all.obs;

  @override
  void onInit() {
    noteDetails.value = sharedPreferencesIml.listNote ?? ListNote(list: []);
    shownNotes = noteDetails;
    super.onInit();
  }

  void saveNotes() {
    sharedPreferencesIml.saveNote(noteDetails.value);
    shownNotes = noteDetails;
  }

  void addNote(NoteDetail note) {
    noteDetails.update((val) {
      val?.list?.insert(0, note);
    });
    saveNotes();
  }

  void deleteItem(int index) {
    noteDetails.update((val) {
      val?.list?.removeAt(index);
    });
    saveNotes();
  }

  void editNote(int index, NoteDetail note) {
    noteDetails.update((val) {
      val?.list?[index] = note;
    });
    saveNotes();
  }

  void onNoteDone(int index, bool? value) {
    noteDetails.value.list?.replaceRange(index, index + 1, [
      noteDetails.value.list![index].copyWith(
        done: value,
      ),
    ]);
    noteDetails.refresh();
    saveNotes();
  }

  void onUpdateNotificationStatus(int index, bool? value) {
    noteDetails.value.list?.replaceRange(index, index + 1, [
      noteDetails.value.list![index].copyWith(
        notificationStatus: value ?? false
            ? NotificationStatus.enable
            : NotificationStatus.disable,
      ),
    ]);
    noteDetails.refresh();
    saveNotes();
  }

  void notify(int index, NoteDetail note) {
    if (note.time!.millisecondsSinceEpoch - DateTime
        .now()
        .millisecondsSinceEpoch > 0) {
      Workmanager().registerOneOffTask(simpleDelayedTask, simpleDelayedTask,
          inputData: note.toJson(),
          initialDelay: Duration(
              milliseconds: note.time!.millisecondsSinceEpoch - DateTime
                  .now()
                  .millisecondsSinceEpoch)
      );
      onUpdateNotificationStatus(index, true);
    }
  }

  void changeTypeList(TypeList type) {
    listType.value = type;
    sortNoteDetail();
  }

  void sortNoteDetail() {
    onInit();
    if (listType.value == TypeList.done) {
      shownNotes.update((val) {
        val?.list = val.list?.where((e) => e.done == true).toList();
      });
    }
    if (listType.value == TypeList.notDone) {
      shownNotes.update((val) {
        val?.list = val.list?.where((e) => e.done == false).toList();
      });
    }
    if (listType.value == TypeList.overdue) {
      shownNotes.update((val) {
        val?.list = val.list?.where((e) => !(e.time!.isAfter(DateTime.now()))).toList();
      });
    }
    if (listType.value == TypeList.notOverdue) {
      shownNotes.update((val) {
        val?.list = val.list?.where((e) => e.time!.isAfter(DateTime.now())).toList();
      });
    }
    if (listType.value == TypeList.desc) {
      shownNotes.update((val) {
        val?.list = val.list
          ?..sort((a, b) => a.time!.compareTo(b.time!));
      });
    }
    if (listType.value == TypeList.asc) {
      shownNotes.update((val) {
        val?.list = val.list
          ?..sort((a, b) => b.time!.compareTo(a.time!));
      });
    }
  }

}

enum TypeList {
  done,
  notDone,
  overdue,
  notOverdue,
  desc,
  asc,
  all;

  String get label {
    switch (this) {
      case TypeList.done:
        return S.current.done;
      case TypeList.notDone:
        return S.current.not_done;
      case TypeList.overdue:
        return S.current.overdue;
      case TypeList.notOverdue:
        return S.current.not_overdue;
      case TypeList.desc:
        return S.current.desc;
      case TypeList.asc:
        return S.current.asc;
      case TypeList.all:
        return S.current.all;
    }
  }
}
