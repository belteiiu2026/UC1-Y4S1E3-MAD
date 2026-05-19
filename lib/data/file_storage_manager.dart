
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {

  static final FileStorageManager instance = FileStorageManager._init();

  FileStorageManager._init();

  Future<void> onFileCreation() async {
    final appDoc = await getApplicationDocumentsDirectory();
    String path = appDoc.path;
    final  file = File("${path}/visitme.txt");
    if(await file.exists() == false){
      await file.create(recursive:  true);
      print("File is created...");
    }
  }

  Future<void> orderProduct() async {
    final appDoc = await getApplicationDocumentsDirectory();
    String path = appDoc.path;
    final  file = File("${path}/visitme.txt");
    String order1 = "productId=1,price=2,qty=3"+"\n";
    String order2 = "productId=2,price=5,qty=1"+"\n";
    await file.writeAsString(order1, mode: FileMode.append);
    await file.writeAsString(order2, mode: FileMode.append);
  }

  Future<void> getOrderProduct() async {
    final appDoc = await getApplicationDocumentsDirectory();
    String path = appDoc.path;
    final  file = File("${path}/visitme.txt");
    List<String> data =  await file.readAsLines();
    // print("data $data");
    for(String s in data){
      print("Items : $s");
    }
  }

}