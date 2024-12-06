import 'package:batalha_series/models/serie_model.dart';
import 'package:batalha_series/screens/home_page.dart';
import 'package:get/get.dart';

import 'database_controller.dart';
import 'get_series_controller.dart';

class RegisterSerieController extends GetxController {
  var nome = ''.obs;
  var genero = ''.obs;
  var descricao = ''.obs;
  var pontuacao = ''.obs;
  var capaUrl = ''.obs;

  bool _isNumeric(String str) {
    if (str.isEmpty) return false;
    final num? n = num.tryParse(str);
    return n != null;
  }

  void setPontuacao(String value) {
    if (value.isEmpty) {
      pontuacao.value = '';
    } else {
      double? numValue = double.tryParse(value);
      if (numValue != null && numValue >= 1 && numValue <= 10) {
        pontuacao.value = value; // Atualiza a pontuação
      }
    }
  }

  // Método para salvar os dados
  Future<void> saveSerie() async {
    if (nome.value.isNotEmpty &&
        genero.value.isNotEmpty &&
        descricao.value.isNotEmpty &&
        pontuacao.value.isNotEmpty &&
        capaUrl.value.isNotEmpty) {
      final serieMap = {
        'nome': nome.value,
        'genero': genero.value,
        'descricao': descricao.value,
        'capaUrl': capaUrl.value,
        'pontuacao': pontuacao.value,
      };

      print('Valor ${pontuacao.value}');

      final databaseController = Get.find<DatabaseController>();

      final isSaved = await databaseController.addSerie(serieMap);

      if (isSaved) {
        final getSeriesController = Get.find<GetSeriesController>();
        getSeriesController.getSeries();
        Get.back();
        Get.snackbar("Série", "Série cadastrada com sucesso!");
        return;
      } else {
        Get.snackbar("Erro", "Não foi possível cadastrar a série!");
      }
    } else {
      Get.snackbar("Erro", "Preencha todos os campos!");
    }
  }
}
