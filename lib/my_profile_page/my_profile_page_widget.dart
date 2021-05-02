import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../chat_page/chat_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../login_page/login_page_widget.dart';
import '../rank_page/rank_page_widget.dart';
import '../settings_page/settings_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfilePageWidget extends StatefulWidget {
  MyProfilePageWidget({Key key}) : super(key: key);

  @override
  _MyProfilePageWidgetState createState() => _MyProfilePageWidgetState();
}

class _MyProfilePageWidgetState extends State<MyProfilePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: StreamBuilder<List<UsersRecord>>(
        stream: queryUsersRecord(
          queryBuilder: (usersRecord) =>
              usersRecord.where('uid', isEqualTo: currentUserUid),
          singleRecord: true,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<UsersRecord> stackUsersRecordList = snapshot.data;
          // Customize what your widget looks like with no query results.
          if (snapshot.data.isEmpty) {
            // return Container();
            // For now, we'll just include some dummy data.
            stackUsersRecordList = createDummyUsersRecord(count: 1);
          }
          final stackUsersRecord = stackUsersRecordList.first;
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.primaryColor,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.17,
                              decoration: BoxDecoration(
                                color: Color(0xFFB7B7B7),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: stackUsersRecord.bgProfile,
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
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        await signOut();
                                        await Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPageWidget(),
                                          ),
                                          (r) => false,
                                        );
                                      },
                                      child: Icon(
                                        Icons.login_outlined,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SettingsPageWidget(
                                              photoUrl:
                                                  stackUsersRecord.photoUrl,
                                              user: stackUsersRecord.reference,
                                              name: stackUsersRecord.name,
                                              tag: stackUsersRecord.tag,
                                              bgProfile:
                                                  stackUsersRecord.bgProfile,
                                              about: stackUsersRecord.about,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                        size: 26,
                                      ),
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: stackUsersRecord.photoUrl,
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
                                        stackUsersRecord.name,
                                        textAlign: TextAlign.center,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 0, 1, 0),
                                        child: Text(
                                          '#',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        stackUsersRecord.tag,
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Poppins',
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
                                      stackUsersRecord.about,
                                      textAlign: TextAlign.center,
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
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
                                    'My Games',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                StreamBuilder<List<UsersRecord>>(
                                  stream: queryUsersRecord(),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    List<UsersRecord> rowUsersRecordList =
                                        snapshot.data;
                                    // Customize what your widget looks like with no query results.
                                    if (snapshot.data.isEmpty) {
                                      // return Container();
                                      // For now, we'll just include some dummy data.
                                      rowUsersRecordList =
                                          createDummyUsersRecord(count: 4);
                                    }
                                    return Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 2, 20, 2),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            rowUsersRecordList.length,
                                            (rowIndex) {
                                          final rowUsersRecord =
                                              rowUsersRecordList[rowIndex];
                                          return Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RankPageWidget(
                                                      username:
                                                          stackUsersRecord.name,
                                                      game: 'valorant',
                                                      userRef: stackUsersRecord
                                                          .reference,
                                                    ),
                                                  ),
                                                );
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
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    'My Squads',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                StreamBuilder<List<GroupsRecord>>(
                                  stream: queryGroupsRecord(
                                    queryBuilder: (groupsRecord) =>
                                        groupsRecord.where('members_id',
                                            arrayContains: currentUserUid),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    List<GroupsRecord>
                                        gridViewGroupsRecordList =
                                        snapshot.data;
                                    // Customize what your widget looks like with no query results.
                                    if (gridViewGroupsRecordList.isEmpty) {
                                      return Center(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://img.icons8.com/dotty/2x/nothing-found.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: GridView.builder(
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 0,
                                          childAspectRatio: 1,
                                        ),
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            gridViewGroupsRecordList.length,
                                        itemBuilder: (context, gridViewIndex) {
                                          final gridViewGroupsRecord =
                                              gridViewGroupsRecordList[
                                                  gridViewIndex];
                                          return InkWell(
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatPageWidget(
                                                    groupName:
                                                        gridViewGroupsRecord
                                                            .gName,
                                                    groupRef:
                                                        gridViewGroupsRecord
                                                            .reference,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0x00EEEEEE),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          gridViewGroupsRecord
                                                              .gPhotoUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Text(
                                                    gridViewGroupsRecord.gName,
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
