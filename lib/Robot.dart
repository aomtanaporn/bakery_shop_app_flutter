import 'dart:convert';

import 'package:final_project/FoodItem.dart';
import 'package:final_project/Order.dart';
import 'package:final_project/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyStore extends ChangeNotifier {
  String url_base = 'http://192.168.1.113:1880';
  List<FoodItem> _foods = [];
  List<FoodItem> _filterfoods = [];
  FoodItem _activeFood;
  Order _baskets;

  Order get baskets =>  _baskets;
  User _loginuser;
  FoodItem get activeFood => _activeFood;

  List<FoodItem> get foods => _foods;

  List<FoodItem> get filterfoods => _filterfoods;
  User get loginuser => _loginuser;

  set foods(List<FoodItem> foods) {
    _foods = foods;
    notifyListeners();
  }

  MyStore() {
    _foods = [];
    _filterfoods =[];
    _loginuser = new User();
    _baskets = new Order(orderFoods: []);
    notifyListeners();
  }

  void applyMovieFilter(int id) {
    List<FoodItem> filter_product = [];
    if (id == 0) {
      _filterfoods = _foods;
    } else {
      filter_product
          .addAll(_foods.where((element) => element.category == id).toList());
      _filterfoods = filter_product;
    }
    notifyListeners();
  }

  Future<String> login(String username, String password) async {
    var result = await http.post(url_base + '/login2',
        body: {"username": username, "password": password});
    print(result.body);
    print(result.statusCode);
    if (result.statusCode == 200) {
      String verified = result.body;

      if (result.body != "no") {
        var basket = json.decode(result.body);
        var user = User.fromJson(basket);

        _loginuser = user;
        _baskets.customerId = _loginuser.cusId;
        print(_loginuser.cusId);
        return _loginuser.res;}
      return verified;
    } else {
      throw Exception('fail to load driver');
    }

  } //ef

  void setSearchKey(String query) {
    List<FoodItem> search_product = [];
    if (query != "") {
      search_product.addAll(_foods
          .where((element) =>
          element.name.toLowerCase().contains(query.toLowerCase()))
          .toList());
      _filterfoods = search_product;
    } else {
      _filterfoods = _foods;
    }
    notifyListeners();
  }

  void getFoodItem() async {
    var result = await http.get(url_base + "/myshop");
    if (result.statusCode == 200) {
      print(result.body);
      var basket = json.decode(result.body) as List;
      var foodsFromJson =
          basket.map((apple) => FoodItem.fromJson(apple)).toList();

      _foods = foodsFromJson;
      _filterfoods = foodsFromJson;
    } else {
      throw Exception('fail to load foods');
    }
  } //ef

  void setActiveProduct(FoodItem f) {
    _activeFood = f;
  }
  void clearBasket() {
    for (int i = 0; i < _baskets.orderFoods.length; i++) {
      _baskets.orderFoods[i].quantity = 0;
    } //end

    _baskets.orderFoods.clear();

    notifyListeners();
  } //ef
  void addOneToBasket(FoodItem product, int i) {
    //check if the product is the the basket
    OrderFoods found = _baskets.orderFoods.firstWhere(
            (p) => p.food.no == product.no,
        orElse: () => null);

    print(found);
    //if there just update qty
    if (found != null) {
      _baskets.orderFoods.forEach((element) {
        if (element.food.no == product.no) {
          element.quantity += i;
        }
      });
    } else {
      OrderFoods  addProduct =
      OrderFoods(food: product, quantity: i);
      _baskets.orderFoods.add(addProduct);
    }

    notifyListeners();
  } //ef

  int getBasketQty() {
    int total = 0;
    for (int i = 0; i < _baskets.orderFoods.length; i++) {
      total += _baskets.orderFoods[i].quantity;
    } //endloop
    return total;
  }
  double getBasketTotal() {
    double total = 0;
    for (int i = 0; i < _baskets.orderFoods.length; i++) {
      total +=
          _baskets.orderFoods[i].quantity * _baskets.orderFoods[i].food.price;
    } //endloop
    return total;
  }
  void makeOrder() {

    List<OrderFoods> items = [];
    for (OrderFoods p in _baskets.orderFoods) {
      items.add(new OrderFoods(food: p.food, quantity: p.quantity));
    }
    Order order = Order(
        customerId: _baskets.customerId,
        orderFoods: items
    );

    var data = json.encode(_baskets.toJson());
    print(data);

    http.post(url_base+"/makeorder",body:data,headers: {"Content-Type": "application/json"}).then((value) => print(value));
  }
} //ec
