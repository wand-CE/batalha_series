import 'package:batalha_series/controllers/get_series_controller.dart';
import 'package:batalha_series/screens/battle_page.dart';
import 'package:batalha_series/screens/list_series_page.dart';
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
      appBar: AppBar(
        title: const Text('Batalha de Séries'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ListView(
          children: [
            ElevatedButton.icon(
              onPressed: () => Get.to(() => ListSeriesPage()),
              label: Text('Ranking'),
            ),
            ElevatedButton.icon(
              onPressed: () => Get.to(() => BattlePage()),
              label: Text('Batalhar'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text('Gerar Relatório'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => RegisterSeriePage()),
              child: Text('Adicionar Série'),
            )
            // ElevatedButton.icon(
            //   onPressed: () {},
            //   label: Text('Minhas Séries'),
            // ),
          ],
        ),
      ),
    );
  }
}
