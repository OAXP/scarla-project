import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'auth/firebase_user_provider.dart';
import 'package:scarla/login_page/login_page_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'home_page/home_page_widget.dart';
import 'games_select/games_select_widget.dart';
import 'group_list_page/group_list_page_widget.dart';
import 'my_profile_page/my_profile_page_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ScarlaHomePage(),
    );
  }
}

class ScarlaHomePage extends StatelessWidget {
  const ScarlaHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScarlaFirebaseUser>(
      stream: scarlaFirebaseUser,
      initialData: scarlaFirebaseUser.value,
      builder: (context, snapshot) {
        return snapshot.data.when(
          user: (_) => NavBarHolder(),
          loggedOut: () => LoginPageWidget(),
          initial: () => Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4b39ef)),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NavBarHolder extends StatefulWidget {
  NavBarHolder({Key key}) : super(key: key);

  @override
  _NavBarHolderState createState() => _NavBarHolderState();
}

/// This is the private State class that goes with NavBarHolder.
class _NavBarHolderState extends State<NavBarHolder> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomePageWidget(),
      GamesSelectWidget(),
      GroupListPageWidget(),
      MyProfilePageWidget(),
    ];
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 24,
            ),
            label: 'Home',
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
              Icons.chat,
              size: 24,
            ),
            label: 'Squads',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_sharp,
              size: 24,
            ),
            label: 'Profile',
          )
        ],
        backgroundColor: Color(0xFF373856),
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF22CD4F),
        unselectedItemColor: Color(0xFF4D5078),
        onTap: (i) => setState(() => _currentIndex = i),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
