import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:note/config/app_config.dart';
import 'package:note/pages/calendar/controller/calender_controller.dart';
import 'package:note/util/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalenderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
                () => Container(
              color: Colors.transparent,
              child: Flexible(
                  child: TableCalendar(
                    onCalendarCreated: (_) {
                      controller.onInit();
                    },
                    rowHeight: 60,
                    firstDay: controller.today.subtract(Duration(days: 10000)),
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
                    headerStyle: HeaderStyle(
                      titleTextFormatter: (date, _) {
                        return DateUtilsFormat.toDateAPIString(date,
                            format: AppConfigs.monthYearDisplay);
                      },
                    ),
                    calendarStyle: CalendarStyle(
                      markerSize: 5,
                      markersAnchor: 2,
                      markerDecoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      canMarkersOverflow: true,
                      markersMaxCount: 1,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Obx(
                () => (controller.showedEvent.isEmpty)
                ? Text('No event')
                : ListView.separated(
                itemCount: controller.showedEvent.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Container(
                    height: 20.h,
                  );
                },
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    color: controller.showedEvent[index].done == true ? Colors.green : Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(controller.showedEvent[index].title ?? ""),
                            Text(controller.showedEvent[index].content ?? ""),
                          ],
                        ),
                        Spacer(),
                        Text((controller.showedEvent[index].time)!
                            .toDateAPIString()),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}