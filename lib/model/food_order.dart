class FoodOrder {
  int id;
  String title;
  String image;
  int quantity;
  FoodOrder({this.id, this.title, this.image, this.quantity});

  FoodOrder.fromLocalJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      title = json['title'];
      image = json['image'];
      quantity = json['quantity'];
    } catch (e) {
      print(e.toString());
    }
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "image": image,
      "quantity": quantity,
    };
  }
}
