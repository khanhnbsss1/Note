import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:note/config/app_config.dart';
import 'package:note/pages/calendar/controller/calender_controller.dart';
import 'package:note/style/styles.dart';
import 'package:note/util/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin{
  CalenderController controller = Get.find();
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  Widget build(BuildContext context) {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )..toggle();

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
                () => TableCalendar(
                  // calendarBuilders: CalendarBuilders(
                  // singleMarkerBuilder: (context, date, _) {
                  //   return Container(
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: date == controller.selectedDay.value ? Colors.white : Colors.black),
                  //     width: 5.0,
                  //     height: 5.0,
                  //     margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  //   );
                  // },
                  // ),
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
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SizeTransition(
                      axis: Axis.horizontal,
                      sizeFactor: _animation!,
                      child: AnimatedContainer(
                        // width: 100,
                        decoration: BoxDecoration(
                          color: controller.showedEvent[index].done == true ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.all(12.0),
                        duration: Duration(milliseconds: 100),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(controller.showedEvent[index].title ?? "", style: AppTextStyle.heading4,maxLines: 1,overflow: TextOverflow.fade, ),
                                  Text(controller.showedEvent[index].content ?? "", maxLines: 1,overflow: TextOverflow.fade, ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text((controller.showedEvent[index].time)!
                                    .toDateAPIString(), maxLines: 1, overflow: TextOverflow.fade,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}