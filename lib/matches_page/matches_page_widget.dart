import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:scarla/auth/firebase_user_provider.dart';
import 'package:scarla/create_group_page/create_group_page_widget.dart';
import 'package:scarla/flutter_flow/flutter_flow_util.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../profile_page/profile_page_widget.dart';
import '../youtube_player_page/youtube_player_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchesPageWidget extends StatefulWidget {
  MatchesPageWidget({Key key, this.game, this.competitive}) : super(key: key);

  final String game;
  final List<bool> competitive;

  @override
  _MatchesPageWidgetState createState() => _MatchesPageWidgetState();
}

class _MatchesPageWidgetState extends State<MatchesPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<UsersRecord> selectedUsers = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
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
                          style: FlutterFlowTheme.title1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        child: IconButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateGroupPageWidget(
                                  selectedUsers: selectedUsers,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            FluentIcons.checkmark_circle_48_regular,
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
              if (selectedUsers.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedUsers.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewUsersRecord =
                              selectedUsers[listViewIndex];
                              return Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.tertiaryColor,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedUsers.remove(listViewUsersRecord);
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: FlutterFlowTheme.secondaryColor,
                                          size: 24,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    listViewUsersRecord.photoUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            child:
                                            Text(
                                              listViewUsersRecord.name,
                                              style:
                                              FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),

                                              /* Text(
                                              "${listViewUsersRecord.name}#${listViewUsersRecord.tag}",
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),*/
                                          ),

                                          Text(
                                            '#',
                                            style:
                                                FlutterFlowTheme.bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF838383),
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            listViewUsersRecord.tag,
                                                  style: FlutterFlowTheme.bodyText1
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF838383),
                                                    fontSize: 10,
                                                  ),
                                                )

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              );
                            },
                          ),
                        ),
                  ),
                  Divider(
                    height: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Color(0xFF666666),
                    thickness: 0.3,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                ],
              ),

              Expanded(
                child: StreamBuilder<List<UsersRecord>>(
                  stream: queryUsersRecord(
                    queryBuilder: (usersRecord) => usersRecord
                        .where('selected_games', arrayContains: widget.game)
                        .where('isCompetitive', whereIn: widget.competitive)
                        .where('uid', isNotEqualTo: currentUserUid),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<UsersRecord> listViewUsersRecordList = snapshot.data;
                    // Customize what your widget looks like with no query results.
                    if (listViewUsersRecordList.isEmpty) {
                      return Center(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://static.thenounproject.com/png/449469-200.png',
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewUsersRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewUsersRecord =
                              listViewUsersRecordList[listViewIndex];

                          return Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePageWidget(
                                      userRef: listViewUsersRecord.reference,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape:RoundedRectangleBorder(

                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: FlutterFlowTheme.title1Color,
                                elevation: 5,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0, 0),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                                imageUrl: listViewUsersRecord
                                                    .photoUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),

                                              Padding(
                                                padding: EdgeInsets.fromLTRB(3, 0, 15, 0),
                                                child: Row(
                                                  children: [

                                                    Text(
                                                      listViewUsersRecord.name,
                                                      textAlign:
                                                      TextAlign.justify,
                                                      style: FlutterFlowTheme
                                                          .subtitle2
                                                          .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 15
                                                      ),
                                                    ),
                                                    Text(
                                                      '#',
                                                      textAlign:
                                                      TextAlign.justify,
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15
                                                      ),
                                                    ),
                                                    Text(
                                                      listViewUsersRecord.tag,
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  21, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                5, 0, 0, 0),
                                                        child: Text(
                                                          'Rank : ',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .subtitle2
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                                fontSize: 15
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 30,
                                                        height: 30,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.asset(
                                                          'assets/games/ranks/valorant/20.png',
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
                                                setState(() {
                                                  if(!selectedUsers.contains(listViewUsersRecord)) {
                                                    selectedUsers.add(listViewUsersRecord);
                                                  }
                                                });
                                              },
                                              icon: Icon(
                                                FluentIcons.person_add_20_regular,
                                                color: Colors.white,
                                                size: 28,
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
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
