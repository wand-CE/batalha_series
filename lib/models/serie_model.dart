import 'dart:io';
import 'package:get/get.dart';

class SerieModel {
  int? id;
  String nome;
  String genero;
  String descricao;
  String capaUrl;
  double pontuacao;

  SerieModel({
    this.id,
    required this.nome,
    required this.genero,
    required this.descricao,
    required this.capaUrl,
    required this.pontuacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'genero': genero,
      'descricao': descricao,
      'capaUrl': capaUrl,
      'pontuacao': pontuacao,
    };
  }

  factory SerieModel.fromMap(Map<String, dynamic> map) {
    return SerieModel(
      id: map['id'],
      nome: map['nome'],
      genero: map['genero'],
      descricao: map['descricao'],
      capaUrl: map['capaUrl'],
      pontuacao: map['pontuacao'].toDouble(),
    );
  }
}
