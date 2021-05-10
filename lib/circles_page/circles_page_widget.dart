import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:scarla/assets/custom_icons_icons.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/painting.dart';

import '../matches_page/matches_page_widget.dart';

class CirclesPage extends StatefulWidget {
  @override
  _CirclesPageState createState() => _CirclesPageState();
}

class _CirclesPageState extends State<CirclesPage>
    with TickerProviderStateMixin {
  List<bool> isSelected = new List.filled(5, false);

  bool isSelected2 = false;
  AnimationController _animationController;
  bool checkSelect = true;
  Icon icon = Icon(
    CustomIcons.controller,
    color: Colors.white,
    size: 25,
  );
  Color color = Color(0xFF5B54C2);
  AnimationController controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      });
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

@override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    controller.dispose();
  }

  void _handleOnPressed() {
    setState(() {
      _animationController.forward();
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String game;
  List<bool> competitive;
  bool noSelected = false;
  bool anySelected = true;
  bool yesSelected = false;
  Color color1 = Color(0xff0b323e);
  Color color2 = Color(0xff010b15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: checkSelect
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(59, 140, 0, 0),
                    child: Row(children: <Widget>[
                      SelectableCircle(
                          width: 80.0,
                          isSelected: isSelected[0],
                          borderColor: Colors.deepPurpleAccent,
                          selectedBorderColor: Colors.green,
                          color: Color(0xffff4654),
                          onTap: () {
                            setState(() {
                              if (!isSelected[0]) {
                                if (!isSelected.contains(true)) {
                                  _animationController.forward();
                                }
                                isSelected.fillRange(
                                    0, isSelected.length, false);
                                isSelected[0] = true;
                                game = "valorant";
                                if (isSelected[0]) {
                                  icon = Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  );
                                  color = Colors.green;
                                }
                              } else {
                                _animationController.forward();
                                isSelected.fillRange(
                                    0, isSelected.length, false);

                                icon = Icon(
                                  CustomIcons.controller,
                                  color: Colors.white,
                                  size: 25,
                                );
                                color = Color(0xFF5B54C2);
                              }
                            });
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/games/icons/valorantIcon.png'),
                            maxRadius: 30,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      SelectableCircle(
                          selectedColor: Colors.black,
                          width: 80.0,
                          color: Colors.grey[900],
                          isSelected: isSelected[1],
                          borderColor: Colors.red,
                          selectedBorderColor: Colors.green,
                          onTap: () {
                            setState(() {
                              if (!isSelected[1]) {
                                if (!isSelected.contains(true)) {
                                  _animationController.forward();
                                }
                                isSelected.fillRange(
                                    0, isSelected.length, false);
                                isSelected[1] = true;
                                game = "mw";
                                if (isSelected[1]) {
                                  icon = Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  );
                                  color = Colors.green;
                                }
                              } else {
                                _animationController.forward();

                                isSelected.fillRange(
                                    0, isSelected.length, false);

                                icon = Icon(
                                  CustomIcons.controller,
                                  color: Colors.white,
                                  size: 25,
                                );
                                color = Color(0xFF5B54C2);
                              }
                            });
                          },
                          child: CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: Colors.grey[900],
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: ExactAssetImage(
                                      'assets/games/icons/mwIcon.png'),
                                  scale: 2.3,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            //backgroundImage:AssetImage('assets/images/mwIcon.png'),maxRadius: 26,backgroundColor: Colors.grey[900],foregroundColor: Colors.red,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      SelectableCircle(
                          width: 80.0,
                          color: Color(0xff0a2f39),
                          isSelected: isSelected[2],
                          borderColor: Colors.red,
                          selectedBorderColor: Colors.green,
                          onTap: () {
                            setState(() {
                              if (!isSelected[2]) {
                                if (!isSelected.contains(true)) {
                                  _animationController.forward();
                                }
                                isSelected.fillRange(
                                    0, isSelected.length, false);
                                isSelected[2] = true;
                                game = "lol";
                                if (isSelected[2]) {
                                  icon = Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  );
                                  color = Colors.green;
                                }
                              } else {
                                _animationController.forward();

                                isSelected.fillRange(
                                    0, isSelected.length, false);

                                icon = Icon(
                                  CustomIcons.controller,
                                  color: Colors.white,
                                  size: 25,
                                );
                                color = Color(0xFF5B54C2);
                              }
                            });
                          },
                          child: CircleAvatar(
                            maxRadius: 30,
                            //backgroundImage:AssetImage('assets/images/lolIcon.png'),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: ExactAssetImage(
                                        'assets/games/icons/lolIcon.png'),
                                    scale: 10),
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    color1,
                                    color2,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            //backgroundImage:AssetImage('assets/images/lolIcon.png'),maxRadius: 25,backgroundColor: Color(0xff0a2f39),
                          )),
                    ]),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(110, 0, 0, 0),
                    child: Row(children: <Widget>[
                      SelectableCircle(
                        color: Color(0xff004ca3),
                        width: 80.0,
                        isSelected: isSelected[3],
                        borderColor: Colors.deepPurpleAccent,
                        selectedBorderColor: Colors.green,
                        onTap: () {
                          setState(() {
                            if (!isSelected[3]) {
                              if (!isSelected.contains(true)) {
                                _animationController.forward();
                              }
                              isSelected.fillRange(0, isSelected.length, false);
                              isSelected[3] = true;
                              game = "rl";
                              if (isSelected[3]) {
                                icon = Icon(
                                  Icons.check,
                                  color: Colors.white,
                                );
                                color = Colors.green;
                              }
                            } else {
                              _animationController.forward();
                              isSelected.fillRange(0, isSelected.length, false);

                              icon = Icon(
                                CustomIcons.controller,
                                color: Colors.white,
                                size: 25,
                              );
                              color = Color(0xFF5B54C2);
                            }
                          });
                        },
                        child: CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Color(0xff004ca3),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(2, 3, 0, 0),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xff004ca3),
                              image: DecorationImage(
                                image:
                                    ExactAssetImage('assets/games/icons/rlIcon.png'),
                                scale: 23,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ), /* CircleAvatar(backgroundImage:AssetImage('assets/images/rlIcon.png'),radius: 20,backgroundColor: Color(0xff004ca3),)*/
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SelectableCircle(
                        color: Colors.grey[350],
                        width: 80.0,
                        isSelected: isSelected[4],
                        borderColor: Colors.red,
                        selectedBorderColor: Colors.green,
                        onTap: () {
                          setState(() {
                            if (!isSelected[4]) {
                              if (!isSelected.contains(true)) {
                                _animationController.forward();
                              }
                              isSelected.fillRange(0, isSelected.length, false);
                              isSelected[4] = true;
                              game = "ow";
                              if (isSelected[4]) {
                                icon = Icon(
                                  Icons.check,
                                  color: Colors.white,
                                );
                                color = Colors.green;
                              }
                            } else {
                              _animationController.forward();

                              isSelected.fillRange(0, isSelected.length, false);

                              icon = Icon(
                                CustomIcons.controller,
                                color: Colors.white,
                                size: 25,
                              );
                              color = Color(0xFF5B54C2);
                            }
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: DecorationImage(
                                image:
                                    ExactAssetImage('assets/games/icons/owIcon.png'),
                                scale: 25,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        /* CircleAvatar(backgroundImage:AssetImage('assets/images/owIcon.png'),maxRadius: 24,backgroundColor:Colors.grey[350],*/
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 70,
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Text(
                      'Type of players',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  //Text('Type'),
                  SizedBox(
                    height: 45,
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(37, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Any',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: (anySelected)
                                      ? Color(0xFFff4553)
                                      : Colors.blue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                )),
                            width: 23,
                            height: 23,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                activeColor: Colors.transparent,
                                checkColor: Color(0xFFff4553),
                                splashRadius: 2,
                                value: anySelected,
                                tristate: false,
                                onChanged: (bool isChecked) {
                                  setState(() {
                                    anySelected = !anySelected;
                                    noSelected = false;
                                    yesSelected = false;
                                    if(anySelected == true) {
                                      yesSelected = false;
                                      anySelected = true;
                                      noSelected = false;
                                    } else {
                                      noSelected = false;
                                      anySelected = !anySelected;
                                      yesSelected = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Casual',
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      (noSelected) ? Color(0xFFff4553) : Colors.blue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                )),
                            width: 23,
                            height: 23,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                activeColor: Colors.transparent,
                                checkColor: Color(0xFFff4553),
                                splashRadius: 2,
                                value: noSelected,
                                tristate: false,
                                onChanged: (bool isChecked) {
                                  setState(() {
                                    if(noSelected == true) {
                                      yesSelected = false;
                                      anySelected = false;
                                      noSelected = true;
                                    } else {
                                      noSelected = isChecked;
                                      anySelected = false;
                                      yesSelected = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Competitive',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      (yesSelected) ? Color(0xFFff4553) : Colors.blue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                )),
                            width: 23,
                            height: 23,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                activeColor: Colors.transparent,
                                checkColor: Color(0xFFff4553),
                                splashRadius: 2,
                                value: yesSelected,
                                tristate: false,
                                onChanged: (bool isChecked) {
                                  setState(() {
                                    if(yesSelected == true) {
                                      yesSelected = true;
                                      anySelected = false;
                                      noSelected = false;
                                    } else {
                                      yesSelected = isChecked;
                                      anySelected = false;
                                      noSelected = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            /*repeat: true,
            reverse: true,
            animate: true,*/
            : Scaffold(
                /* backgroundColor:Color.fromRGBO(34, 35, 35, 10),*/
                backgroundColor: Colors.black54,
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 130),
                  child: Center(
                    child: Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_TfAnHg.json',
                        /* 'https://assets1.lottiefiles.com/packages/lf20_32wupitr.json',*/
                        width: 200,
                        height: 200,
                        fit: BoxFit.scaleDown,
                        controller: controller, onLoaded: (composition) {
                      controller
                        ..duration = composition.duration
                        ..forward();

                      controller.addStatusListener((status) async {
                        if (status == AnimationStatus.completed) {
                          if(anySelected) {
                            competitive = [false, true];
                          } else if (yesSelected) {
                            competitive = [true];
                          } else if (noSelected) {
                            competitive = [false];
                          }
                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchesPageWidget(
                                game: game,
                                competitive: competitive,
                              ),
                            ),
                          );
                        }
                      });
                    }),
                  ),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: FloatingActionButton(
                      backgroundColor: Color(0xFF5B54C2),
                      child: LoadingIndicator(
                        indicatorType: Indicator.circleStrokeSpin,
                        color: Colors.white,
                      ),
                      /*Lottie.network('https://assets3.lottiefiles.com/packages/lf20_0ZPIFf.json',width: 150,height: 150,fit: BoxFit.cover,),*/

                      /* Lottie.network(
                            'https://assets2.lottiefiles.com/packages/lf20_FVqg63.json'),*/
                    onPressed: () {},
                      ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              ),
      ),
      floatingActionButton: checkSelect
          ? Padding(
              padding: const EdgeInsets.all(32.0),
              /*Transform.scale(
    scale: 0.9,*/

              /*Transform.scale(
        scale: 1.1,
        child: Padding(
          padding: const EdgeInsets.all(32.0),*/
              child: FloatingActionButton(
                child: AnimatedIconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  /*animationDirection: AnimationDirection.forward(),
          duration: Duration(milliseconds: 400),*/
                  animationController: _animationController,
                  icons: [
                    AnimatedIconItem(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 27,
                      ),
                      backgroundColor: Colors.red,
                      onPressed: () {
                        _animationController.addStatusListener((status) async {
                          if (status == AnimationStatus.completed) {
                            Navigator.of(context).pop();

                            /*AnimationDirection.reverse();
                        icon= Icon(CustomIcons.controller);*/
                          }
                        });
                      },
                    ),
                    AnimatedIconItem(
                        backgroundColor: color,
                        icon: icon,
                        onPressed: () {
                          setState(() {
                            checkSelect = !checkSelect;
                          });
                          //_animationController.dispose();
                        }),
                  ],
                ),
              onPressed: (){

              },
                //CircleAvatar(backgroundImage:NetworkImage('https://i.imgur.com/GLdqYB2.gif'),maxRadius: 25,backgroundColor: Colors.transparent,),
              ))
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
