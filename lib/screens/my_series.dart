import 'package:batalha_series/controllers/get_series_controller.dart';
import 'package:batalha_series/controllers/my_series_controller.dart';
import 'package:batalha_series/screens/register_serie_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySeriesPage extends StatelessWidget {
  MySeriesPage({super.key});

  final MySeriesController mySeriesController = Get.find<MySeriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Séries'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (mySeriesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (mySeriesController.series.isEmpty) {
          return Center(child: Text("Nenhuma série encontrada."));
        }

        return ListView.builder(
          itemCount: mySeriesController.series.length,
          itemBuilder: (context, index) {
            var serie = mySeriesController.series[index];

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
      floatingActionButton:
          FloatingActionButton(onPressed: () => Get.to(RegisterSeriePage())),
    );
  }
}
