import 'package:batalha_series/controllers/series_controller.dart';
import 'package:batalha_series/screens/list_series_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../controllers/my_animation_controller.dart';
import '../models/serie_model.dart';

class BattlePage extends StatelessWidget {
  // Instanciando o BattleController usando GetX
  final SeriesController seriesController = Get.find();
  final MyAnimationController myAnimationController = Get.find();

  @override
  Widget build(BuildContext context) {
    myAnimationController.startAnimation();
    seriesController.getSeries();
    seriesController.cleanBattleData();

    return Obx(() {
      if (myAnimationController.isAnimationVisible.value) {
        return Stack(children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: myAnimationController.toggleAnimation,
              child: Container(
                width: Get.width,
                height: Get.height,
                color: const Color(0xFF313131),
                child: RiveAnimation.asset(
                  'assets/rive/battle.riv',
                  fit: BoxFit.contain,
                  controllers: [
                    SimpleAnimation(
                      'State Machine 1',
                      autoplay: true,
                    )
                  ],
                ),
              ),
            ),
          ),
        ]);
      }

      return Scaffold(
        appBar: AppBar(title: Text('Batalha de Séries')),
        body: Center(
          // padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Dropdown para selecionar a série 1
              DropdownButton<SerieModel>(
                hint: Text('Selecione a Série 1'),
                value: seriesController.series
                        .contains(seriesController.selectedBattleSerie1.value)
                    ? seriesController.selectedBattleSerie1.value
                    : null,
                items: seriesController.series.map((serie) {
                  return DropdownMenuItem<SerieModel>(
                    value: serie,
                    child: Text(serie.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  seriesController.selectedBattleSerie1.value = value;
                },
              ),
              SizedBox(height: 20),
              // Dropdown para selecionar a série 2
              DropdownButton<SerieModel>(
                hint: Text('Selecione a Série 2'),
                value: seriesController.selectedBattleSerie2.value,
                items: seriesController.series.map((serie) {
                  return DropdownMenuItem<SerieModel>(
                    value: serie,
                    child: Text(serie.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  seriesController.selectedBattleSerie2.value = value;
                },
              ),
              SizedBox(height: 20),
              // Exibição dos detalhes da Série 1

              seriesController.selectedBattleSerie1.value != null
                  ? Column(
                      children: [
                        Text(
                            'Vencedora: ${seriesController.selectedBattleSerie1.value!.nome}'),
                        Text(
                            'Gênero: ${seriesController.selectedBattleSerie1.value!.genero}'),
                        Text(
                            'Descrição: ${seriesController.selectedBattleSerie1.value!.descricao}'),
                        Text(
                            'Pontuação: ${seriesController.selectedBattleSerie1.value!.pontuacao}'),
                        SizedBox(height: 20),
                      ],
                    )
                  : Container(),
              // Exibição dos detalhes da Série 2
              seriesController.selectedBattleSerie2.value != null
                  ? Column(
                      children: [
                        Text(
                            'Derrotada: ${seriesController.selectedBattleSerie2.value!.nome}'),
                        Text(
                            'Gênero: ${seriesController.selectedBattleSerie2.value!.genero}'),
                        Text(
                            'Descrição: ${seriesController.selectedBattleSerie2.value!.descricao}'),
                        Text(
                            'Pontuação: ${seriesController.selectedBattleSerie2.value!.pontuacao}'),
                        SizedBox(height: 20),
                      ],
                    )
                  : Container(),
              // Botão para escolher o vencedor
              ElevatedButton(
                onPressed: () async {
                  if (seriesController.selectedBattleSerie1.value != null &&
                      seriesController.selectedBattleSerie2.value != null) {
                    // O usuário escolhe o vencedor
                    // Aqui podemos adicionar um diálogo ou lógica extra para escolher
                    // Por exemplo, selecionamos manualmente a primeira série como vencedora
                    await seriesController.registerVictory(
                        seriesController.selectedBattleSerie1.value!);
                    Get.back();
                    seriesController.getSeries();
                    // Get.off(() =>ListSeriesPage());
                    Get.snackbar('Vitória!',
                        '${seriesController.selectedBattleSerie1.value!.nome} venceu!');
                  } else {
                    Get.snackbar('Batalha!', 'Selecione as duas séries');
                  }
                },
                child: Text('Registrar Vitória'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
