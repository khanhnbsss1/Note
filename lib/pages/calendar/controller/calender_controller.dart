import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/list_note.dart';
import '../../list_notes/controller/list_notes_controller.dart';

class CalenderController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var today = DateTime.now();
  var calendarFormat = CalendarFormat.month.obs;
  var showedEvent = <NoteDetail>[].obs;
  List<NoteDetail> eventsInDay = [];
  ListNotesController events = Get.find();

  @override
  void onInit() {
    updateEventsForSelectedDay();

    ever(events.noteDetails, (_) {
      updateEventsForSelectedDay();
    });
    super.onInit();
  }

  void updateEventsForSelectedDay() {
    getEventsForDay(selectedDay.value);
    saveShowedEvent();
  }

  void onDaySelect(DateTime selectedDay, DateTime focusedDay) {
    getEventsForDay(selectedDay);
    saveShowedEvent();
    this.selectedDay.update((val) {
      this.selectedDay.value = selectedDay;
    });
  }

  bool isTheSameDay(DateTime date, {DateTime? dateCheck}) {
    if (dateCheck == null) {
      return (date.day == selectedDay.value.day &&
          date.month == selectedDay.value.month &&
          date.year == selectedDay.value.year);
    } else {
      return (date.day == dateCheck.day &&
          date.month == dateCheck.month &&
          date.year == dateCheck.year);
    }
  }

  List<String> getEventsForDay(DateTime day) {
    eventsInDay.clear();
    List<String> eventList = [];
    for (var event in events.noteDetails.value.list ?? []) {
      if (event.time?.year == day.year &&
          event.time?.month == day.month &&
          event.time?.day == day.day) {
        eventList.add(event.title ?? "");
        eventsInDay.add(event);
      }
    }
    return eventList;
  }

  void saveShowedEvent() {
    showedEvent.assignAll(eventsInDay);
  }
}
