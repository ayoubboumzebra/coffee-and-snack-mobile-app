import 'package:fltr_beanhouse/locator.dart';
import 'package:fltr_beanhouse/model/food_category.dart';
import 'package:fltr_beanhouse/model/food_order.dart';
import 'package:fltr_beanhouse/services/base_api.dart';
import 'package:fltr_beanhouse/viewmodels/base_model.dart';
import 'package:fltr_beanhouse/viewmodels/order_model.dart';
import 'package:localstorage/localstorage.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
  BaseApi baseApi;
  BaseApi _foodsService = locator<BaseApi>();
  static int notificationState = 0;
  final LocalStorage storage = new LocalStorage("fstore");

  List<FoodCategory> foodList;
  List<FoodCategory> get foods => _foodsService.foods;
  OrderModel orderModel = locator<OrderModel>();

  List<FoodCategory> getFood(int type) {
    setState(ViewState.Busy);
    foodList = _foodsService.getFoodsList(type);
    orderModel.getOrder();
    setState(ViewState.Idle);
    return foodList;
  }
}
