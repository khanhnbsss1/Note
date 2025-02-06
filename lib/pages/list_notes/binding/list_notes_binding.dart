import 'package:get/get.dart';
import 'package:note/pages/list_notes/controller/list_notes_controller.dart';

class ListNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListNotesController>(() => ListNotesController());
  }
}