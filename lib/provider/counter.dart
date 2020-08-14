import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  List<ListTile> _listTiles = List();
  int get count => _count;
  List<ListTile> get listTiles => _listTiles;

  void increment() {
    _count++;
    notifyListeners();
  }
  void insertList(ListTile listTile) {
    _listTiles.add(listTile);
    notifyListeners();
  }
}