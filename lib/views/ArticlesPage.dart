// views/ArticlesPage.dart//

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ArticleDetailPage.dart';

class ArticlesSection extends StatefulWidget {
  @override
  _ArticlesSectionState createState() => _ArticlesSectionState();
}

class _ArticlesSectionState extends State<ArticlesSection> {
  List articles = [];
  bool isLoading = true;

  int currentPage = 0;
  final int itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        articles = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Erreur lors du chargement des articles');
    }
  }

  // pagination des articles
  List get paginatedArticles {
    int start = currentPage * itemsPerPage;
    int end = start + itemsPerPage;
    return articles.sublist(
      start,
      end > articles.length ? articles.length : end,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = ((articles.length - 1) / itemsPerPage).ceil();

    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: paginatedArticles.length,
                    itemBuilder: (context, index) {
                      final article = paginatedArticles[index];
                      return ListTile(
                        title: Text(article['title']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailPage(article: article),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: currentPage > 0
                            ? () => setState(() => currentPage--)
                            : null,
                        child: const Text('Précédent'),
                      ),
                      Text('${currentPage + 1} / $totalPages'),
                      TextButton(
                        onPressed:
                            (currentPage + 1) * itemsPerPage < articles.length
                                ? () => setState(() => currentPage++)
                                : null,
                        child: const Text('Suivant'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
