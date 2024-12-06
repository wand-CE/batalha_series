import 'package:batalha_series/models/serie_model.dart';
import 'package:batalha_series/screens/home_page.dart';
import 'package:get/get.dart';

import 'database_controller.dart';

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
      if (numValue != null && numValue >= 1 && numValue <= 5) {
        pontuacao.value = value; // Atualiza a pontuação
      }
    }
  }

  // Método para salvar os dados
  Future<void> salvarSerie() async {
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

      final firebaseController = Get.find<DatabaseController>();

      await firebaseController.addSerie(serieMap);

      await Future.delayed(Duration(seconds: 2));

      Get.to(HomePage());

      Get.snackbar("Série", "Série cadastrada com sucesso!");
    } else {
      Get.snackbar("Erro", "Preencha todos os campos!");
    }
  }
}
