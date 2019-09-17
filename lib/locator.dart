import 'package:fltr_beanhouse/services/base_api.dart';
import 'package:fltr_beanhouse/viewmodels/home_model.dart';
import 'package:fltr_beanhouse/viewmodels/order_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseApi());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => OrderModel());
}
