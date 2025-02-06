import 'package:get/get.dart';
import 'package:note/pages/add_edit_node/controller/add_edit_node_controller.dart';

class AddEditNodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditNodeController>(() => AddEditNodeController());
  }
}