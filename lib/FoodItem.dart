class FoodItem {
  int no;
  String name;
  int price;
  int stock;
  String image;
  int category;

  FoodItem(
      {this.no, this.name, this.price, this.stock, this.image, this.category});


  FoodItem.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['name'] = this.name;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}
