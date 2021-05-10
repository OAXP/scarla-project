import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scarla/flutter_flow/upload_media.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imgur/imgur.dart' as imgur;
import '../main.dart';

class CreateGroupPageWidget extends StatefulWidget {
  List<UsersRecord> selectedUsers;
  CreateGroupPageWidget({Key key, this.selectedUsers}) : super(key: key);

  @override
  _CreateGroupPageWidgetState createState() => _CreateGroupPageWidgetState();
}

class _CreateGroupPageWidgetState extends State<CreateGroupPageWidget> {
  TextEditingController groupNameFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String groupPic;

  @override
  void initState() {
    super.initState();
    groupNameFieldController = TextEditingController();
  }

  Future getImage({bool isVideo = false}) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    if (isVideo) {
      pickedFile = await imagePicker.getVideo(source: ImageSource.gallery);
    } else {
      pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      final isValid = validateFileFormat(pickedFile.path, context);
      if (isValid) {
        setState(() {
          FlutterFlowTheme.isUploading = true;
        });
        final client =
        imgur.Imgur(imgur.Authentication.fromClientId('2a04555f27563dc'));
        await client.image
            .uploadImage(
            imagePath: pickedFile.path, title: '*_*', description: '*_*')
            .then((image) {
          groupPic = image.link;
          setState(() {
            FlutterFlowTheme.isUploading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.selectedUsers == null) {
      widget.selectedUsers = List.empty(growable: true);
    }

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
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: FlutterFlowTheme.title1Color,
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
                                final gName = groupNameFieldController.text;
                                final gPhotoUrl =
                                (groupPic != null) ? groupPic : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
                                final lastMessage = '...';

                                List<String> membersId = List.empty(growable: true);
                                for(UsersRecord user in widget.selectedUsers) {
                                  membersId.add(user.uid);
                                }
                                membersId.add(currentUserUid);

                                final groupsRecordData = {
                                  ...createGroupsRecordData(
                                    gName: gName,
                                    gPhotoUrl: gPhotoUrl,
                                    lastMessage: lastMessage,
                                    lastMessageTimestamp: getCurrentTimestamp,
                                    host: currentUserReference,
                                  ),
                                  'members_id': membersId,
                                };

                                await GroupsRecord.collection
                                    .doc()
                                    .set(groupsRecordData);
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NavBarPage(initialPage: 'GroupListPage'),
                                  ),
                                      (r) => false,
                                );
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(0, 0),
                            child: InkWell(
                              onTap: () {
                                getImage();
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: FlutterFlowTheme.tertiaryColor,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  (groupPic != null) ? groupPic : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                  fit: BoxFit.cover,
                                ),
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(35)
                        ],
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
                    if ((widget.selectedUsers != null) ? widget.selectedUsers.isNotEmpty : false)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.selectedUsers.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewUsersRecord =
                              widget.selectedUsers[listViewIndex];
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
                                            widget.selectedUsers.remove(listViewUsersRecord);
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
                              final refToTake =
                              listViewFriendsRecord.friends.first ==
                                  currentUserReference
                                  ? listViewFriendsRecord.friends.last
                                  : listViewFriendsRecord.friends.first;
                              return StreamBuilder<UsersRecord>(
                                stream: UsersRecord.getDocument(refToTake),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  final userRecord = snapshot.data;

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
                                                    userRecord.photoUrl,
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
                                                        userRecord.name,
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
                                                        userRecord.tag,
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
                                                setState(() {
                                                  if(!widget.selectedUsers.contains(userRecord)) {
                                                    widget.selectedUsers.add(userRecord);
                                                  }
                                                });
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
                                }
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
