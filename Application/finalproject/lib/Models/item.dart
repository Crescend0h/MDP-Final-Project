import 'package:finalproject/Views/itemdetail.dart';
import 'package:flutter/material.dart';

//This version of the item is nullable. It lacks functionality and I mostly use it to store data.
class Item {
  int itemID = 0;
  String department = "";
  String title = "";
  String medium = "";
  String objectName = "";
  BuildContext context;

  Item(this.itemID, this.department, this.title, this.medium, this.objectName,
      this.context);

  void onClickDetails() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ItemDetailsPage(loadedItem: this)));
  }

  //used for list view
  Widget listItemSmall() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: onClickDetails,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: [
                  Text("Item ID: " + itemID.toString(),
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Text("Title: " + title, 
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Text("Department: " + department + "   ",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Text("Medium: " + medium + "   ",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              const Divider()
            ])));
  }

//Used for detailed view
  Widget listItemLarge() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(children: [
        Text("Item ID: " + itemID.toString(),
            style: TextStyle(
              fontSize: 18,
            )),
        Text("Department: " + department, style: TextStyle(fontSize: 18)),
        Text("Title: " + title,
            style: TextStyle(fontSize: 18)),
        Text("Medium:" + medium, style: TextStyle(fontSize: 18)),
        Text("Object Name: " + objectName, style: TextStyle(fontSize: 18))
      ]),
    );
  }
}
