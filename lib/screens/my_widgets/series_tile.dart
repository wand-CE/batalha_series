import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/serie_model.dart';

class SeriesTile extends StatelessWidget {
  final SerieModel serie;
  final VoidCallback buttonFunction;
  final String defaultImageUrl;

  const SeriesTile({
    super.key,
    required this.serie,
    required this.buttonFunction,
    this.defaultImageUrl = 'https://via.placeholder.com/150', // Imagem padrão
  });

  @override
  Widget build(BuildContext context) {
    final isUrlValid = GetUtils.isURL(serie.capaUrl);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          leading: Image.network(
            isUrlValid ? serie.capaUrl : defaultImageUrl,
            width: 70,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.broken_image,
              size: 70,
              color: Colors.grey,
            ),
          ),
          title: Text(
            serie.nome,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gênero: ${serie.genero}"),
              SizedBox(height: 5),
              // Text("Descrição: ${serie.descricao}"),
              // SizedBox(height: 10),
              Text("Pontuação: ${serie.pontuacao}"),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: buttonFunction,
          ),
        ),
      ),
    );
  }
}
