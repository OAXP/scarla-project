import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../groups_settings_page/groups_settings_page_widget.dart';
import '../profile_page/profile_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPageWidget extends StatefulWidget {
  ChatPageWidget({Key key, this.groupName, this.groupRef}) : super(key: key);

  final String groupName;
  final DocumentReference groupRef;

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: StreamBuilder<UsersRecord>(
        stream: UsersRecord.getDocument(currentUserReference),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final stackUsersRecord = snapshot.data;
          return Stack(
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
                                    Icons.arrow_back_ios,
                                    color: Color(0xFF535480),
                                    size: 24,
                                  ),
                                ),
                              ),
                              Text(
                                widget.groupName,
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.title1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GroupsSettingsPageWidget(
                                        groupRef: widget.groupRef,
                                        groupName: widget.groupName,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.settings,
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
                        child: StreamBuilder<List<GMessagesRecord>>(
                          stream: queryGMessagesRecord(
                            queryBuilder: (gMessagesRecord) => gMessagesRecord
                                .where('group_ref', isEqualTo: widget.groupRef)
                                .where('type', isEqualTo: 0)
                                .orderBy('timestamp'),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            List<GMessagesRecord> listViewGMessagesRecordList =
                                snapshot.data;
                            // Customize what your widget looks like with no query results.
                            if (listViewGMessagesRecordList.isEmpty) {
                              return Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn.iconscout.com/icon/free/png-256/no-message-1442326-1218395.png',
                                ),
                              );
                            }
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewGMessagesRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGMessagesRecord =
                                    listViewGMessagesRecordList[listViewIndex];
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 4, 10, 0),
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        StreamBuilder<UsersRecord>(
                                          stream: UsersRecord.getDocument(
                                              listViewGMessagesRecord
                                                  .authorRef),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            final columnUsersRecord =
                                                snapshot.data;
                                            return InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePageWidget(
                                                      userRef: columnUsersRecord
                                                          .reference,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    columnUsersRecord.name,
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF535480),
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          columnUsersRecord
                                                              .photoUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 20, 10, 1),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 0, 5, 0),
                                              child: Text(
                                                listViewGMessagesRecord.value,
                                                textAlign: TextAlign.start,
                                                style: FlutterFlowTheme
                                                    .subtitle1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                          color: Color(0x83FFFFFF),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(
                                      Icons.image,
                                      color: FlutterFlowTheme.primaryColor,
                                      size: 26,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: textController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Send a chat',
                                        hintStyle:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
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
                                        fillColor: Colors.white,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      ),
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        final authorId = currentUserUid;
                                        final groupRef = widget.groupRef;
                                        final timestamp = getCurrentTimestamp;
                                        final type = 0;
                                        final value = textController.text;
                                        final authorRef = currentUserReference;

                                        final gMessagesRecordData =
                                            createGMessagesRecordData(
                                          authorId: authorId,
                                          groupRef: groupRef,
                                          timestamp: timestamp,
                                          type: type,
                                          value: value,
                                          authorRef: authorRef,
                                        );

                                        await GMessagesRecord.collection
                                            .doc()
                                            .set(gMessagesRecordData);
                                        final lastMessage = textController.text;

                                        final groupsRecordData =
                                            createGroupsRecordData(
                                          lastMessage: lastMessage,
                                        );

                                        await widget.groupRef
                                            .update(groupsRecordData);
                                      },
                                      text: 'SEND',
                                      options: FFButtonOptions(
                                        width: 75,
                                        height: 40,
                                        color: FlutterFlowTheme.primaryColor,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
