import 'package:flutter/material.dart';
import 'package:finalproject/Repositories/MuseumAPIClient.dart';
import '../Models/item.dart';
import '../Repositories/DLIHandler.dart';

class itemListPage extends StatefulWidget {
  itemListPage({super.key});
  final MuseumAPIClient museumAPIClient = new MuseumAPIClient();
  final DLIHandler dliHandler = new DLIHandler();
  List<Item> listItems = List<Item>.empty(growable: true);

  @override
  State<itemListPage> createState() => _itemListPageState();
}

class _itemListPageState extends State<itemListPage> {
  bool isLoading = false;
  bool isFirstLoad = true;

  void loadDataButton() {
    setState(() {
      isLoading = true;
      isFirstLoad = false;
    });
    buildList(200);
  }

  void buildList(int index) async {
    try {
      int i = index - 10;
      if (i < 0) {
        i = 0;
      } else if (i > 485906) {
        i = 485906;
      }
      while (widget.listItems.length < 10) {
        Item? item = await widget.museumAPIClient.GetMuseumItem(i, context);
        if (item != null) {
          Item nnItem = item; //non-nullable item
          widget.listItems.add(nnItem);
        }
        ++i;
      }
    } catch (error) {
      print(error);
    }
    onLoadFinish();
  }

  void onLoadFinish() {
    setState(() {
      isLoading = false;
      isFirstLoad = false;
    });
  }

  void onReload() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Items reloaded.")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Anderson Final Project'),
      ),
      body: Center(
          child: isFirstLoad
              ? FloatingActionButton(
                  onPressed: loadDataButton, child: const Text("Load Data"))
              : isLoading
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text('Please wait')
                      ],
                    )
                  : SingleChildScrollView(
                      child: Container(
                        color: Colors.amber[100],
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              widget.dliHandler.GetShortList(widget.listItems),
                              FloatingActionButton(
                                onPressed: onReload,
                                child: Text("Reload"),
                              )
                            ]),
                      ),
                    )),
    );
  }
}
