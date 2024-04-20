import 'package:get/get.dart';
import 'package:flutter_app/model/transactionmodel.dart';

class TranscationController extends GetxController {
  var transcationList = <TransactionModel>[].obs;

  void updateTranscationList(List<TransactionModel> transactions) {
    transcationList.assignAll(transactions);
  }
}
