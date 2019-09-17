import 'package:fltr_beanhouse/model/food_category.dart';
import 'package:fltr_beanhouse/model/food_order.dart';
import 'package:fltr_beanhouse/viewmodels/base_model.dart';
import 'package:fltr_beanhouse/viewmodels/home_model.dart';
import 'package:localstorage/localstorage.dart';

class OrderModel extends BaseModel {
  List<FoodOrder> _foodOrder = [];

  Function get fetchFood => getOrder;
  final LocalStorage storage = new LocalStorage("fstore");

  void saveOrder(FoodCategory products) async {
    setState(ViewState.Busy);
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem("foodOrder");
        if (json != null) {
          List<FoodOrder> list = [];
          for (var item in json) {
            list.add(FoodOrder.fromLocalJson(item));
          }
          _foodOrder = list;
        }
      }
    } catch (err) {
      print(err);
    }
    _foodOrder.removeWhere((res) => res.id == products.id);
    _foodOrder.add(
      new FoodOrder(
        id: products.id,
        title: products.title,
        image: products.image,
        quantity: products.quantity,
      ),
    );

    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("foodOrder", _foodOrder);
      }
      getOrder();
      HomeModel.notificationState = _foodOrder.length;
      setState(ViewState.Idle);
    } catch (err) {
      print(err);
    }
  }

  void getOrder() async {
    print('i am getOrder');
    setState(ViewState.Busy);

    try {
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem("foodOrder");
        if (json != null) {
          List<FoodOrder> list = [];
          for (var item in json) {
            list.add(FoodOrder.fromLocalJson(item));
          }
          _foodOrder = list;

          getSaveFoods();
        }
      }
    } catch (err) {
      print(err);
    }
    setState(ViewState.Idle);
  }

  List<FoodOrder> getSaveFoods() {
    HomeModel.notificationState = _foodOrder.length;
    return _foodOrder;
  }

  void clearStorage() async {
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("foodOrder", []);
        HomeModel.notificationState = 0;
        getOrder();
      }
    } catch (err) {
      print(err);
    }
  }

  void removeAt(int id) async {
    try {
      setState(ViewState.Busy);
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem("foodOrder");

        if (json != null) {
          List<FoodOrder> list = [];
          for (var item in json) {
            list.add(FoodOrder.fromLocalJson(item));
          }
          _foodOrder = list;
          _foodOrder.removeWhere((res) => res.id == id);
          await storage.setItem("foodOrder", _foodOrder);
          HomeModel.notificationState = list.length;
          getOrder();
          setState(ViewState.Idle);
        }
      }
    } catch (err) {
      print(err);
    }
  }
}
