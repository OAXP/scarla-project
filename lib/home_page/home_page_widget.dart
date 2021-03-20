import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Image.network(
        'https://images-ext-2.discordapp.net/external/q0DEA_d03R2k_gG2y5hh95JHA_qTGRIO4aHVdxy-VMk/%3Fitemid%3D19929743/https/media1.tenor.com/images/9d7f909f860ce3e0b91f6b1575805079/tenor.gif',
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        fit: BoxFit.cover,
      ),
    );
  }
}
