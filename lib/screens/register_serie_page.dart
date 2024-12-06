import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_serie_controller.dart';

class RegisterSeriePage extends StatelessWidget {
  RegisterSeriePage({super.key});

  final List<String> generos = [
    'Ação',
    'Comédia',
    'Drama',
    'Romance',
    'Terror',
    'Ficção Científica'
  ];

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
          child: Form(
            key: registerSerieController.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: registerSerieController.nomeController,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome não pode estar vazio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: 'Selecione um Gênero',
                      border: OutlineInputBorder(),
                    ),
                    items: generos.map((genero) {
                      return DropdownMenuItem(
                        value: genero,
                        child: Text(genero),
                      );
                    }).toList(),
                    value: registerSerieController.generoController.text.isEmpty
                        ? null // Se não tiver valor selecionado, exibe null
                        : registerSerieController.generoController.text,
                    onChanged: (newValue) {
                      // Atualiza o controlador com o valor selecionado
                      if (newValue != null) {
                        registerSerieController.generoController.text =
                            newValue;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione um gênero';
                      }
                      return null;
                    }),
                SizedBox(height: 15),
                TextFormField(
                  controller: registerSerieController.descricaoController,
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A Descrição não pode estar vazia';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: registerSerieController.capaUrlController,
                  decoration: InputDecoration(
                    hintText: 'Url da Capa',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A URL não pode estar vazia';
                    }
                    // if (!GetUtils.isURL(value)) {
                    //   return 'Por favor, insira uma URL válida';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: registerSerieController.saveSerie,
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
      ),
    );
  }
}
