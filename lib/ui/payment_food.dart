import 'package:fltr_beanhouse/common/style.dart';
import 'package:fltr_beanhouse/model/food_category.dart';
import 'package:fltr_beanhouse/ui/base_view.dart';
import 'package:fltr_beanhouse/ui/home_page.dart';
import 'package:fltr_beanhouse/viewmodels/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fltr_beanhouse/ui/main_app_bar.dart';

class PaymentFood extends StatefulWidget {
  FoodCategory foods = new FoodCategory();
  PaymentFood({this.foods}) {
    // final LocalStorage storage = new LocalStorage('some_key');
    // print(FoodOrder.fromLocalJson(storage.getItem("foodOrder")));
  }
  @override
  State<StatefulWidget> createState() => _PaymentFood();
}

class _PaymentFood extends State<PaymentFood> {
  int _valRadio = 0;

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderModel>(
      onModelReady: (model) => model.saveOrder(widget.foods),
      builder: (context, model, child) => Material(
        child: Scaffold(
          appBar: MainAppBar.getAppBar('BEAN HOUSE', context),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                header(context),
                border(),
                foodSummary(model),
                border(),
                payement(model)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      height: 100.0,
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: double.maxFinite,
                alignment: Alignment.centerLeft,
                child: Text(
                  'BACK',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Montserrat-Bold',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'MY BAG',
                          style: TextStyle(
                            color: blackColor_01,
                            fontSize: 15.0,
                            fontFamily: 'Montserrat-Bold',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget border() {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/images/line.png'),
          )
        ],
      ),
    );
  }

  Widget foodSummary(OrderModel orderModel) {
    return Container(
      padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
      child: ListView.builder(
        itemCount: orderModel.getSaveFoods().length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    orderModel.getSaveFoods()[index].image,
                    height: 70.0,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        orderModel.getSaveFoods()[index].title,
                        style: TextStyle(
                          color: blackColor_02,
                          fontSize: 16.0,
                          fontFamily: 'Montserrat-Bold',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Qty : ',
                            style: TextStyle(
                              color: blackColor_03,
                              fontSize: 18.0,
                              fontFamily: 'Montserrat-Bold',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            orderModel
                                .getSaveFoods()[index]
                                .quantity
                                .toString(),
                            style: TextStyle(
                              color: blackColor_02,
                              fontSize: 18.0,
                              fontFamily: 'Montserrat-Bold',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      orderModel.removeAt(orderModel.getSaveFoods()[index].id);
                      print(orderModel.getSaveFoods().length );
                      if (orderModel.getSaveFoods().length <= 1)
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false);
                    },
                    child: Image.asset(
                      'assets/images/close.png',
                      height: 15.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget payement(OrderModel orderModel) {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            child: ButtonTheme(
              minWidth: 100.0,
              height: 25.0,
              child: RaisedButton(
                onPressed: () {
                  orderModel.clearStorage();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                color: buttonColor_01,
                elevation: 0.0,
                child: Text(
                  'Empty Bag',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 13.0,
                    fontFamily: 'Montserrat-Bold',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Subtotal : ',
                style: TextStyle(
                  color: blackColor_02,
                  fontSize: 16.0,
                  fontFamily: 'Montserrat-Medium',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'NGN 599.96',
                style: TextStyle(
                  color: blackColor_02,
                  fontSize: 16.0,
                  fontFamily: 'Montserrat-Medium',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              'PAYMENT OPTIONS',
              style: TextStyle(
                color: blackColor_02,
                fontSize: 18.0,
                fontFamily: 'Montserrat-Bold',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 50.0),
            width: double.maxFinite,
            height: 200.0,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                new BoxShadow(
                  color: blackColor_shadow.withOpacity(.05),
                  offset: new Offset(0.0, 0.0),
                  blurRadius: 15.0,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RadioListTile(
                  value: 0,
                  groupValue: _valRadio,
                  onChanged: (index) {
                    setState(() {
                      _valRadio = 0;
                    });
                  },
                  title: Text(
                    'Pay with Card',
                    style: TextStyle(
                      color: blackColor_02,
                      fontSize: 18.0,
                      fontFamily: 'Montserrat-Bold',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset('assets/images/bar-payment.png'),
                      )
                    ],
                  ),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: _valRadio,
                  onChanged: (index) {
                    setState(() {
                      _valRadio = 1;
                    });
                  },
                  title: Text(
                    'Pay Cash on Delivery',
                    style: TextStyle(
                      color: blackColor_02,
                      fontSize: 18.0,
                      fontFamily: 'Montserrat-Bold',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ButtonTheme(
            minWidth: 300.0,
            height: 55.0,
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
              color: buttonColor_02,
              elevation: 0.0,
              child: Text(
                'PLACE ORDER',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat-Bold',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
