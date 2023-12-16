import 'package:flutter/material.dart';
import '../Models/item.dart';

class DLIHandler {
  Widget GetShortList(List<Item> items) {
    List<Widget> widgetList = List.empty(growable: true);
    for(var i = 0; i < items.length; i++) {
      widgetList.add(items[i].listItemSmall());
    }
    return Column(children: widgetList);
  }
}