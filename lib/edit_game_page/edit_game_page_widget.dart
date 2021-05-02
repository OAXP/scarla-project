import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditGamePageWidget extends StatefulWidget {
  EditGamePageWidget({Key key, this.game, this.user}) : super(key: key);

  final String game;
  final DocumentReference user;

  @override
  _EditGamePageWidgetState createState() => _EditGamePageWidgetState();
}

class _EditGamePageWidgetState extends State<EditGamePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GamesRanksRecord>>(
      stream: queryGamesRanksRecord(
        queryBuilder: (gamesRanksRecord) =>
            gamesRanksRecord.where('userRef', isEqualTo: widget.user),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<GamesRanksRecord> editGamePageGamesRanksRecordList = snapshot.data;
        // Customize what your widget looks like with no query results.
        if (snapshot.data.isEmpty) {
          // return Container();
          // For now, we'll just include some dummy data.
          editGamePageGamesRanksRecordList =
              createDummyGamesRanksRecord(count: 1);
        }
        final editGamePageGamesRanksRecord =
            editGamePageGamesRanksRecordList.first;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0x7A000000),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment(0, 0),
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.tertiaryColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.game,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'REPLACE BY SLIDER',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0x00EEEEEE),
                            ),
                            child: Image.asset(
                              'assets/images/20.png',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 1,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: Color(0xFF444771),
                                  size: 20,
                                ),
                                iconSize: 20,
                              ),
                              IconButton(
                                onPressed: () async {
                                  final lol = editGamePageGamesRanksRecord.lol;
                                  final valorant =
                                      editGamePageGamesRanksRecord.valorant;
                                  final ow = editGamePageGamesRanksRecord.ow;
                                  final rl = editGamePageGamesRanksRecord.rl;

                                  final gamesRanksRecordData =
                                      createGamesRanksRecordData(
                                    lol: lol,
                                    valorant: valorant,
                                    ow: ow,
                                    rl: rl,
                                  );

                                  await editGamePageGamesRanksRecord.reference
                                      .update(gamesRanksRecordData);
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.check_circle_outlined,
                                  color: Color(0xFF444771),
                                  size: 20,
                                ),
                                iconSize: 20,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
