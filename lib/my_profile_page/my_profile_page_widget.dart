import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../chat_page/chat_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
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
    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        queryBuilder: (usersRecord) =>
            usersRecord.where('id', isEqualTo: currentUserUid),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<UsersRecord> myProfilePageUsersRecordList = snapshot.data;
        // Customize what your widget looks like with no query results.
        if (snapshot.data.isEmpty) {
          // return Container();
          // For now, we'll just include some dummy data.
          myProfilePageUsersRecordList = createDummyUsersRecord(count: 1);
        }
        final myProfilePageUsersRecord = myProfilePageUsersRecordList.first;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.primaryColor,
                    ),
                    alignment: Alignment(0, 0),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.17,
                        decoration: BoxDecoration(
                          color: Color(0xFFB7B7B7),
                        ),
                        alignment: Alignment(0, 0),
                        child: CachedNetworkImage(
                          imageUrl: myProfilePageUsersRecord.bgProfile,
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.17,
                        decoration: BoxDecoration(
                          color: Color(0x81000000),
                        ),
                        alignment: Alignment(0, 0),
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
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SettingsPageWidget(
                                        photoUrl:
                                            myProfilePageUsersRecord.photoUrl,
                                        user:
                                            myProfilePageUsersRecord.reference,
                                        name: myProfilePageUsersRecord.name,
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
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
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
                                    alignment: Alignment(0, 0),
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
                                        imageUrl:
                                            myProfilePageUsersRecord.photoUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text(
                                myProfilePageUsersRecord.name,
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Container(
                                width: 100,
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Color(0xFF626262),
                                ),
                                alignment: Alignment(0, 0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                'My Games',
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
                                  padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        rowUsersRecordList.length, (rowIndex) {
                                      final rowUsersRecord =
                                          rowUsersRecordList[rowIndex];
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text(
                                'My Squads',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            StreamBuilder<List<GroupsRecord>>(
                              stream: queryGroupsRecord(),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                List<GroupsRecord> gridViewGroupsRecordList =
                                    snapshot.data;
                                // Customize what your widget looks like with no query results.
                                if (snapshot.data.isEmpty) {
                                  // return Container();
                                  // For now, we'll just include some dummy data.
                                  gridViewGroupsRecordList =
                                      createDummyGroupsRecord(count: 4);
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
                                    itemCount: gridViewGroupsRecordList.length,
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
                                                    gridViewGroupsRecord.gName,
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
                                          alignment: Alignment(0, 0),
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
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: gridViewGroupsRecord
                                                      .gPhotoUrl,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                gridViewGroupsRecord.gName,
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
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
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
