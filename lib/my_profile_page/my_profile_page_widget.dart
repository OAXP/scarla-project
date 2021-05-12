import 'package:scarla/util/transparent_route.dart';

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
                              padding: EdgeInsets.fromLTRB(0, 45, 1, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        showDialog(

                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,

                                              shape: RoundedRectangleBorder(

                                                borderRadius: BorderRadius.circular(10.0),
                                              ),

                                              // title: Center(child: Text('Alert!')),
                                              content: Text('Are you sure you want \n to log out?',textAlign: TextAlign.center,
                                              style:  TextStyle( fontFamily: 'Poppins', fontWeight: FontWeight.w600),),
                                             // insetPadding: EdgeInsets.fromLTRB(70,0,20,0),
                                              buttonPadding:  EdgeInsets.fromLTRB(0,30,4,0),
                                              actions: <Widget>[
                                                Column(
                                                  children: [

                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(0,0,19,15),
                                                          child: Container(
                                                            width:250,
                                                            height:2,
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: Colors.grey[300],),

                                                          ),

                                                    ),
                                                      ),
                                                    Row(
                                                      children: [

                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(0,0,14,0),
                                                          child: Container(
                                                            width:107,
                                                            height:47,
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: Colors.grey,),
                                                            child: TextButton(

                                                              child: Text('Cancel',style: TextStyle(color: Colors.white),),


                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(0,0,26,0),
                                                          child: Container(
                                                            width:107,
                                                            height:47,
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: Color(0xffff4553),),
                                                            child: TextButton(

                                                              child: Text('Log Out',style: TextStyle(color: Colors.white),),


                                                              onPressed: () async {
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
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )


                                              ],
                                            );
                                          },
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
                                  padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
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
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 6, 20, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        stackUsersRecord.selectedGames.length,
                                        (gameIndex) {
                                      final game = stackUsersRecord
                                          .selectedGames[gameIndex];
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              TransparentRoute(
                                                builder: (context) =>
                                                    RankPageWidget(
                                                  username:
                                                      stackUsersRecord.name,
                                                  game: game,
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
                                            child: Image.asset(
                                              'assets/games/icons/${game}Icon.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(4, 6, 0, 0),
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
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                          child: Text(
                                            "No Squads yet..",
                                            style: FlutterFlowTheme.title1.override(
                                              fontFamily: 'Poppins',
                                              fontSize: 20
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
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
                                                    groupPf: gridViewGroupsRecord.gPhotoUrl
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
                                                    overflow: TextOverflow.ellipsis,
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
