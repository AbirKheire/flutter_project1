//controllers/ArticleController.dart//

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/ArticleModel.dart';

class ArticleController {
  // méthode future asynchrone permettant de récuprér la liste des articles
  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  // vérif du statut (200 OK) et coversion des éléments JSON -> objet dart
    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } else {
      // message de gestion des erreurs
      throw Exception('Erreur lors du chargement des articles');
    }
  }
}
