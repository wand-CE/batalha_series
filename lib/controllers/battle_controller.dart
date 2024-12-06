import 'package:batalha_series/screens/home_page.dart';
import 'package:get/get.dart';

import '../models/serie_model.dart';
import 'database_controller.dart';

class BattleController extends GetxController {
  var selectedSerie1 = Rxn<SerieModel>(); // Serie selecionada para a batalha 1
  var selectedSerie2 = Rxn<SerieModel>(); // Serie selecionada para a batalha 2
  var ranking = <SerieModel>[].obs; // Ranking das séries baseado nas vitórias
  late DatabaseController databaseController = Get.find<DatabaseController>();

  var series = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getSeries();
  }

  Future<void> getSeries() async {
    try {
      isLoading(true);
      final seriesFetched = await databaseController.getSeries();
      series.assignAll(seriesFetched);
      print(series);
    } finally {
      isLoading(false);
    }
  }

  void cleanData() {
    selectedSerie1 = Rxn<SerieModel>();
    selectedSerie2 = Rxn<SerieModel>();
  }

  void registerVictory(SerieModel winner) async {
    winner.pontuacao += 1;

    await databaseController.updatePontuacao(winner);

    Get.to(() => HomePage());
    getSeries();
    cleanData();
  }
}
