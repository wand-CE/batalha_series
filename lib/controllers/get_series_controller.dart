import 'package:batalha_series/controllers/database_controller.dart';
import 'package:get/get.dart';

class GetSeriesController extends GetxController {
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
      await Future.delayed(Duration(seconds: 2));
      final seriesFetched = await databaseController.getSeries();
      series.assignAll(seriesFetched);
    } finally {
      isLoading(false);
    }
  }
}
