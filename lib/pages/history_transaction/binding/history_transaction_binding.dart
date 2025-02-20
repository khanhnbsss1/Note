import 'package:get/get.dart';
import 'package:note/pages/expense/controller/expense_controller.dart';
import 'package:note/pages/history_transaction/controller/history_transaction_controller.dart';

class HistoryTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryTransactionController>(() => HistoryTransactionController());
  }
}