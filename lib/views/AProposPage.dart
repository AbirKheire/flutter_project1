//views/AProposPage.dart// 

import 'package:flutter/material.dart';

// Classe AProposSection contenant un widget sans état (page "à propos")
class AProposSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //retourne une scaffold avec la structure du contenu
      appBar: AppBar(title: const Text("À Propos")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome to my nouvelle application codée en Dart + Flutter \n\n"
              "Elle se compose d'une section à propos et d'un formulaire de contact !",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Image.asset(
              'assets/OIP.jpeg',
              height: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
