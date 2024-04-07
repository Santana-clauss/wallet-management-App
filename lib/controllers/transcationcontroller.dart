import 'package:get/get.dart';

class TransactionController extends GetxController {
  var transactions = [].obs;

  void updateWallets(List transactionList) {
    transactions.value = transactionList;
  }
}
