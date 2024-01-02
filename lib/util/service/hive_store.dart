import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note/model/noteModel.dart';
import 'package:path_provider/path_provider.dart' as path;

import '../../controller/note_controler.dart';

class HiveService{
 static Future <void> init() async{
  final appDir = await path.getApplicationDocumentsDirectory(); 
  Hive.init(appDir.path);

  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  Get.put<NoteController>(NoteController(),tag: 'NoteController');
  // Get.find<NoteController>(tag: 'NoteController');
  }

 static Future<void> openBox<T>(String boxname) async{
      await Hive.openBox<T>(boxname);
 }

 static Future closeBox(boxname) async{
  await Hive.box(boxname).close();
 }


}