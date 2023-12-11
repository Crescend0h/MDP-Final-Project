import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService {
  FlutterSecureStorage SecureStorage = const FlutterSecureStorage();

  ///Stores a string in secure storage
  Future<bool> AddItem(String key, String value) async {
    try {
      if(await SecureStorage.read(key: key) == null) 
      {
        await SecureStorage.write(key: key, value: value);
        print("Added item.");
        return true;
      }
      else{
        return false;
      }
    }
    catch(error) {
      print(error);
      return false;
    }
  }

  ///Returns the requested value by key from secure storage
  Future<String?> TryGetItem(String Akey) async {
    try {
      String? item =  await SecureStorage.read(key: Akey);
      return item;
    } catch(error) {
      print(error);
      return null;
    }
  }
}