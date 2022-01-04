import 'package:hive/hive.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';

abstract class HiveHelper {
  static Future<Box> openHiveBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  static void putIntoBox(dynamic key, dynamic value, String boxName) {
    var box = Hive.box(boxName);
    box.put(key, value);
    print(box.length);
  }

  static dynamic getFromBox(dynamic key, String boxName) {
    var box = Hive.box(boxName);
    return box.get(key);
  }

  static Map<int, Wallpaper> getAllBoxData(String boxName) {
    var box = Hive.box(boxName);
    Map<int, Wallpaper> extractedData = {};
    box.toMap().forEach((key, value) {
      extractedData[key] = value;
    });
    return extractedData;
  }

  static void removeFromBox(dynamic key, String boxName) {
    var box = Hive.box(boxName);
    box.delete(key);
    print(box.length);
  }
}
