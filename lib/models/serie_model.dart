class SerieModel {
  int? id;
  String nome;
  String genero;
  String descricao;
  String capaUrl;
  int pontuacao;

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
    int parseInt(dynamic value) => int.tryParse(value.toString()) ?? 0;

    int pontuacao = parseInt(map['pontuacao']);
    int id = parseInt(map['id']);

    return SerieModel(
      id: id,
      nome: map['nome'],
      genero: map['genero'],
      descricao: map['descricao'],
      capaUrl: map['capaUrl'],
      pontuacao: pontuacao,
    );
  }
}
