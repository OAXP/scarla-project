import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchesPageWidget extends StatefulWidget {
  MatchesPageWidget({Key key}) : super(key: key);

  @override
  _MatchesPageWidgetState createState() => _MatchesPageWidgetState();
}

class _MatchesPageWidgetState extends State<MatchesPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.primaryColor,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xA2000000),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment(-1, 0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: Color(0xFF535480),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1, 0),
                        child: Text(
                          'Players Found',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF535480),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        child: IconButton(
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                          icon: Icon(
                            Icons.check_rounded,
                            color: Color(0xFF535480),
                            size: 30,
                          ),
                          iconSize: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0x84FF4553),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(0, 0),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://i.imgur.com/JXZBBeX.gif',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Name',
                                            textAlign: TextAlign.justify,
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '#',
                                            textAlign: TextAlign.justify,
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'TAG',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF2C2C2C),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(1, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                                  child: Text(
                                                    'Rank : ',
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/20.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        iconSize: 30,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
