
import 'package:fltr_beanhouse/model/food_category.dart';

class BaseApi {
  List<FoodCategory> _foods;
  List<FoodCategory> get foods => _foods;

  getFoodsList(int type) {
    List<FoodCategory> foodList = [];
    foodList.add(FoodCategory(
        id: 0,
        title: 'CAPPUCCINO',
        image: 'assets/images/cafe.png',
        type: 0,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 1,
        title: 'EXPRESSO',
        image: 'assets/images/tea-cup.png',
        type: 0,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 2,
        title: 'FRAPPUCCINO',
        image: 'assets/images/cup.png',
        type: 0,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 3,
        title: 'LATTE',
        image: 'assets/images/hot-coffee.png',
        type: 0,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 4,
        title: 'MOCHA',
        image: 'assets/images/love-potion.png',
        type: 0,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 5,
        title: 'A SLICE OF CAKE',
        image: 'assets/images/cake.png',
        type: 1,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 6,
        title: 'CUPCAKE',
        image: 'assets/images/cupcake-with-a-berry.png',
        type: 1,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 7,
        title: 'ICE CREAM',
        image: 'assets/images/ice-cream-fruit-cone.png',
        type: 1,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 8,
        title: 'HOT DOG',
        image: 'assets/images/hot-dog.png',
        type: 1,
        quantity: 0));
    foodList.add(FoodCategory(
        id: 9,
        title: 'BREAD',
        image: 'assets/images/food.png',
        type: 1,
        quantity: 0));
    _foods = foodList.where((res) => res.type == type).toList();
    return _foods;
  }
}
