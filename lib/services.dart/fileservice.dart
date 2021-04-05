import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {
  static final String dirPath = "/home/pi/Pictures";

  static Future<List<File>> getFileList() async {
    /* if (!FileSystemEntity.isDirectorySync(dirPath)) {
      return [];
    }*/
    Directory dir = new Directory(dirPath);
    dir = await getApplicationDocumentsDirectory();
    dir = new Directory("${dir.path}/sufphotos");
    List<FileSystemEntity> entities = dir.listSync(recursive: false);
    List<File> files = [];
    files = entities.map((ent) {
      if (FileSystemEntity.isFileSync(ent.path)) {
        return File(ent.path);
      }
    }).toList();

    print(files);
    return files;
  }

  static void deleteFile(File file) {
    file.deleteSync();
  }
}
