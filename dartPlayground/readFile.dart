import 'dart:convert';
import 'dart:io';

void main() {
  // path considerando que o projeto está aberto na pasta curso-flutter
  // final rootPath = Directory.current.path;

  bool isWindows = Platform.isWindows;
  String currentFile = Platform.script.toFilePath(windows: isWindows);
  RegExp regex =
      new RegExp(r"^(.*[\\\/])", caseSensitive: false, multiLine: false);
  final parentPath = regex.firstMatch(currentFile)?.group(0);

  final filePath = '${parentPath}dummy_data.json';
  // final filePath = '${parentPath}teste.txt';
  final file = File(filePath);

  readAsync(file);
  // readSync(file);
  // readSteam(file);
}

void readAsync(File file) async {
  String futureContent = await file.readAsString();
  print(futureContent);
}

void readSync(File file) {
  String contents = file.readAsStringSync();
  print(contents);
}

void readSteam(File file) {
  Stream<List<int>> stream = file.openRead();
  StringBuffer buffer = StringBuffer();

  stream.transform(utf8.decoder).listen(
    (data) {
      buffer.write(data);
    },
    onDone: () {
      print(buffer.toString());
    },
    onError: (e) => print(e),
  );
}
