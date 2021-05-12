import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scarla/add_post_page/add_post_page_widget.dart';
import 'package:scarla/auth/auth_util.dart';
import 'package:scarla/backend/backend.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';
import 'package:scarla/profile_page/profile_page_widget.dart';
import 'package:scarla/util/transparent_route.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key key, this.isLastPost, this.postRecord})
      : super(key: key);
  final bool isLastPost;
  final FeedRecord postRecord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, (isLastPost) ? 110 : 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: FlutterFlowTheme.tertiaryColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 3, 2),
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
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePageWidget(
                                  userRef: postRecord.authorRef,
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
                              imageUrl: postRecord.authorPhotoUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePageWidget(
                                    userRef: postRecord.authorRef,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                              child: Text(
                                postRecord.authorName,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.horizontal_rule_rounded,
                                    size: 45,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        color: FlutterFlowTheme.title1Color
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.tertiaryColor,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if(postRecord.authorId == currentUserUid)
                                            InkWell(
                                              onTap: () async {
                                                await postRecord.reference.delete();
                                              },
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Delete",
                                                    style: FlutterFlowTheme.bodyText1.override(
                                                      color: Colors.red,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                Navigator.pop(context);
                                                await Navigator.push(
                                                  context,
                                                  TransparentRoute(
                                                    builder: (context) => AddPostPageWidget(
                                                      userRef: currentUserReference,
                                                      initValue: postRecord.content,
                                                      initImage: postRecord.imageUrl,
                                                      chosenGame: postRecord.game,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Repost",
                                                    style: FlutterFlowTheme.bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Cancel",
                                                    style: FlutterFlowTheme.bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.keyboard_control,
                        color: Colors.white,
                        size: 15,
                      ),
                      iconSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 300,
                  maxHeight: 100,
                ),
                decoration: BoxDecoration(
                  color: Color(0x00EEEEEE),
                ),
                child: Text(
                  postRecord.content,
                  style: FlutterFlowTheme.bodyText2.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: (postRecord.imageUrl.trim() == "") ? 0 : 200,
              decoration: BoxDecoration(
                color: Color(0x00EEEEEE),
              ),
              child: (postRecord.imageUrl.trim() == "")
                  ? Container()
                  : CachedNetworkImage(
                      imageUrl: postRecord.imageUrl,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      fit: BoxFit.cover,
                    ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      TransparentRoute(
                        builder: (context) => AddPostPageWidget(
                          userRef: currentUserReference,
                          initValue: postRecord.content,
                          initImage: postRecord.imageUrl,
                          chosenGame: postRecord.game,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.repeat,
                    color: Color(0xFF444771),
                    size: 20,
                  ),
                  iconSize: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
