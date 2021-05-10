import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scarla/circles_page/circles_page_widget.dart';
import 'assets/custom_icons_icons.dart';
import 'auth/firebase_user_provider.dart';
import 'package:scarla/login_page/login_page_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'home_page/home_page_widget.dart';
import 'group_list_page/group_list_page_widget.dart';
import 'games_select/games_select_widget.dart';
import 'login_page/login_page_widget.dart';
import 'my_profile_page/my_profile_page_widget.dart';
import 'friends_page/friends_page_widget.dart';
import 'su3_page/su3_page_widget.dart';
import 'util/transparent_route.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:line_icons/line_icons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<ScarlaFirebaseUser> userStream;
  ScarlaFirebaseUser initialUser;

  @override
  void initState() {
    super.initState();
    userStream = scarlaFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scarla',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialUser == null
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4b39ef)),
              ),
            )
          : currentUser.loggedIn
              ? NavBarPage()
              : LoginPageWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> with TickerProviderStateMixin{
  String _currentPage = 'HomePage';
  AnimationController _animationController;
  bool isDisabled= false;
  Color selectedColor;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400),);
  }

  Color color = Color(0xFFFF4553);
  double pos_l = 0;
  double pos_r = 306;
  double pos_t = 35;
  double pos_b = 0;
  void _movewidget(String pos) {
    setState(() {
      if (pos == "Profile") {
        pos_l = 303;
        pos_r = 0;
        pos_t = 35;
        pos_b = 0;
      } else if (pos == "Users") {
        pos_l = 134;
        pos_r = 0;
        pos_t = 35;
        pos_b = 0;
      }else if (pos == "Home") {
        pos_l = 0;
        pos_r = 306;
        pos_t = 35;
        pos_b = 0;
      }else if (pos == "Messages") {
        pos_l = 0;
        pos_r = 134;
        pos_t = 35;
        pos_b = 0;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'GroupListPage': GroupListPageWidget(),
      'FriendsPage': FriendsPageWidget(),
      'MyProfilePage': MyProfilePageWidget(),
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: tabs[_currentPage],
      floatingActionButton: FloatingActionButton(
        child: AnimatedIconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          /*animationDirection: AnimationDirection.forward(),
          duration: Duration(milliseconds: 400),*/
          animationController: _animationController,
          icons: [
            AnimatedIconItem(
              backgroundColor: Color(0xFF5B54C2),
              icon: Icon(
                CustomIcons.controller,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                if (!isDisabled) {
                  // _handleOnPressed();
                  _animationController.addStatusListener((status) async {
                if (status == AnimationStatus.completed) {
                   Navigator.of(context).push(
                        TransparentRoute(
                          builder: (context) => CirclesPage(),
                        ),
                      );
                      await Future.delayed(Duration(milliseconds: 200));
                      _animationController.reverse();
                      isDisabled=true;
                }
              }
              );
            }
          },
        ),
        AnimatedIconItem(
          icon: Icon(
            Icons.close,
            color: Colors.white,
            size:27,
          ),
          backgroundColor: Colors.red,

        ),
      ],

          //progress: _animationController,
        ),
        onPressed: (){

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 3,
          color: Color(0xFF373856),
          child: Container(
              height: 60,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(AntDesign.home),
                          iconSize: 24.0,
                          color: (_currentPage == 'HomePage')
                              ? color
                              : Colors.white,
                          onPressed: () {
                            _movewidget("Home");
                            setState(() => setState(
                                () => _currentPage = tabs.keys.toList()[0]));
                          },
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(AntDesign.message1),
                          iconSize: 24.0,
                          color: (_currentPage == 'GroupListPage')
                              ? color
                              : Colors.white,
                          onPressed: () {
                            _movewidget("Messages");
                            setState(() => setState(
                                () => _currentPage = tabs.keys.toList()[1]));
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,2,0,0),
                          child: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(FluentIcons.people_community_28_regular),
                            iconSize: 30.0,
                            color: (_currentPage == 'FriendsPage')
                                ? color
                                : Colors.white,
                            onPressed: () {
                              setState(() => setState(
                                  () => _currentPage = tabs.keys.toList()[2]));
                              _movewidget("Users");
                            },
                          ),
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(LineIcons.userCircle),
                          iconSize: 29,
                          color: (_currentPage == 'MyProfilePage')
                              ? color
                              : Colors.white,
                          onPressed: () {
                            _movewidget("Profile");
                            setState(() => setState(
                                () => _currentPage = tabs.keys.toList()[3]));
                          },
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      AnimatedPositioned(
                        curve: Curves.ease,
                        left: pos_l,
                        right: pos_r,
                        top: pos_t,
                        bottom: pos_b,
                        duration: Duration(milliseconds: 220),
                        child: Center(
                          child: Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: new BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );

    /* BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
              size: 24,
            ),
            label: 'Squads',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.gamepad,
              size: 24,
            ),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_sharp,
              size: 24,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts_outlined,
              size: 24,
            ),
            label: 'Home',
          )
        ],
        backgroundColor: Color(0xFF373856),
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: Color(0xFFFF4553),
        unselectedItemColor: Color(0xFF4D5078),
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );*/
  }
}
