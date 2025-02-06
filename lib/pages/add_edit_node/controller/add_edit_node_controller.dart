import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class  AddEditNodeController extends GetxController {
  var titleController = TextEditingController().obs;
  var contentController = TextEditingController().obs;
  var dateController = TextEditingController().obs;

  void updateTitle(String value) {
      titleController.value.text = value;
  }

  void updateContent(String value) {
    contentController.value.text = value;
  }

  void updateDate(String value) {
    dateController.value.text = value;
  }
}