import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
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
          // --- Champ Nom ---
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

          // --- Champ Email ---
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
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

          // --- Champ Message ---
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

          // --- Bouton Envoyer ---
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur lors de l\'enregistrement: $e')),
                  );
                }
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
