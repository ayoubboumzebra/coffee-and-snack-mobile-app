import 'package:fltr_beanhouse/model/food_order.dart';
import 'package:fltr_beanhouse/ui/base_view.dart';
import 'package:fltr_beanhouse/viewmodels/home_model.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Test();
}

class _Test extends State<Test> {
  List<FoodOrder> foodList = [];
  @override
  void initState() {
    super.initState();
    // foodList.add(
    //   new FoodOrder(
    //       title: 'CAPPUCCINO', image: 'assets/images/cafe.png', quantity: 0),
    // );
    // foodList.add(
    //   new FoodOrder(
    //       title: 'CAPPUCCINO', image: 'assets/images/cafe.png', quantity: 5),
    // );
    // print(foodList.length);
    // saveWishlist(foodList);
    // print(foodList);
  }

  void saveWishlist(List<FoodOrder> products) async {
    final LocalStorage storage = new LocalStorage("fstore");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("foodOrder", products);
      }
    } catch (err) {
      print("err");
      print(err);
    }
  }

  void getWishList() async {
    final LocalStorage storage = new LocalStorage("fstore");
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem("foodOrder");
        if (json != null) {
          List<FoodOrder> list = [];
          for (var item in json) {
            list.add(FoodOrder.fromLocalJson(item));
          }
          print('----- i am king ------');
          print(list.length);
        }
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getFood(0),
      builder: (context, model, child) => MaterialApp(
        home: Scaffold(
          body: Column(
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
              RaisedButton(
                child: Text('Chow me data'),
                onPressed: () {
                  // foodList.add(
                  //   new FoodOrder(
                  //       title: 'CAPPUCCINO',
                  //       image: 'assets/images/cafe.png',
                  //       quantity: 0),
                  // );
                  // saveWishlist(foodList);
                  // getWishList();
                   Navigator.pushNamed(
                            context,
                            '/test',
                          );
                },
              ),
              RaisedButton(
                child: Text('Chow me data'),
                onPressed: () {
                //  Navigator.pushNamed(
                //             context,
                //             '/test',
                //           );
                   Navigator.pop(
                            context,
                          );
                          
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
