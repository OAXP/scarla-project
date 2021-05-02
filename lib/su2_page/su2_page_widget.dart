import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/upload_media.dart';
import '../su3_page/su3_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Su2PageWidget extends StatefulWidget {
  Su2PageWidget({Key key, this.username, this.tag}) : super(key: key);

  final String username;
  final String tag;

  @override
  _Su2PageWidgetState createState() => _Su2PageWidgetState();
}

class _Su2PageWidgetState extends State<Su2PageWidget> {
  String uploadedFileUrl;
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 100, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Create your profile',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<UsersRecord>(
                      stream: UsersRecord.getDocument(currentUserReference),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final listViewUsersRecord = snapshot.data;
                        return ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final selectedMedia = await selectMedia();
                                      if (selectedMedia != null &&
                                          validateFileFormat(
                                              selectedMedia.storagePath,
                                              context)) {
                                        showUploadMessage(
                                            context, 'Uploading file...',
                                            showLoading: true);
                                        final downloadUrl = await uploadData(
                                            selectedMedia.storagePath,
                                            selectedMedia.bytes);
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        if (downloadUrl != null) {
                                          setState(() =>
                                              uploadedFileUrl = downloadUrl);
                                          showUploadMessage(
                                              context, 'Success!');
                                        } else {
                                          showUploadMessage(context,
                                              'Failed to upload media');
                                        }
                                      }
                                    },
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
                                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment(0, 0),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                65, 0, 0, 0),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Color(0xAEC1C1C1),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: Color(0x9CCBCBCB),
                                                ),
                                              ),
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
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: TextFormField(
                                controller: textController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'My description ...',
                                  hintStyle:
                                      FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF4D5078),
                                ),
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Poppins',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 3,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Are you Competitive',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    ToggleIcon(
                                      onPressed: () async {
                                        final isCompetitive =
                                            !listViewUsersRecord.isCompetitive;

                                        final usersRecordData =
                                            createUsersRecordData(
                                          isCompetitive: isCompetitive,
                                        );

                                        await listViewUsersRecord.reference
                                            .update(usersRecordData);
                                      },
                                      value: listViewUsersRecord.isCompetitive,
                                      onIcon: Icon(
                                        Icons.check_box,
                                        color: Color(0xFF535480),
                                        size: 23,
                                      ),
                                      offIcon: Icon(
                                        Icons.check_box_outline_blank,
                                        color: Color(0xFF535480),
                                        size: 23,
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
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 1, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFF4D5078),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: 140,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0x00EEEEEE),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        'Back',
                                        style: FlutterFlowTheme.title2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(70, 1, 6, 0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Su3PageWidget(
                                    username: widget.username,
                                    tag: widget.tag,
                                    photoUrl:
                                        'https://media1.tenor.com/images/5fe8472849d4408271c2cfdbb35fd3f6/tenor.gif?itemid=20768761',
                                    about: textController.text,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFF4D5078),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: 140,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4D5078),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                                      child: Text(
                                        'Next',
                                        style: FlutterFlowTheme.title2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
