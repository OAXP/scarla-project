import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../home_page/home_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Su4PageWidget extends StatefulWidget {
  Su4PageWidget(
      {Key key,
      this.username,
      this.tag,
      this.photoUrl,
      this.about,
      this.isLol,
      this.isVal,
      this.isCod,
      this.isOw,
      this.isRl})
      : super(key: key);

  final String username;
  final String tag;
  final String photoUrl;
  final String about;
  final bool isLol;
  final bool isVal;
  final bool isCod;
  final bool isOw;
  final bool isRl;

  @override
  _Su4PageWidgetState createState() => _Su4PageWidgetState();
}

class _Su4PageWidgetState extends State<Su4PageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.primaryColor,
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.17,
                    decoration: BoxDecoration(
                      color: Color(0xFFB7B7B7),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://media.discordapp.net/attachments/530418694841565186/819976832321454160/wonderEggSniper.gif',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.17,
                    decoration: BoxDecoration(
                      color: Color(0x81000000),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: FaIcon(
                            FontAwesomeIcons.pen,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment(0, -45.5),
                            child: Container(
                              width: 104,
                              height: 104,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -1.3),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              child: Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: widget.photoUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.username,
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(2, 0, 1, 0),
                              child: Text(
                                '#',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFB2B2B2),
                                ),
                              ),
                            ),
                            Text(
                              widget.tag,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Color(0xFFB2B2B2),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 300,
                          maxHeight: 100,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(45, 5, 45, 5),
                          child: Text(
                            widget.about,
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF979797),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Color(0x23F5F5F5),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'Games',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      StreamBuilder<List<UsersRecord>>(
                        stream: queryUsersRecord(),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          List<UsersRecord> rowUsersRecordList = snapshot.data;
                          // Customize what your widget looks like with no query results.
                          if (snapshot.data.isEmpty) {
                            // return Container();
                            // For now, we'll just include some dummy data.
                            rowUsersRecordList =
                                createDummyUsersRecord(count: 4);
                          }
                          return Padding(
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(rowUsersRecordList.length,
                                  (rowIndex) {
                                final rowUsersRecord =
                                    rowUsersRecordList[rowIndex];
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await launchURL(
                                          'https://www.youtube.com/watch?v=xVSjcrwBI1Y');
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://pbs.twimg.com/profile_images/1291867974790295552/AFRVxzDT_400x400.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 370, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 1, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFF4D5078),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: 140,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0x00EEEEEE),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        'Back',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(70, 1, 6, 0),
                          child: InkWell(
                            onTap: () async {
                              final about = widget.about;
                              final id = currentUserUid;
                              final name = widget.username;
                              final photoUrl = widget.photoUrl;
                              final bgProfile =
                                  'https://media.discordapp.net/attachments/530418694841565186/819976832321454160/wonderEggSniper.gif';
                              final tag = widget.tag;
                              final sexe = 0;

                              final usersRecordData = {
                                ...createUsersRecordData(
                                  about: about,
                                  id: id,
                                  name: name,
                                  photoUrl: photoUrl,
                                  bgProfile: bgProfile,
                                  tag: tag,
                                  sexe: sexe,
                                ),
                                'selected_games':
                                    FieldValue.arrayUnion([widget.isLol]),
                              };

                              await currentUserReference
                                  .update(usersRecordData);
                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePageWidget(),
                                ),
                              );
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFF4D5078),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: 140,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4D5078),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        'Finish',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(27, 0, 0, 0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
