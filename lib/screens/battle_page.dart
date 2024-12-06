import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/battle_controller.dart';
import '../models/serie_model.dart';

class BattlePage extends StatelessWidget {
  // Instanciando o BattleController usando GetX
  final BattleController battleController = Get.find();

  @override
  Widget build(BuildContext context) {
    battleController.getSeries();
    print('${battleController.series}');

    return Scaffold(
      appBar: AppBar(title: Text('Batalha de Séries')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown para selecionar a série 1
            Obx(() {
              return DropdownButton<SerieModel>(
                hint: Text('Selecione a Série 1'),
                value: battleController.selectedSerie1.value,
                items: battleController.series.map((serie) {
                  return DropdownMenuItem<SerieModel>(
                    value: serie,
                    child: Text(serie.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  battleController.selectedSerie1.value = value;
                },
              );
            }),
            SizedBox(height: 20),
            // Dropdown para selecionar a série 2
            Obx(() {
              return DropdownButton<SerieModel>(
                hint: Text('Selecione a Série 2'),
                value: battleController.selectedSerie2.value,
                items: battleController.series.map((serie) {
                  return DropdownMenuItem<SerieModel>(
                    value: serie,
                    child: Text(serie.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  battleController.selectedSerie2.value = value;
                },
              );
            }),
            SizedBox(height: 20),
            // Exibição dos detalhes da Série 1
            Obx(() {
              if (battleController.selectedSerie1.value != null) {
                return Column(
                  children: [
                    Text(
                        'Vencedora: ${battleController.selectedSerie1.value!.nome}'),
                    Text(
                        'Gênero: ${battleController.selectedSerie1.value!.genero}'),
                    Text(
                        'Descrição: ${battleController.selectedSerie1.value!.descricao}'),
                    Text(
                        'Pontuação: ${battleController.selectedSerie1.value!.pontuacao}'),
                    SizedBox(height: 20),
                  ],
                );
              }
              return Container();
            }),
            // Exibição dos detalhes da Série 2
            Obx(() {
              if (battleController.selectedSerie2.value != null) {
                return Column(
                  children: [
                    Text(
                        'Derrotada: ${battleController.selectedSerie2.value!.nome}'),
                    Text(
                        'Gênero: ${battleController.selectedSerie2.value!.genero}'),
                    Text(
                        'Descrição: ${battleController.selectedSerie2.value!.descricao}'),
                    Text(
                        'Pontuação: ${battleController.selectedSerie2.value!.pontuacao}'),
                    SizedBox(height: 20),
                  ],
                );
              }
              return Container();
            }),
            // Botão para escolher o vencedor
            ElevatedButton(
              onPressed: () {
                if (battleController.selectedSerie1.value != null &&
                    battleController.selectedSerie2.value != null) {
                  // O usuário escolhe o vencedor
                  // Aqui podemos adicionar um diálogo ou lógica extra para escolher
                  // Por exemplo, selecionamos manualmente a primeira série como vencedora
                  battleController
                      .registerVictory(battleController.selectedSerie1.value!);
                  Get.snackbar('Vitória!',
                      '${battleController.selectedSerie1.value!.nome} venceu!');
                }
              },
              child: Text('Registrar Vitória'),
            ),
            SizedBox(height: 20),
            // Exibição do ranking
            Text('Ranking das Séries:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: battleController.ranking.length,
                  itemBuilder: (context, index) {
                    final serie = battleController.ranking[index];
                    return ListTile(
                      title: Text(serie.nome),
                      subtitle: Text('Pontuação: ${serie.pontuacao}'),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
