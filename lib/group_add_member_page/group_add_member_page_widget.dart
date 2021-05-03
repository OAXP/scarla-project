import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../youtube_player_page/youtube_player_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupAddMemberPageWidget extends StatefulWidget {
  GroupAddMemberPageWidget({Key key, this.groupRef}) : super(key: key);

  final DocumentReference groupRef;

  @override
  _GroupAddMemberPageWidgetState createState() =>
      _GroupAddMemberPageWidgetState();
}

class _GroupAddMemberPageWidgetState extends State<GroupAddMemberPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
          Stack(
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_sharp,
                                color: Color(0xFF535480),
                                size: 30,
                              ),
                              iconSize: 30,
                            ),
                            Text(
                              'Friends list',
                              style: FlutterFlowTheme.title1.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final groupsRecordData = {
                                  'members_id':
                                      FieldValue.arrayUnion(['I am a user ID']),
                                };

                                await widget.groupRef.update(groupsRecordData);
                              },
                              icon: Icon(
                                Icons.check_rounded,
                                color: Color(0xFF535480),
                                size: 30,
                              ),
                              iconSize: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<List<FriendsRecord>>(
                        stream: queryFriendsRecord(
                          queryBuilder: (friendsRecord) => friendsRecord
                              .where('friends',
                                  arrayContains: currentUserReference)
                              .orderBy('status'),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          List<FriendsRecord> listViewFriendsRecordList =
                              snapshot.data;
                          // Customize what your widget looks like with no query results.
                          if (listViewFriendsRecordList.isEmpty) {
                            return Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://static.thenounproject.com/png/655186-200.png',
                              ),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewFriendsRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewFriendsRecord =
                                    listViewFriendsRecordList[listViewIndex];
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              YoutubePlayerPageWidget(
                                            url:
                                                'https://www.youtube.com/watch?v=K1PCl5D-IpU',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0x85F5F5F5),
                                      elevation: 5,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment(0, 0),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 5, 5, 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        height: 80,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'https://i.imgur.com/JXZBBeX.gif',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                5, 0, 0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              'Name',
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .subtitle1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                            Text(
                                                              '#',
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .subtitle1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                            Text(
                                                              'TAG',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .subtitle1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              YoutubePlayerPageWidget(
                                                            url:
                                                                'https://youtu.be/ByrUgKNV42Q',
                                                          ),
                                                        ),
                                                      );
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
              )
            ],
          )
        ],
      ),
    );
  }
}
