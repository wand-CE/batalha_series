import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'database_controller.dart';
import 'series_controller.dart';

class RegisterSerieController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController generoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController pontuacaoController = TextEditingController();
  TextEditingController capaUrlController = TextEditingController();

  bool _isNumeric(String text) {
    if (text.isEmpty) return false;
    final num? newNumber = num.tryParse(text);
    return newNumber != null;
  }

  void cleanFields() {
    nomeController.text = '';
    generoController.text = '';
    descricaoController.text = '';
    capaUrlController.text = '';
  }

  // Método para salvar a série no banco de dados
  Future<void> saveSerie() async {
    if (formKey.currentState?.validate() ?? false) {
      final serieMap = {
        'nome': nomeController.text,
        'genero': generoController.text,
        'descricao': descricaoController.text,
        'capaUrl': capaUrlController.text,
        'pontuacao': '0',
      };

      final databaseController = Get.find<DatabaseController>();

      final isSaved = await databaseController.addSerie(serieMap);

      if (isSaved) {
        final getSeriesController = Get.find<SeriesController>();
        getSeriesController.getSeries();
        Get.back();
        Get.snackbar("Série", "Série cadastrada com sucesso!");
        cleanFields();
        return;
      } else {
        Get.snackbar("Erro", "Não foi possível cadastrar a série!");
      }
    } else {
      Get.snackbar("Erro", "Arrume os erros necessários!");
    }
  }
}
