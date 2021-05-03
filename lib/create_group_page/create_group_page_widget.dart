import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateGroupPageWidget extends StatefulWidget {
  CreateGroupPageWidget({Key key}) : super(key: key);

  @override
  _CreateGroupPageWidgetState createState() => _CreateGroupPageWidgetState();
}

class _CreateGroupPageWidgetState extends State<CreateGroupPageWidget> {
  TextEditingController groupNameFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    groupNameFieldController = TextEditingController();
  }

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
                            Padding(
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
                            Text(
                              'Create a Group',
                              style: FlutterFlowTheme.title1.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final gId = 'id';
                                final gName = groupNameFieldController.text;
                                final gPhotoUrl =
                                    'https://media1.tenor.com/images/e7be01a78bf105f0e28875233f6b94b0/tenor.gif?itemid=20697311';
                                final lastMessage = '...';

                                final groupsRecordData = {
                                  ...createGroupsRecordData(
                                    gId: gId,
                                    gName: gName,
                                    gPhotoUrl: gPhotoUrl,
                                    lastMessage: lastMessage,
                                  ),
                                  'members_id':
                                      FieldValue.arrayUnion([currentUserUid]),
                                };

                                await GroupsRecord.collection
                                    .doc()
                                    .set(groupsRecordData);
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
                                imageUrl:
                                    'https://i.gyazo.com/be17e4932af4ee59c2b64a717b855f95.gif',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                    Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        'Add Members',
                        style: FlutterFlowTheme.title3.override(
                          fontFamily: 'Poppins',
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
                                    'https://static.thenounproject.com/png/449469-200.png',
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewFriendsRecordList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewFriendsRecord =
                                  listViewFriendsRecordList[listViewIndex];
                              return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color(0x85F5F5F5),
                                child: Align(
                                  alignment: Alignment(0, 0),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                            Container(
                                              width: 80,
                                              height: 80,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://i.imgur.com/JXZBBeX.gif',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Name',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: FlutterFlowTheme
                                                        .subtitle1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  Text(
                                                    '#',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: FlutterFlowTheme
                                                        .subtitle1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  Text(
                                                    'TAG',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme
                                                        .subtitle1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            print('IconButton pressed ...');
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
                                ),
                              );
                            },
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
