import '../Models/item.dart';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key, required this.loadedItem}) : super(key: key);
  final Item loadedItem;

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState(loadedItem);
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  _ItemDetailsPageState(item);
  late Item item = widget.loadedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Anderson Final Project'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[item.listItemLarge()]),
      )),
    );
  }
}
