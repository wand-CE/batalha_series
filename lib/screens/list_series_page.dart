import 'package:batalha_series/controllers/database_controller.dart';
import 'package:batalha_series/controllers/series_controller.dart';
import 'package:batalha_series/models/serie_model.dart';
import 'package:batalha_series/screens/my_widgets/series_tile.dart';
import 'package:batalha_series/screens/register_serie_page.dart';
import 'package:batalha_series/services/print_ranking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'battle_page.dart';

class ListSeriesPage extends StatelessWidget {
  ListSeriesPage({super.key});

  final SeriesController seriesController = Get.find<SeriesController>();
  final DatabaseController dbController = Get.find<DatabaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        actions: [
          Obx(
            () => seriesController.series.isEmpty
                ? IconButton(
                    onPressed: () => Get.snackbar(
                      "Sem séries cadastradas",
                      "Cadastre uma série para imprimir!",
                    ),
                    icon: const Icon(Icons.print_disabled),
                  )
                : IconButton(
                    onPressed: PrintRanking.generatePdfAndPrint,
                    icon: Icon(Icons.print),
                  ),
          )
        ],
      ),
      body: Obx(() {
        if (seriesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (seriesController.series.isEmpty) {
          return Center(child: Text("Nenhuma série encontrada."));
        }

        return ListView.builder(
          itemCount: seriesController.series.length,
          itemBuilder: (context, index) {
            SerieModel serie = seriesController.series[index];

            return SeriesTile(
                serie: serie,
                buttonFunction: () => Get.defaultDialog(
                      title: "Confirmação",
                      middleText:
                          "Tem certeza de que deseja excluir a série '${serie.nome}'?",
                      textConfirm: "Sim",
                      textCancel: "Não",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.back();
                        dbController.removeSerie(int.parse('${serie.id}'));
                        seriesController.getSeries();
                      },
                    ));
          },
        );
      }),
      // floatingActionButton:
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            bottom: 80.0, // Posição do botão "Adicionar série"
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () => Get.to(() => RegisterSeriePage()),
              icon: Icon(Icons.add),
              label: Text(
                'Adicionar série',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.deepPurple,
              // Cor do botão
              foregroundColor: Colors.white,
              // Cor do texto e ícone
              heroTag: 'fabAddSeries', // Identificador único
            ),
          ),
          Positioned(
            bottom: 20.0, // Posição do botão "Batalhar"
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () => seriesController.series.length < 2
                  ? Get.snackbar(
                      "Batalha",
                      "Cadastre pelo menos duas séries para batalhar!",
                    )
                  : Get.to(() => BattlePage()),
              icon: Icon(Icons.sports_martial_arts),
              label: Text(
                'Batalhar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.redAccent,
              // Cor do botão
              foregroundColor: Colors.white,
              // Cor do texto e ícone
              heroTag: 'fabBattle', // Identificador único
            ),
          ),
        ],
      ),
    );
  }
}
