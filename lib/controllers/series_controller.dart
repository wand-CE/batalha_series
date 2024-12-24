import 'package:batalha_series/controllers/database_controller.dart';
import 'package:get/get.dart';

import '../models/serie_model.dart';

class SeriesController extends GetxController {
  var selectedBattleSerie1 = Rxn<SerieModel>();
  var selectedBattleSerie2 = Rxn<SerieModel>();

  late DatabaseController databaseController = Get.find<DatabaseController>();

  var series = [].obs;
  var isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    getSeries(); // Carrega as séries quando o controlador estiver pronto
  }

  Future<void> getSeries() async {
    try {
      isLoading(true);
      final seriesFetched = await databaseController.getSeries();
      series.assignAll(seriesFetched);
    } finally {
      isLoading(false);
    }
  }

  void cleanBattleData() {
    selectedBattleSerie1.value = null;
    selectedBattleSerie2.value = null;
  }

  Future<void> registerVictory(SerieModel winner) async {
    winner.pontuacao += 1;

    await databaseController.updatePontuacao(winner);

    getSeries();
    cleanBattleData();
  }
}
