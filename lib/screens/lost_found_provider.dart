import 'package:flutter/material.dart';

class LostFoundProvider extends ChangeNotifier {
  List<String> lostItems = [
    "Wallet- 5th Floor 505",
    "iPhone 13- Library",
    "Metal watch- 303"
  ];

  void markItemAsFound(String item) {
    lostItems.remove(item);
    notifyListeners();
  }
}
