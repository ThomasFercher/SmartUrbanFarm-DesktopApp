import 'dart:io';

class FileService {
  String dirPath = "/home/thomas/Pictures";

  List<File> getFileList() {
    if (FileSystemEntity.isDirectorySync(dirPath)) {
      Directory dir = new Directory(dirPath);
      List<FileSystemEntity> entities = dir.listSync(recursive: false);

      List<File> files = entities.map((ent) {
        if (FileSystemEntity.isFileSync(ent.path)) {
          if (ent.path.contains(".jpeg")) {
            return File(ent.path);
          }
        }
      }).toList();

      return files;
    }
  }

  void deleteFile(File file) {
    file.deleteSync();
  }
}
