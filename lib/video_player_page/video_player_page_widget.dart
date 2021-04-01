import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoPlayerPageWidget extends StatefulWidget {
  VideoPlayerPageWidget({Key key}) : super(key: key);

  @override
  _VideoPlayerPageWidgetState createState() => _VideoPlayerPageWidgetState();
}

class _VideoPlayerPageWidgetState extends State<VideoPlayerPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0x00EEEEEE),
          ),
          alignment: Alignment(0, 0),
          child: Stack(
            children: [],
          ),
        ),
      ),
    );
  }
}
