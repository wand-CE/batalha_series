import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_serie_controller.dart';

class RegisterSeriePage extends StatelessWidget {
  const RegisterSeriePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterSerieController registerSerieController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre uma série'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  registerSerieController.nome.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                onChanged: (value) {
                  registerSerieController.genero.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Gênero',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                onChanged: (value) {
                  registerSerieController.descricao.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                onChanged: (value) {
                  registerSerieController.capaUrl.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Url da Capa',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  registerSerieController.pontuacao.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Pontuação',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: registerSerieController.salvarSerie,
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
