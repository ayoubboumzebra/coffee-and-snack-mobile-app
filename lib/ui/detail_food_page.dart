import 'package:fltr_beanhouse/common/style.dart';
import 'package:fltr_beanhouse/locator.dart';
import 'package:fltr_beanhouse/model/food_category.dart';
import 'package:fltr_beanhouse/model/food_order.dart';
import 'package:fltr_beanhouse/ui/main_app_bar.dart';
import 'package:fltr_beanhouse/viewmodels/home_model.dart';
import 'package:fltr_beanhouse/viewmodels/order_model.dart';
import 'package:flutter/material.dart';

class DetailFoodPage extends StatefulWidget {
  FoodCategory food;
  DetailFoodPage({this.food}) {
    print(this.food.title);
  }
  @override
  State<StatefulWidget> createState() => _DetailFoodPage();
}

class _DetailFoodPage extends State<DetailFoodPage> {
  int _selectedFoodSize;
  int _selectedSugar;
  int _countFood;
  List<FoodOrder> foodOrder = new List<FoodOrder>();
  List<String> keywords = [];
  HomeModel homeModel = locator<HomeModel>();
  OrderModel homeModell = locator<OrderModel>();

  @override
  void initState() {
    super.initState();
    _selectedFoodSize = 0;
    _selectedSugar = 0;
    _countFood = 1;
    widget.food.quantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.getAppBar(
          'BEAN HOUSE', context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            header(context),
            countFood(),
            border(),
            if (widget.food.type == 0) sizeFood(),
            SizedBox(
              height: 35.0,
            ),
            if (widget.food.type == 0) countSugar(),
            SizedBox(
              height: 80.0,
            ),
            orderSummary(),
            SizedBox(
              height: 40.0,
            ),
            comfirmOrder()
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      height: 100.0,
      alignment: Alignment(0.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context, () {});
                homeModell.getOrder();
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
                      child: Image.asset(
                        'assets/images/coffee.png',
                        // width: 20.0,
                        height: 35.0,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'DRINKS',
                        style: TextStyle(
                          color: blackColor_01,
                          fontSize: 15.0,
                          fontFamily: 'Montserrat-Bold',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    'assets/images/rectangle-on.png',
                    height: 8.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget countFood() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.asset(
            widget.food.image,
            height: 100.0,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'LATE',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 25.0,
                    fontFamily: 'Montserrat-Bold',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 55.0,
                    child: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_countFood > 1) _countFood = _countFood - 1;
                          widget.food.quantity = _countFood;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: 55.0,
                    alignment: Alignment.center,
                    child: Text(
                      _countFood.toString(),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 20.0,
                        fontFamily: 'Montserrat-Bold',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: blackColor),
                        top: BorderSide(color: blackColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: 55.0,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(
                          () {
                            if (_countFood < 10) _countFood = _countFood + 1;
                            widget.food.quantity = _countFood;
                          },
                        );
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget border() {
    return Container(
      padding: EdgeInsets.all(35.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/images/line.png'),
          )
        ],
      ),
    );
  }

  Widget sizeFood() {
    return Container(
      margin: EdgeInsets.only(left: 35.0, right: 35.0),
      height: 80.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Size',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat-Medium',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedFoodSize = 0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      widget.food.image,
                      height: 38.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                if (_selectedFoodSize == 0)
                  Positioned(
                    right: 0.0,
                    top: 30.0,
                    child: Icon(Icons.check),
                  )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedFoodSize = 1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      widget.food.image,
                      height: 55.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                if (_selectedFoodSize == 1)
                  Positioned(
                    right: 0.0,
                    top: 15.0,
                    child: Icon(Icons.check),
                  )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedFoodSize = 2;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      widget.food.image,
                      height: 75.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                if (_selectedFoodSize == 2)
                  Positioned(
                    right: 0.0,
                    child: Icon(Icons.check),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget countSugar() {
    return Container(
      padding: EdgeInsets.only(left: 35.0, right: 35.0),
      height: 35.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Sugar',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat-Medium',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSugar = 0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/sugar-0.png',
                      height: 20.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                if (_selectedSugar == 0)
                  Positioned(
                    right: 0.0,
                    top: -.0,
                    child: Icon(Icons.check),
                  )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSugar = 1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/sugar-1.png',
                      height: 12.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                if (_selectedSugar == 1)
                  Positioned(
                    right: 0.0,
                    child: Icon(Icons.check),
                  )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSugar = 2;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/sugar-2.png',
                      height: 12.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                if (_selectedSugar == 2)
                  Positioned(
                    right: 0.0,
                    child: Icon(Icons.check),
                  )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSugar = 3;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/sugar-3.png',
                      height: 20.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                if (_selectedSugar == 3)
                  Positioned(
                    right: 0.0,
                    child: Icon(Icons.check),
                  )
              ],
            ),
          ),
          // Expanded(
          //   flex: 2,
          //   child: SizedBox(
          //     width: 0.0,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget orderSummary() {
    return Container(
      padding: EdgeInsets.only(left: 35.0, right: 35.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Total: ',
              style: TextStyle(
                color: blackColor_02,
                fontSize: 20.0,
                fontFamily: 'Montserrat-Bold',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
                '1.200 DH ',
                style: TextStyle(
                  color: blackColor_02,
                  fontSize: 20.0,
                  fontFamily: 'Montserrat-Bold',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget comfirmOrder() {
    return Container(
      padding: EdgeInsets.only(left: 35.0, right: 35.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 300.0,
                height: 55.0,
                child: RaisedButton(
                  onPressed: () {},
                  color: buttonColor_01,
                  elevation: 0.0,
                  child: Text(
                    'ADD TO BAG',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 18.0,
                      fontFamily: 'Montserrat-Bold',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/line.png'),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('or',
                        style: TextStyle(
                          color: blackColor_01,
                          fontSize: 18.0,
                          fontFamily: 'Montserrat-Bold',
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/line.png'),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 300.0,
                height: 55.0,
                child: RaisedButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    // Navigator.pushNamed(
                    //   context,
                    //   '/payment_food',
                    //   arguments: widget.food,
                    // );
                    // model.saveOrder(widget.food);
                    _navigateAndDisplaySelection(context, widget.food);
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
            ],
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }

  _navigateAndDisplaySelection(
      BuildContext context, FoodCategory foodCategory) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    await Navigator.pushNamed(
      context,
      "/payment_food",
      arguments: widget.food,
    );

    
  }
}
