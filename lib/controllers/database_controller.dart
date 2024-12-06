import 'package:batalha_series/services/operations_database.dart';
import 'package:get/get.dart';

import '../models/serie_model.dart';

class DatabaseController extends GetxController {
  final operationsDatabase = OperationsDatabase();

  Future<bool> addSerie(serieMap) async {
    return await operationsDatabase.addSerie(serieMap);
  }

  Future<bool> removeSerie(int idSerie) async {
    return await operationsDatabase.removeSerie(idSerie);
  }

  Future<List<SerieModel>> getSeries() async {
    return operationsDatabase.getSeries();
  }
}
