import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ContactController {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/contact_responses.txt');
  }

  Future<File> saveResponse(String response) async {
    final file = await _localFile;
    // On ajoute la réponse à la fin du fichier
    return file.writeAsString(response + '\n', mode: FileMode.append);
  }
}
