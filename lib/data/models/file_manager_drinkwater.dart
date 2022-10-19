// import 'dart:io';

// import 'package:path_provider/path_provider.dart';



// class FileManager {
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }

//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/drinkwater.json');
//   }
//   Future<File?> writeJsonV3(DataModelDrinkWater model) async {
//     try {
//       final file = await _localFile;
//       // Write the file
//       print("OK");
//       // dataModelStravaToJson(model);
//       return file.writeAsString(dataModelDrinkWaterToJson(model));
//     } catch (e) {
//       print("Expcetion: "+e.toString());
//     }
//     return null;
//   }
//   writeFileV4(DataModelDrinkWater model,String nameFile) async {
//   final Directory directory = await getApplicationDocumentsDirectory();
//   final File file = File('${directory.path}/$nameFile.json');
//   await file.writeAsString(dataModelDrinkWaterToJson(model));
// }
//  writeFileV5(String nameFile) async {
//   final Directory directory = await getApplicationDocumentsDirectory();
//   final File file = File('${directory.path}/abc.json');
//   await file.writeAsString(nameFile);
// }

//   String idGenerator() {
//     final now = DateTime.now();
//     return now.microsecondsSinceEpoch.toString();
//   }
// }
