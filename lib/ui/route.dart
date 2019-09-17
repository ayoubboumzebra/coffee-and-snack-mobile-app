import 'package:fltr_beanhouse/model/food_category.dart';
import 'package:fltr_beanhouse/ui/detail_food_page.dart';
import 'package:fltr_beanhouse/ui/home_page.dart';
import 'package:fltr_beanhouse/ui/payment_food.dart';
import 'package:fltr_beanhouse/ui/test.dart';
import 'package:flutter/material.dart';

const String initialRoute = "/";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/detail_food':
        FoodCategory foods = settings.arguments as FoodCategory;
        return MaterialPageRoute(builder: (_) => DetailFoodPage(food: foods));
      case '/payment_food':
        FoodCategory food = settings.arguments as FoodCategory;
        return MaterialPageRoute(builder: (_) => PaymentFood(foods: food));
      case '/test':
        return MaterialPageRoute(builder: (_) => Test());
      // case 'post':
      //   var post = settings.arguments as Post;
      //   return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
