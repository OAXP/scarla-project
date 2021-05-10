import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scarla/chat_page/widgets/chat_message_other.dart';
import 'package:scarla/chat_page/widgets/chat_message_self.dart';
import 'package:scarla/chat_page/widgets/message_form.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scarla/group_list_page/group_list_page_widget.dart';
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
import 'package:imgur/imgur.dart' as imgur;

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
  final messageListController = ScrollController();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  void _addMessage(Map msgMap) async {
    String value = msgMap['value'];
    int type = msgMap['type'];
    switch (type) {
      case 0:
        value = value;
        break;
      case 1:case 2:
        setState(() {
          FlutterFlowTheme.isUploading = true;
        });
        final client = imgur.Imgur(
            imgur.Authentication.fromClientId(
                '2a04555f27563dc'));
        await client.image
            .uploadImage(
            imagePath: value,
            title: '*_*',
            description: '*_*')
            .then(
                (image) {
                  value = image.link;
                  setState(() {
                    FlutterFlowTheme.isUploading = false;
                  });
                });
        break;
      default:
        print("Not configured yet");
    }
    final authorId = currentUserUid;
    final groupRef = widget.groupRef;
    final timestamp = getCurrentTimestamp;
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

    final groupsRecordData =
    createGroupsRecordData(
      lastMessage: value,
      lastMessageTimestamp: getCurrentTimestamp,
    );

    await widget.groupRef
        .update(groupsRecordData);

    messageListController.animateTo(
        messageListController
            .position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut);
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
                                    Icons.arrow_back_ios,
                                    color: FlutterFlowTheme.title1Color,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  widget.groupName,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                      PageTransition(child:   GroupsSettingsPageWidget(
                                        groupRef: widget.groupRef,
                                        groupName: widget.groupName,
                                      ), type: PageTransitionType.rightToLeftWithFade,duration: Duration(milliseconds: 400),
                                        reverseDuration: Duration(milliseconds: 400),)

                                  );
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: FlutterFlowTheme.title1Color,
                                  size: 33,
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
                                .orderBy('timestamp', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            List<GMessagesRecord> listViewGMessagesRecordList =
                                snapshot.data;
                            bool shouldDisplayAvatar(int index) {
                              if (index == 0) return true;

                              final previousId =
                                  listViewGMessagesRecordList[index - 1]
                                      .authorId;
                              final authorId =
                                  listViewGMessagesRecordList[index].authorId;
                              return authorId != previousId;
                            }

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
                              controller: messageListController,
                              padding: EdgeInsets.zero,
                              reverse: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewGMessagesRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGMessagesRecord =
                                    listViewGMessagesRecordList[listViewIndex];
                                if (currentUserUid ==
                                    listViewGMessagesRecord.authorId) {
                                  return Dismissible(
                                    onDismissed: (_) {
                                      listViewGMessagesRecord.reference
                                          .delete();
                                    },
                                    key: ValueKey(
                                        listViewGMessagesRecord.timestamp),
                                    child: ChatMessage(
                                      index: listViewIndex,
                                      data: listViewGMessagesRecord,
                                      nbElements: listViewGMessagesRecordList.length,
                                    ),
                                  );
                                }
                                return ChatMessageOther(
                                  index: listViewIndex,
                                  data: listViewGMessagesRecord,
                                  showAvatar:
                                      shouldDisplayAvatar(listViewIndex),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      MessageForm(
                        onSubmit: _addMessage,
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
