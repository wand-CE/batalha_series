import 'dart:io';

class SerieModel {
  String idUser;
  String nome;
  String genero;
  String descricao;
  File? capa;
  String pontuacao;

  SerieModel({
    required this.idUser,
    required this.nome,
    required this.genero,
    required this.descricao,
    this.capa,
    required this.pontuacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'nome': nome,
      'genero': genero,
      'descricao': descricao,
      'capa': capa?.path,
      'pontuacao': pontuacao,
    };
  }

  factory SerieModel.fromMap(Map<String, dynamic> map) {
    return SerieModel(
      idUser: map['idUser'],
      nome: map['nome'],
      genero: map['genero'],
      descricao: map['descricao'],
      capa: map['capa'] != null ? File(map['capa']) : null,
      pontuacao: map['pontuacao'].toDouble(),
    );
  }
}
