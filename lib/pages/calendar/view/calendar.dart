import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:note/config/app_config.dart';
import 'package:note/pages/calendar/controller/calender_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends GetWidget<CalenderController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: TableCalendar(
                rowHeight: 60,
                firstDay: controller.today,
                lastDay: controller.today.add(Duration(days: 10000)),
                focusedDay: controller.selectedDay.value,
                onDaySelected: controller.onDaySelect,
                selectedDayPredicate: (date) => controller.isTheSameDay(date),
                calendarFormat: controller.calendarFormat.value,
                eventLoader: (day) {
                  return controller.getEventsForDay(day);
                },
                onFormatChanged: (format) {
                  controller.calendarFormat.value = format;
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: HeaderStyle(),
                calendarStyle: CalendarStyle(
                  markerSize: 5,
                  markersAnchor: 2,
                  markerDecoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  canMarkersOverflow: true,
                  markersMaxCount: 1,
                ),
              )),
              (controller.showedEvent.isEmpty)
                  ? Text('No event')
                  : Text(controller.showedEvent.length.toString()),
            ],
          ),
        ),
      ],
    );
  }
}
