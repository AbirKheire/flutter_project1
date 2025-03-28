//controllers/ArticleController.dart//

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/ArticleModel.dart';

class ArticleController {
  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors du chargement des articles');
    }
  }
}
