import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/config/app_config.dart';
import 'package:note/model/list_note.dart';
import 'package:note/util/date_utils.dart';

class  AddEditNodeController extends GetxController {
  var titleController = TextEditingController().obs;
  var contentController = TextEditingController().obs;
  var dateController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onInitNote(NoteDetail? note) {
    titleController.value.text = note?.title ?? "";
    contentController.value.text = note?.content ?? "";
    dateController.value.text = DateUtilsFormat.toDateAPIString(note?.time ?? DateTime.now(), format: AppConfigs.dateTimeDisplayFormat1);
  }
}