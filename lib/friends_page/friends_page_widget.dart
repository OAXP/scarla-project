import 'package:scarla/auth/firebase_user_provider.dart';
import 'package:scarla/chat_page/chat_page_widget.dart';
import 'package:scarla/flutter_flow/flutter_flow_widgets.dart';
import 'package:scarla/profile_page/profile_page_widget.dart';

import '../add_friend_page/add_friend_page_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../youtube_player_page/youtube_player_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsPageWidget extends StatefulWidget {
  FriendsPageWidget({Key key}) : super(key: key);

  @override
  _FriendsPageWidgetState createState() => _FriendsPageWidgetState();
}

class _FriendsPageWidgetState extends State<FriendsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
          ),
          Column(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Align(
                        alignment: Alignment(0, 0),
                        child: Text(
                          'Friends',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.title1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment(1, 0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 11, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFriendPageWidget(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.person_add_alt_1_rounded,
                                color: FlutterFlowTheme.title1Color,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<FriendsRecord>>(
                  stream: queryFriendsRecord(
                    queryBuilder: (friendsRecord) => friendsRecord
                            .where('friends', arrayContains: currentUserReference)
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
                      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
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
                          final isRequested =
                              (listViewFriendsRecord.friends.first ==
                                  currentUserReference);
                          return StreamBuilder<UsersRecord>(
                              stream: UsersRecord.getDocument(refToTake),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                final userRecord = snapshot.data;

                                return InkWell(
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
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 7, 15, 8),
                                    child: Container(
                                      color: FlutterFlowTheme.tertiaryColor,
                                      height: 70,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.fromLTRB(6, 0, 0, 0),
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: userRecord.photoUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    11, 0, 0, 0),
                                                child: Text(
                                                  '${userRecord.name}#${userRecord.tag}',
                                                  style: FlutterFlowTheme.bodyText1
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          if (listViewFriendsRecord.status == 1)
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    final isGroupRecord =
                                                        await queryGroupsRecord(
                                                            queryBuilder:
                                                                (groupsRecord) =>
                                                                    groupsRecord.where(
                                                                        'members_id',
                                                                        whereIn: [
                                                                          [
                                                                            userRecord
                                                                                .uid,
                                                                            currentUserUid
                                                                          ],
                                                                          [
                                                                            currentUserUid,
                                                                            userRecord
                                                                                .uid
                                                                          ]
                                                                        ])).first;

                                                    GroupsRecord group;
                                                    String myName = (await UsersRecord
                                                                .getDocument(
                                                                    currentUserReference)
                                                            .first)
                                                        .name;

                                                    if (isGroupRecord.isEmpty) {
                                                      final gName =
                                                          "${userRecord.name} and $myName";
                                                      final gPhotoUrl =
                                                          userRecord.photoUrl;
                                                      final lastMessage = '...';

                                                      final groupsRecordData = {
                                                        ...createGroupsRecordData(
                                                          gName: gName,
                                                          gPhotoUrl: gPhotoUrl,
                                                          lastMessage: lastMessage,
                                                        ),
                                                        'members_id': [
                                                          userRecord.uid,
                                                          currentUserUid
                                                        ],
                                                      };

                                                      await GroupsRecord.collection
                                                          .doc()
                                                          .set(groupsRecordData);

                                                      group =
                                                          (await queryGroupsRecord(
                                                                  queryBuilder: (groupsRecord) =>
                                                                      groupsRecord.where(
                                                                          'members_id',
                                                                          whereIn: [
                                                                            [
                                                                              userRecord
                                                                                  .uid,
                                                                              currentUserUid
                                                                            ],
                                                                            [
                                                                              currentUserUid,
                                                                              userRecord
                                                                                  .uid
                                                                            ]
                                                                          ])).first)
                                                              .first;
                                                    } else {
                                                      group = isGroupRecord.first;
                                                    }

                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatPageWidget(
                                                          groupName: group.gName,
                                                          groupRef: group.reference,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.message,
                                                    color: Color(0xFFF2F2F2),
                                                    size: 24,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await listViewFriendsRecord
                                                        .reference
                                                        .delete();
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Color(0xFFF2F2F2),
                                                    size: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (listViewFriendsRecord.status == 0 &&
                                              !isRequested)
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    final friendshipData = {
                                                      ...createFriendsRecordData(
                                                        status: 1,
                                                      )
                                                    };

                                                    await listViewFriendsRecord
                                                        .reference
                                                        .update(friendshipData);
                                                  },
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Color(0xFFF2F2F2),
                                                    size: 24,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await listViewFriendsRecord
                                                        .reference
                                                        .delete();
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Color(0xFFF2F2F2),
                                                    size: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (listViewFriendsRecord.status == 0 &&
                                              isRequested)
                                            InkWell(
                                              onTap: () async {
                                                await listViewFriendsRecord
                                                    .reference
                                                    .delete();
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Color(0xFFF2F2F2),
                                                size: 24,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
