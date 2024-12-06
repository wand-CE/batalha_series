import 'package:batalha_series/controllers/database_controller.dart';
import 'package:get/get.dart';

class MySeriesController extends GetxController {
  late DatabaseController databaseController = Get.find<DatabaseController>();

  var series = [
    {
      'nome': 'Breaking Bad',
      'genero': 'Crime, Drama, Thriller',
      'descricao':
          'Um professor de química se torna um fabricante de metanfetaminas.',
      'capaUrl':
          'https://image.tmdb.org/t/p/w500/zlD3vFO1xyiyQtsnFGMeC1B5vDP.jpg',
      'pontuacao': 9.5,
    },
    {
      'nome': 'Stranger Things',
      'genero': 'Drama, Fantasy, Horror',
      'descricao':
          'Um grupo de crianças enfrenta mistérios sobrenaturais na cidade de Hawkins.',
      'capaUrl':
          'https://image.tmdb.org/t/p/w500/qPfeJrFdknZT4JFSunfNRAHV5aS.jpg',
      'pontuacao': 8.8,
    },
  ].obs;
  var isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    isLoading(false);
    // getSeries(); // Carrega as séries quando o controlador estiver pronto
  }

  Future<void> getSeries() async {
    try {
      isLoading(true);
      await Future.delayed(Duration(seconds: 2));
      // final seriesFetched = await databaseController.getAllSeries();
      // series.assignAll(seriesFetched);

      print('ola');
    } finally {
      isLoading(false);
    }
  }
}
