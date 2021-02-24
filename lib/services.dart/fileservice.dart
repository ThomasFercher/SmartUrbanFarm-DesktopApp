import 'dart:io';

class FileService {
  static final String dirPath = "/home/pi/Pictures";

  static List<File> getFileList() {
    
    if (!FileSystemEntity.isDirectorySync(dirPath)) {
      return [];
    }
    Directory dir = new Directory(dirPath);
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
