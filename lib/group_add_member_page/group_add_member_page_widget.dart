import 'package:scarla/profile_page/profile_page_widget.dart';

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
                        color: FlutterFlowTheme.appBarColor,
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
                                color: FlutterFlowTheme.title1Color,
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

                                List<String> membersId = List.empty(growable: true);
                                for(UsersRecord user in selectedUsers) {
                                  membersId.add(user.uid);
                                }

                                final groupsRecordData = {
                                  'members_id':
                                      FieldValue.arrayUnion(membersId),
                                };

                                await widget.groupRef.update(groupsRecordData);

                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.check_rounded,
                                color: FlutterFlowTheme.title1Color,
                                size: 30,
                              ),
                              iconSize: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    if ((selectedUsers != null) ? selectedUsers.isNotEmpty : false)
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
                                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                                                  EdgeInsets.fromLTRB(2, 0, 0, 0),
                                                  child: Text(
                                                    listViewUsersRecord.name,
                                                    style: FlutterFlowTheme.bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '#',
                                                  style: FlutterFlowTheme.bodyText1
                                                      .override(
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
                          SizedBox(height: 8,),
                          Divider(
                            height: 20,
                            indent: 20,
                            endIndent: 20,
                            color: Color(0xFF666666),
                            thickness: 0.3,
                          ),
                          SizedBox(height: 6,)
                        ],
                      ),
                    Expanded(
                      child: StreamBuilder<List<FriendsRecord>>(
                        stream: queryFriendsRecord(
                          queryBuilder: (friendsRecord) => friendsRecord
                              .where('friends',
                                  arrayContains: currentUserReference)
                              .where('status', isEqualTo: 1),
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
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewFriendsRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewFriendsRecord =
                                    listViewFriendsRecordList[listViewIndex];
                                final refToTake =
                                listViewFriendsRecord.friends.first ==
                                    currentUserReference
                                    ? listViewFriendsRecord.friends.last
                                    : listViewFriendsRecord.friends.first;
                                return StreamBuilder<UsersRecord>(
                                  stream: UsersRecord.getDocument(refToTake),
                                  builder: (context, snapshot) {
                                    final userRecord = snapshot.data;
                                    if(userRecord == null) {
                                      return Container();
                                    }
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                      child: InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProfilePageWidget(
                                                userRef: userRecord.reference,
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
                                                                  userRecord.photoUrl,
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
                                                                  userRecord.name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify,
                                                                  style:
                                                                      FlutterFlowTheme
                                                                          .subtitle2
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
                                                                          .bodyText2
                                                                          .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                          fontSize: 16
                                                                  ),
                                                                ),
                                                                Text(
                                                                  userRecord.tag,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      FlutterFlowTheme
                                                                          .bodyText2
                                                                          .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                          fontSize: 16
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      IconButton(
                                                        onPressed: () async {
                                                          final membersId = (await GroupsRecord.getDocument(widget.groupRef).first).membersId;

                                                          if(membersId.contains(userRecord.uid)) {
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("This user is already in this group.")));
                                                          } else {
                                                            setState(() {
                                                              if(!selectedUsers.contains(userRecord)) {
                                                                selectedUsers.add(userRecord);
                                                              }
                                                            });
                                                          }

                                                        },
                                                        icon: Icon(
                                                          Icons.add_circle_outline,
                                                          color: Colors.white,
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
                                  }
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
