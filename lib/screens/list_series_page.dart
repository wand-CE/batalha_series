import 'package:batalha_series/controllers/database_controller.dart';
import 'package:batalha_series/controllers/get_series_controller.dart';
import 'package:batalha_series/models/serie_model.dart';
import 'package:batalha_series/screens/my_widgets/series_tile.dart';
import 'package:batalha_series/screens/register_serie_page.dart';
import 'package:batalha_series/services/operations_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListSeriesPage extends StatelessWidget {
  ListSeriesPage({super.key});

  final GetSeriesController getSeriesController =
      Get.find<GetSeriesController>();
  final DatabaseController databaseController = Get.find<DatabaseController>();

  @override
  Widget build(BuildContext context) {
    getSeriesController.getSeries();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Séries cadastradas'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (getSeriesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (getSeriesController.series.isEmpty) {
          return Center(child: Text("Nenhuma série encontrada."));
        }

        return ListView.builder(
          itemCount: getSeriesController.series.length,
          itemBuilder: (context, index) {
            SerieModel serie = getSeriesController.series[index];

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
                        databaseController
                            .removeSerie(int.parse('${serie.id}'));
                        getSeriesController.getSeries();
                      },
                      onCancel: () => Get.back(), // Apenas fecha o alerta
                    ));
          },
        );
      }),
      floatingActionButton: ElevatedButton(
        onPressed: () => Get.to(() => RegisterSeriePage()),
        child: Text('Adicionar Série'),
      ),
    );
  }
}
