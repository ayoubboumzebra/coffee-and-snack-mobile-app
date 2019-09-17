import 'package:fltr_beanhouse/model/food_category.dart';

import 'package:fltr_beanhouse/ui/base_view.dart';
import 'package:fltr_beanhouse/ui/main_app_bar.dart';
import 'package:fltr_beanhouse/viewmodels/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  List<FoodCategory> foodCategory = new List<FoodCategory>();
  Animation _animationBar;
  AnimationController _animationCtrlBar;
  Tween<double> _tweenBar;

  double ANIMATE_BAR = 1.0;

  @override
  void initState() {
    super.initState();
    _animationCtrlBar =
        AnimationController(vsync: this, duration: Duration(milliseconds: 80));
    _tweenBar = Tween<double>(begin: -1.0, end: -1.0);
    _animationBar = _tweenBar.animate(
        CurvedAnimation(parent: _animationCtrlBar, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationCtrlBar.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getFood(0),
      builder: (context, model, child) => Scaffold(
        appBar: MainAppBar.getAppBar('BEAN HOUSE', context),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _initAnimation(-1.0, -1.0);
                      model.getFood(0);
                      ANIMATE_BAR = 1.0;
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/coffee.png',
                            width: 43.0,
                          ),
                          Text(
                            'DRINKS',
                            style: TextStyle(
                              color: blackColor_01,
                              fontSize: 15.0,
                              fontFamily: 'Montserrat-Bold',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _initAnimation(1.0, 1.0);
                      model.getFood(1);
                      ANIMATE_BAR = -1.0;
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/food.png',
                            width: 43.0,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'FOODS',
                            style: TextStyle(
                              color: blackColor_01,
                              fontSize: 15.0,
                              fontFamily: 'Montserrat-Bold',
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                IgnorePointer(
                  child: Container(
                    child: Align(
                      alignment: Alignment(ANIMATE_BAR, 0.0),
                      child: FractionallySizedBox(
                        widthFactor: 1 / 2,
                        child: Image.asset(
                          'assets/images/rectangle-off.png',
                          height: 8.0,
                        ),
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Container(
                    child: AnimatedAlign(
                      duration: Duration(milliseconds: 300),
                      alignment: Alignment(_animationBar.value, 0.0),
                      child: FractionallySizedBox(
                        widthFactor: 1 / 2,
                        child: Image.asset(
                          'assets/images/rectangle-on.png',
                          height: 8.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: model.foods.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/detail_food',
                            arguments: model.foods[index],
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 25.0, bottom: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Image.asset(
                                    model.foods[index].image,
                                    height: 70.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    model.foods[index].title,
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 17.0,
                                      fontFamily: 'Montserrat-Bold',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 40.0, right: 40.0),
                          child: Image.asset('assets/images/line.png'))
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _initAnimation(double begin, double end) {
    _tweenBar.begin = begin;
    _tweenBar.end = end;

    _animationCtrlBar.reset();
    _animationCtrlBar.forward();
  }
}
