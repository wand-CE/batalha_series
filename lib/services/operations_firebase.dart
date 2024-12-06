import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

class DatabaseOperationsSqflite extends GetConnect {
  late Database _db;
  final userId = 1;

  @override
  void onInit() {
    super.onInit();
    _initDatabase(); // Chame a inicialização do banco assim que o controlador for inicializado
  }

  // Inicializa o banco de dados local SQLite
  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_series.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Criação das tabelas
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE series(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            userId INTEGER,
            FOREIGN KEY(userId) REFERENCES users(id)
          );
        ''');
      },
    );
  }

  Future<Map<String, dynamic>> createNewUserAccount(
      String emailAddress, String password) async {
    bool isCreated = false;
    String message = "Não foi possível criar usuário";
    try {
      // Inserir usuário no banco de dados SQLite
      await _db.insert('users', {
        'email': emailAddress,
        'password': password,
      });
      isCreated = true;
      message = "Usuário criado com sucesso!";
    } catch (e) {
      message = 'Erro ao criar usuário: $e';
    }

    return {
      "isCreated": isCreated,
      "message": message,
    };
  }

  Future<Map<String, dynamic>> signInEmailPass(
      String emailAddress, String password) async {
    bool isLogged = false;
    String message = 'Não foi possível logar, tente novamente';
    try {
      final List<Map<String, dynamic>> user = await _db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [emailAddress, password],
      );

      if (user.isNotEmpty) {
        isLogged = true;
        message = "Seja bem-vindo!";
      } else {
        message = 'Usuário ou senha incorretos';
      }
    } catch (e) {
      message = 'Erro ao autenticar usuário: $e';
    }

    return {
      "isLogged": isLogged,
      "message": message,
    };
  }

  Future<void> logOutUser() async {
    // Como estamos usando SQLite, não precisamos de logout real aqui,
    // porque o login é apenas uma verificação no banco de dados.
  }

  Future<int> getCurrentUserId(String emailAddress) async {
    final List<Map<String, dynamic>> user = await _db.query(
      'users',
      where: 'email = ?',
      whereArgs: [emailAddress],
    );

    if (user.isNotEmpty) {
      return user.first['id'];
    }
    throw Exception('Usuário não encontrado');
  }

  Future<List<Map<String, dynamic>>> getMySeries(int userId) async {
    try {
      final List<Map<String, dynamic>> series = await _db.query(
        'series',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      return series;
    } catch (e) {
      throw Exception('Erro ao obter séries: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllSeries() async {
    try {
      final List<Map<String, dynamic>> series = await _db.query('series');
      return series;
    } catch (e) {
      throw Exception('Erro ao obter todas as séries: $e');
    }
  }

  Future<void> removeSerie(int idSerie) async {
    try {
      await _db.delete(
        'series',
        where: 'id = ?',
        whereArgs: [idSerie],
      );
    } catch (e) {
      throw Exception('Erro ao remover série: $e');
    }
  }

  Future<void> addSerie(Map<String, dynamic> serieMap) async {
    // Adiciona a série com um id de usuário
    serieMap['userId'] = '$userId';
    print('Mapa$serieMap');
    try {
      await _db.insert('series', serieMap);
    } catch (e) {
      throw Exception('Erro ao adicionar série: $e');
    }
  }

  // Inicializa o banco de dados quando a classe for instanciada
  DatabaseOperationsSqflite() {
    _initDatabase();
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// class DatabaseOperationsFirebase extends GetConnect {
//   final _db = FirebaseFirestore.instance;
//   final _dbAuth = FirebaseAuth.instance;
//
//   Future<Map<String, dynamic>> createNewUserAcoount(
//       String emailAddress, String password) async {
//     bool isCreated = false;
//     String message = "Não foi possível criar usuário";
//     try {
//       await _dbAuth.createUserWithEmailAndPassword(
//         email: emailAddress,
//         password: password,
//       );
//       isCreated = true;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         message = 'A senha é muito fraca';
//       } else if (e.code == 'email-already-in-use') {
//         message = 'Já existe uma conta com esse e-mail';
//       }
//     } catch (e) {
//       throw Exception('$e');
//     }
//
//     return {
//       "isCreated": isCreated,
//       "message": message,
//     };
//   }
//
//   Future<Map<String, dynamic>> signInEmailPass(
//       String emailAddress, String password) async {
//     bool isLogged = false;
//     String message = 'Não foi possível logar, tente novamente';
//     try {
//       await _dbAuth.signInWithEmailAndPassword(
//           email: emailAddress, password: password);
//       isLogged = !isLogged;
//       message = "Seja bem-vindo!";
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         message = 'Nenhum usuário com esse e-mail';
//       } else if (e.code == 'wrong-password') {
//         message = 'Senha ou e-mail incorretos';
//       }
//     }
//     return {
//       "isLogged": isLogged,
//       "message": message,
//     };
//   }
//
//   Future<void> logOutUser() async {
//     await _dbAuth.signOut();
//   }
//
//   String getCurrentUserId() {
//     return _dbAuth.currentUser!.uid;
//   }
//
//   Future<List<dynamic>> getMySeries() async {
//     List<Object> ListMySeries = [];
//     String idUser = getCurrentUserId();
//
//     try {
//       final querySeries = await _db
//           .collection("series")
//           .where("idUser", isEqualTo: idUser)
//           .get();
//
//       for (var doc in querySeries.docs) {
//         Map<String, dynamic> dictSeries = doc.data();
//         dictSeries['id'] = doc.id;
//         ListMySeries.add(dictSeries);
//       }
//       return ListMySeries;
//     } catch (e) {
//       throw Exception('Erro ao obter Series: $e');
//     }
//   }
//
//   Future<List<dynamic>> getAllSeries() async {
//     List<Object> ListSeries = [];
//
//     try {
//       final querySeries = await _db.collection("series").get();
//
//       for (var doc in querySeries.docs) {
//         Map<String, dynamic> dictSeries = doc.data();
//         dictSeries['id'] = doc.id;
//         ListSeries.add(dictSeries);
//       }
//       return ListSeries;
//     } catch (e) {
//       throw Exception('Erro ao obter Series: $e');
//     }
//   }
//
//   Future<void> removeSerie(String idSerie) async {
//     _db.collection("series").doc(idSerie).delete();
//   }
//
//   Future<void> addSerie(Map<String, dynamic> serieMap) async {
//     // serieMap['id'] = getCurrentUserId();
//     // por enquanto
//     serieMap['id'] = '1';
//     print(serieMap);
//     await _db.collection("series").add(serieMap);
//   }
//
// // Future<void> addSerie(Map<String, dynamic> serieMap) async {
// //   await _db.collection("series").add(serieMap);
// // }
//
// // Future<Map<String, dynamic>> addRemoveFavoriteCountry(String countryName,
// //     String countryFlag, String countryLatLng, String mapLink) async {
// //   final serieMap = {
// //     "idUser": getCurrentUserId(),
// //     "countryName": countryName,
// //     "countryFlag": countryFlag,
// //     "countryLatLng": countryLatLng,
// //     "countryLinkMap": mapLink,
// //   };
// //
// //   final countryExist = await isCountrySaved(countryName);
// //   final isSaved = countryExist["isSaved"];
// //   final docId = countryExist["docId"];
// //
// //   try {
// //     isSaved ? await removeFavorite(docId) : await addFavorite(serieMap);
// //     return {
// //       "message": isSaved
// //           ? "$countryName removido dos favoritos"
// //           : "$countryName salvo nos favoritos",
// //       "isSaved": !isSaved,
// //     };
// //   } catch (e) {
// //     throw Exception("Não foi possível adicionar país");
// //   }
// // }
//
// // Future<Map<String, dynamic>> isCountrySaved(String countryName) async {
// //   try {
// //     final queryCountry = await _db
// //         .collection("series")
// //         .where("idUser", isEqualTo: getCurrentUserId())
// //         .where("countryName", isEqualTo: countryName)
// //         .get();
// //     bool countrySaved = queryCountry.docs.isNotEmpty;
// //
// //     return {
// //       "isSaved": queryCountry.docs.isNotEmpty,
// //       "docId": countrySaved ? queryCountry.docs.first.id : null,
// //     };
// //   } catch (e) {
// //     throw Exception('Erro ao obter país: $e');
// //   }
// // }
// }
