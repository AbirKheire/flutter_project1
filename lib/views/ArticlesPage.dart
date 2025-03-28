// views/ArticlesPage.dart//

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ArticleDetailPage.dart';

// class ArticleSection contenant un widget qui affiche la liste des articles
class ArticlesSection extends StatefulWidget {
  @override
  _ArticlesSectionState createState() => _ArticlesSectionState();
}

class _ArticlesSectionState extends State<ArticlesSection> {
  // liste les articles récupérés depuis l'API externe  et les stock
  List articles = [];
  bool isLoading = true;
  // variable qui gère le nb d'articles affichés par page (pagination)
  int currentPage = 0;
  final int itemsPerPage = 10;

// initialisation du widget
  @override
  void initState() {
    super.initState();
  // récupère les articles
    fetchArticles();
  }
// fonction future async permettant de récupérer les artciles depuis l'API externe
  Future<void> fetchArticles() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
        // vérifie le status code de la réponse
    if (response.statusCode == 200) {
      // modifie l'état du widget et convertis la réponse Json
      setState(() {
        articles = json.decode(response.body);
        isLoading = false;
      });
      // Message de gestiond es erreurs
    } else {
      throw Exception('Erreur lors du chargement des articles');
    }
  }

  // GET qui renvoie la pagination des articles
  List get paginatedArticles {
  // Calcule pour définir le nb d'articles à afficher par page (max défini par la var "itemsperpage")
    int start = currentPage * itemsPerPage;
    int end = start + itemsPerPage;
    return articles.sublist(
      start,
      end > articles.length ? articles.length : end,
    );
  }

  @override
  Widget build(BuildContext context) {
    // calcul  nb de pages en fonction du nb d'articles
    final int totalPages = ((articles.length - 1) / itemsPerPage).ceil();
 // le widget retourne une scaffold avec la strucutre de la page
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
                        // clic -> renvoie vers la page de détail des articles
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
