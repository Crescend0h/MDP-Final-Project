import 'package:dio/dio.dart';
import 'package:finalproject/Models/item.dart';
import 'package:flutter/material.dart';

const String BaseUrl = "https://collectionapi.metmuseum.org/public/collection/v1/objects";
//Sending just the baseURL will return a long list of itemIDs and nothing else.
//Regrettably, this means making a lot of API calls to fill out a page with details.
//Not much I can do about it with how the API is structured.

class MuseumAPIClient {
  final _dio = Dio(BaseOptions(baseUrl: BaseUrl));

  Future<Item?> GetMuseumItem(int id, BuildContext context) async {
    try 
    {
      var response = await _dio.get(BaseUrl + "/" + id.toString());
      var data = response.data;
      Item item = Item(data['objectID'], data['department'], data['title'], data['medium'], data['objectName'], context);
      return item;
    }
    catch (error) 
    {
      print(error);
      return null;
    }
  }
}
