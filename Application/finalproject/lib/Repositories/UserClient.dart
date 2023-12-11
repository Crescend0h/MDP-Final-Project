import 'dart:ffi';

import 'package:finalproject/Models/AuthResponse.dart';
import '../Models/LoginStructure.dart';
import 'package:dio/dio.dart';
import './DataService.dart';
import '../Models/User.dart';

const String BaseUrl = "https://catfact.ninja";

class UserClient {
  final _dio = Dio(BaseOptions(baseUrl: BaseUrl));
  DataService _dataService = DataService();

//Login protocols for API integration.
  Future<AuthResponse?> Login(LoginStructure user) async {
    try {
      var response = await _dio.post("/login",
          data: {"username": user.username, "password": user.password});

      var data = response.data['data'];

      var authResponse = new AuthResponse(data['userId'], data['token']);

      if(authResponse.token != null) 
      {
        await _dataService.AddItem("token", authResponse.token);
      }

      return authResponse;
    } catch (error) {
      print(error);
      return null;
    }
  }
  Future<List<User>?> GetUsersAsync() async {
    try{
      var token = await _dataService.TryGetItem("token");
      if (token != null) {
        var response = await _dio.get("/GetUsers",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        })
        );
        List<User> users = new List.empty(growable: true);

        if (response != null)
        {
          for (var user in response.data)
          {
            users.add(User(user["_id"], user["Username"], user["Password"], user["Email"], user["AuthLevel"]));
          }

          return users;
        }
      } else {
        return null;
      }
    }
    catch(error) {
      print(error);
      return null;
    }
  }
  //Login protocols for non-API login.
  Future<int?> LoginNoAPI(LoginStructure user) async {
    try {
      AddDefaultUser();
      //Check for a username
      var response = await _dataService.TryGetItem(user.username);
      String retirevedPW = response.toString();
      if (response == null)
      {
        return 0;
      }
      else 
      {
        if (response == user.password)
        {
          return 2;
        }
        else {
          return 1;
        }
      }
    }
    catch(error) {
      print(error);
      return null;
    }
  }

  ///Add a default user to the DataService.
  void AddDefaultUser() {
    _dataService.AddItem('admin', 'password');
  }

  Future<String> GetAPIVersion() async {
    var response = await _dio.get("/ApiVersion");
    return response.data;
  } 
}
