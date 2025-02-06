import 'package:get/get.dart';
import 'package:note/pages/calendar/controller/calender_controller.dart';

class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalenderController>(() => CalenderController());
  }
}