import 'package:flutter/cupertino.dart';

class Item{
  var product;
  var  id;
  String title;
  double price;
  int pQuantity;

  Item({this.product,
    required this.title,
    required this.pQuantity,
    required this.price});
}

class CartItems with ChangeNotifier {
  Map<String, Item> _items = {};

  Map<String, Item> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String product,String title, double price) {
    if (_items.containsKey(title)) {
      _items.update(
          title,
              (existingCartItem) => Item(
              product: existingCartItem.product,
              pQuantity: existingCartItem.pQuantity + 1,
              price: existingCartItem.price,
              title: existingCartItem.title));
    } else {
      _items.putIfAbsent(
          title,
              () => Item(
              product: product,
              pQuantity: 1,
              title: title,
              price: price,
             ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.pQuantity > 1) {
      _items.update(
          id,
              (existingCartItem) => Item(
              product: existingCartItem.product,
              title: existingCartItem.title,
              pQuantity: existingCartItem.pQuantity + 1,
              price: existingCartItem.price));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

 //  List<Item> products = [];

  // addProduct(Item item) {
  //   products.add(item);
  //   notifyListeners();
  // }
  //
  // deleteProduct(Item item) {
  //   products.remove(item);
  //   notifyListeners();
  // }
