//models/ArticleModel.dart//

// classe Article définie avec ses propriétés
class Article {
  final int id;
  final String title;
  final String body;

// constructeur de la classe Article
  Article({required this.id, required this.title, required this.body});

// instance  de la classe Article
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

// méthode pour convertir un Article en format Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
