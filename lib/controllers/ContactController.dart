import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ContactController {
  // méthode GET async qui récupère le chemin du répértoire local et renvoie le chemin 
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  // méthode GET async qui renvoie un objet <File> et qui renvoie le chemoin vers le fichier ou se trouvent les réponses du formulaire stockées
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/contact_responses.txt');
  }
  // GET async qui sauvegarde les réponses du formulaire dans un fichier en local
  Future<File> saveResponse(String response) async {
    final file = await _localFile;
    // copie la réponse dans le fichier + saut de ligne entre chaque réponse
    return file.writeAsString(response + '\n', mode: FileMode.append);
  }
}
