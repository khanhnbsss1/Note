import 'package:note/service/local_database/shared_pref.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../model/list_note.dart';
import '../notification/notification_service.dart';

const simpleTaskKey = "simpleTask";
const rescheduledTaskKey = "rescheduledTask";
const failedTaskKey = "failedTask";
const simpleDelayedTask = "simpleDelayedTask";
const simplePeriodicTask = "simplePeriodicTask";
const simplePeriodic1HourTask = "simplePeriodic1HourTask";
const iOSBackgroundAppRefresh = "iOSBackgroundAppRefresh";
const iOSBackgroundProcessingTask = "iOSBackgroundProcessingTask";

final List<String> allTasks = [
  simpleTaskKey,
  rescheduledTaskKey,
  failedTaskKey,
  simpleDelayedTask,
  simplePeriodicTask,
  simplePeriodic1HourTask,
  iOSBackgroundAppRefresh,
  iOSBackgroundProcessingTask,
];

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // tz.initializeTimeZones();
    final sharedPrefs =  SharedPreferencesIml();
    await sharedPrefs.onInit();
    if (task == simpleDelayedTask) {
      ListNote? listNotes = sharedPrefs.listNote;
      try {
        NoteDetail note = NoteDetail.fromJson(inputData!);

        NotificationService.showZonedNotification(0, note.title!, note.content!, note.time!);

        int noteIndex = listNotes?.list?.indexWhere(
                (value) => value.time == note.time) ?? -1;

        if (noteIndex != -1) {
          listNotes?.list?.replaceRange(noteIndex, noteIndex + 1, [
            listNotes.list![noteIndex].copyWith(done: true),
          ]);
          sharedPrefs.saveNote(listNotes!);
        }
      } catch (e) {
        print(e.toString());
        return Future.value(false);
      }
    }
    return Future.value(true);
  });
}
