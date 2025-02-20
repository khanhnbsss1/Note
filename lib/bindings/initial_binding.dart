import 'package:get/get.dart';
import 'package:note/pages/calendar/binding/calender_binding.dart';
import 'package:note/pages/expense/binding/expense_binding.dart';
import 'package:note/pages/history_transaction/binding/history_transaction_binding.dart';
import 'package:note/pages/list_notes/binding/list_notes_binding.dart';
import 'package:note/pages/profile/binding/profile_binding.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    ListNotesBinding().dependencies();
    CalenderBinding().dependencies();
    ProfileBinding().dependencies();
    ExpenseBinding().dependencies();
    HistoryTransactionBinding().dependencies();
  }
}
