import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../group_add_member_page/group_add_member_page_widget.dart';
import '../main.dart';
import '../profile_page/profile_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupsSettingsPageWidget extends StatefulWidget {
  GroupsSettingsPageWidget({Key key, this.groupRef, this.groupName})
      : super(key: key);

  final DocumentReference groupRef;
  final String groupName;

  @override
  _GroupsSettingsPageWidgetState createState() =>
      _GroupsSettingsPageWidgetState();
}

class _GroupsSettingsPageWidgetState extends State<GroupsSettingsPageWidget> {
  TextEditingController groupNameFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    groupNameFieldController = TextEditingController(text: widget.groupName);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GroupsRecord>(
      stream: GroupsRecord.getDocument(widget.groupRef),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final groupsSettingsPageGroupsRecord = snapshot.data;
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
                                  'Group Settings',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final gName = groupNameFieldController.text;
                                    final gPhotoUrl =
                                        groupsSettingsPageGroupsRecord
                                            .gPhotoUrl;

                                    final groupsRecordData = {
                                      ...createGroupsRecordData(
                                        gName: gName,
                                        gPhotoUrl: gPhotoUrl,
                                      ),
                                      'members_id': FieldValue.arrayUnion(
                                          [currentUserUid]),
                                    };

                                    await widget.groupRef
                                        .update(groupsRecordData);
                                    Navigator.pop(context);
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(0, 0),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: groupsSettingsPageGroupsRecord
                                        .gPhotoUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0, 0),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(65, 0, 0, 0),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Color(0xAEC1C1C1),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Color(0x9CCBCBCB),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.pen,
                                            color: Colors.black,
                                            size: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(),
                          child: TextFormField(
                            controller: groupNameFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Group Name',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Poppins',
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFF4D5078),
                            ),
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await widget.groupRef.delete();
                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavBarPage(
                                          initialPage: 'GroupListPage'),
                                    ),
                                    (r) => false,
                                  );
                                },
                                text: 'Delete Group',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  color: FlutterFlowTheme.secondaryColor,
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final groupsRecordData = {
                                    'members_id': FieldValue.arrayRemove(
                                        [currentUserUid]),
                                  };

                                  await widget.groupRef
                                      .update(groupsRecordData);
                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavBarPage(
                                          initialPage: 'GroupListPage'),
                                    ),
                                    (r) => false,
                                  );
                                },
                                text: 'Leave Group',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  color: FlutterFlowTheme.secondaryColor,
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.black,
                                size: 30,
                              ),
                              Text(
                                'Members',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.title3.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GroupAddMemberPageWidget(
                                        groupRef: widget.groupRef,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                iconSize: 30,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder<List<UsersRecord>>(
                            stream: queryUsersRecord(
                              queryBuilder: (usersRecord) => usersRecord
                                  .where('uid', isEqualTo: '1ReplaceByIn'),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              List<UsersRecord> listViewUsersRecordList =
                                  snapshot.data;
                              // Customize what your widget looks like with no query results.
                              if (snapshot.data.isEmpty) {
                                // return Container();
                                // For now, we'll just include some dummy data.
                                listViewUsersRecordList =
                                    createDummyUsersRecord(count: 4);
                              }
                              return Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewUsersRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewUsersRecord =
                                        listViewUsersRecordList[listViewIndex];
                                    return InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePageWidget(
                                              userRef:
                                                  listViewUsersRecord.reference,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Color(0x85F5F5F5),
                                        child: Align(
                                          alignment: Alignment(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            listViewUsersRecord
                                                                .photoUrl,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            listViewUsersRecord
                                                                .name,
                                                            textAlign: TextAlign
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
                                                            textAlign: TextAlign
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
                                                            listViewUsersRecord
                                                                .tag,
                                                            textAlign:
                                                                TextAlign.start,
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
                                                  onPressed: () {
                                                    print(
                                                        'IconButton pressed ...');
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_sharp,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                  iconSize: 30,
                                                )
                                              ],
                                            ),
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
      },
    );
  }
}
