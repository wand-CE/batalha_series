import 'package:batalha_series/controllers/get_series_controller.dart';
import 'package:batalha_series/screens/my_series.dart';
import 'package:batalha_series/screens/register_serie_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GetSeriesController getSeriesController =
      Get.find<GetSeriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Menu'),
              leading: SizedBox(),
              centerTitle: true,
            ),
            body: ListView(
              children: [
                ElevatedButton.icon(
                  onPressed: () => Get.to(MySeriesPage()),
                  label: Text('Minhas Séries'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text('Gerar meu Relatório'),
                ),
                // ElevatedButton.icon(
                //   onPressed: () {},
                //   label: Text('Minhas Séries'),
                // ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Batalha de Séries'),
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
              var serie = getSeriesController.series[index];

              return ListTile(
                title: Text('${serie['nome']}'), // Nome da série
                subtitle: Text('${serie['descricao']}'), // Descrição da série
                trailing: Icon(Icons.arrow_forward), // ícone para ação
                onTap: () {
                  // Aqui você pode adicionar uma ação quando o item for tocado
                  print("Série selecionada: ${serie['name']}");
                },
              );
            },
          );
        }),
        floatingActionButton: ElevatedButton(
          onPressed: () => Get.to(RegisterSeriePage()),
          child: Text('Adicionar Série'),
        ));
  }
}
