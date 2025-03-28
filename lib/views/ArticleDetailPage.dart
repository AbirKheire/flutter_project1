// views/ArticleDetailPage.dart//

import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  final Map article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['title'])),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(article['body']),
      ),
    );
  }
}
