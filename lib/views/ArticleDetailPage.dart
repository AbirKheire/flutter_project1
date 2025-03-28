// views/ArticleDetailPage.dart//

import 'package:flutter/material.dart';

// classe ArticleDetailpage contenant un widget stateless (page détail des articles)
class ArticleDetailPage extends StatelessWidget {
  final Map article;

// constructeur avec propriété "article" obligatoire
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
  // le widget retourne une scaffold contenant la structure de la page ArticleDetailPage
    return Scaffold(
      appBar: AppBar(title: Text(article['title'])),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(article['body']),
      ),
    );
  }
}
