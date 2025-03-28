//main.dart//


import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'views/AProposPage.dart';
import 'views/ContactPage.dart';
import 'views/ArticlesPage.dart';

// init des plugins avant exécution de l'appli
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); //
  // sauvegarde le thème que l'utilisateur choisi (clair/sombre)
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

// Widget dans classe MyApp
class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
// constructeur du widget qui passe en paramètre le light/dark mode
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    // définition de la palette couleur pour le light et dark mode
    return AdaptiveTheme(
      light: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 95, 0, 172),
        ),
      ),
      dark: ThemeData.dark(),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
// Widget de la page d'accueil
class MyHomePage extends StatefulWidget {
  // title obligatoire passé en paramètre
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // scaffold pr structurer la page
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // menu drawer 
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 154, 89, 214)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // bouton pour changer le thème
            ListTile(
              title: const Text('Changer le thème'),
              onTap: () {
                // récupère le mode actuel et le change vers l'autre mode si le bouton "changer le thème" est cliqué)
                final mode = AdaptiveTheme.of(context).mode;
                if (mode.isLight) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
                // ferme le drawer lorsque le changement de thème est exécuté
                Navigator.pop(context);
              },
            ),
            ListTile(
              // accès à "à propos"
              title: const Text('À Propos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AProposSection()),
                );
              },
            ), // accès à "contact"
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactSection()),
                );
              },
            ), // accès à "articles"
            ListTile(
              title: const Text('Articles'),
              onTap: () {
                // navigation vers la page artcicles
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlesSection()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text("Contenu principal")),
    );
    
  }
  
}
