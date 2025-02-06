import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/event.dart';

class CalenderController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var today = DateTime.now();
  var calendarFormat = CalendarFormat.month.obs;
  var eventsInDay = <Event>[];
  var showedEvent = <Event>[].obs;

  void onDaySelect(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.update((val) {
      val;
      this.selectedDay.value = selectedDay;
      showedEvent.value = eventsInDay;
    });
  }

  bool isTheSameDay(DateTime date) {
    return (date.day == selectedDay.value.day &&
        date.month == selectedDay.value.month &&
        date.year == selectedDay.value.year);
  }

  List<String> getEventsForDay(DateTime day) {
    eventsInDay.clear();
    List<String> eventList = [];
    for (var event in events) {
      if (event.date?.year == day.year &&
          event.date?.month == day.month &&
          event.date?.day == day.day) {
        eventList.add(event.title ?? "");
        eventsInDay.add(event);
      }
    }
    return eventList;
  }
}
