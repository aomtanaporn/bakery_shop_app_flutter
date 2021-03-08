import 'package:final_project/FoodItem.dart';

class Order {
  int no;
  int customerId;
  List<OrderFoods> orderFoods;

  Order({this.no, this.customerId, this.orderFoods});

  Order.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    customerId = json['customer_id'];
    if (json['orderFoods'] != null) {
      orderFoods = new List<OrderFoods>();
      json['orderFoods'].forEach((v) {
        orderFoods.add(new OrderFoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['customer_id'] = this.customerId;
    if (this.orderFoods != null) {
      data['orderFoods'] = this.orderFoods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderFoods {
  FoodItem food;
  int quantity;

  OrderFoods({this.food, this.quantity});

  OrderFoods.fromJson(Map<String, dynamic> json) {
    food = json['food'] != null ? new FoodItem.fromJson(json['food']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.food != null) {
      data['food'] = this.food.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

