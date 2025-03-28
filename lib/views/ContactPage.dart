import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// widget de la page de contact
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // retoune une scaffold contenant la structure de la page de contact
      appBar: AppBar(title: const Text("Contact")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        // formulaire 
        child: MyCustomForm(),
      ),
    );
  }
}

// widget du formulaire
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  // clé pour valider chaque formulaire
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // champ prénom
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Veuillez entrer votre nom' : null,
          ),

          const SizedBox(height: 16),

          // champ email
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            // vérifie que le mail respecte le format abc@abc.abc
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre adresse email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // champ message
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            validator: (value) =>
                value == null || value.isEmpty ? 'Veuillez entrer un message' : null,
          ),

          const SizedBox(height: 24),

          // bouton d'envoi du formulaire 
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String response =
                    'Nom: ${_nameController.text}, Email: ${_emailController.text}, Message: ${_messageController.text}';
                try {
                  final prefs = await SharedPreferences.getInstance();
                  List<String> responses = prefs.getStringList('contact_responses') ?? [];
                  responses.add(response);
                  await prefs.setStringList('contact_responses', responses);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message envoyé et enregistré localement !')),
                  );
                } catch (e) {
                  // message d'erreur
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur lors de l\'enregistrement: $e')),
                  );
                }
                // vide les champs du formulaire après l'envoi
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();
              }
            },
            child: const Text('Envoyer'),
          ),
        ],
      ),
    );
  }
}
