import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPostPageWidget extends StatefulWidget {
  AddPostPageWidget({Key key, this.userRef, this.initValue}) : super(key: key);

  final DocumentReference userRef;
  final String initValue;

  @override
  _AddPostPageWidgetState createState() => _AddPostPageWidgetState();
}

class _AddPostPageWidgetState extends State<AddPostPageWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.initValue);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.userRef),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final addPostPageUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0x7A000000),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment(0, 0),
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.tertiaryColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x00EEEEEE),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              addPostPageUsersRecord.photoUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Text(
                                          addPostPageUsersRecord.name,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(0, 0),
                                  child: IconButton(
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                    icon: Icon(
                                      Icons.keyboard_control,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    iconSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0x00EEEEEE),
                            ),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Content..',
                                hintStyle: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 9,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: Color(0xFF444771),
                                  size: 20,
                                ),
                                iconSize: 20,
                              ),
                              IconButton(
                                onPressed: () async {
                                  final authorId = currentUserUid;
                                  final authorName =
                                      addPostPageUsersRecord.name;
                                  final content = textController.text;
                                  final game = 'valorant';
                                  final type = 0;
                                  final authorPhotoUrl =
                                      addPostPageUsersRecord.photoUrl;
                                  final id = '';
                                  final timestamp = getCurrentTimestamp;
                                  final authorRef = widget.userRef;

                                  final feedRecordData = createFeedRecordData(
                                    authorId: authorId,
                                    authorName: authorName,
                                    content: content,
                                    game: game,
                                    type: type,
                                    authorPhotoUrl: authorPhotoUrl,
                                    id: id,
                                    timestamp: timestamp,
                                    authorRef: authorRef,
                                  );

                                  await FeedRecord.collection
                                      .doc()
                                      .set(feedRecordData);
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.send_outlined,
                                  color: Color(0xFF444771),
                                  size: 20,
                                ),
                                iconSize: 20,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
