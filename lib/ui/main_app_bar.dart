import 'package:fltr_beanhouse/common/style.dart';
import 'package:fltr_beanhouse/locator.dart';
import 'package:fltr_beanhouse/ui/base_view.dart';
import 'package:fltr_beanhouse/viewmodels/home_model.dart';
import 'package:fltr_beanhouse/viewmodels/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppBar {
  OrderModel orderModel = locator<OrderModel>();
  static getAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: whiteColor,
      elevation: 0.8,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: SvgPicture.asset(
              'assets/svg/menu.svg',
            ),
            color: Colors.black,
            onPressed: () {},
          );
        },
      ),
      actions: <Widget>[
        Stack(
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                'assets/svg/shopping-bag.svg',
              ),
              color: Colors.black,
              onPressed: () {},
            ),
            BaseView<OrderModel>(
              onModelReady: (model) => model.getOrder(),
              builder: (context, model, widget) => Positioned(
                right: -5.0,
                child: HomeModel.notificationState > 0
                    ? Image.asset(
                        'assets/images/notification.png',
                        width: 40.0,
                      )
                    : Text(''),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
