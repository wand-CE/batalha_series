import 'package:batalha_series/services/operations_firebase.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  final databaseOperations = DatabaseOperationsSqflite();

  Future<void> addSerie(serieMap) async {
    databaseOperations.addSerie(serieMap);
  }

  Future<List<dynamic>> getAllSeries() async {
    return databaseOperations.getAllSeries();
  }
}
