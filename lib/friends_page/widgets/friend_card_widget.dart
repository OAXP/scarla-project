import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scarla/auth/auth_util.dart';
import 'package:scarla/backend/backend.dart';
import 'package:scarla/chat_page/chat_page_widget.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';
import 'package:scarla/flutter_flow/flutter_flow_util.dart';
import 'package:scarla/profile_page/profile_page_widget.dart';

class FriendCardWidget extends StatelessWidget {
  const FriendCardWidget({Key key, this.refToTake, this.isRequested, this.friendsRecord, this.isLastFriend}) : super(key: key);
  final DocumentReference refToTake;
  final bool isRequested;
  final FriendsRecord friendsRecord;
  final bool isLastFriend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          0,
          0,
          0,
          isLastFriend
              ? 110
              : 0),
      child: StreamBuilder<UsersRecord>(
          stream: UsersRecord.getDocument(refToTake),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator());
            }
            final userRecord = snapshot.data;

            return InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePageWidget(
                      userRef: userRecord.reference,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 7, 9, 8),
                child: Container(

                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0,color: FlutterFlowTheme.title1Color),
                      color: FlutterFlowTheme.tertiaryColor,
                      borderRadius: BorderRadius.circular(15)
                  ),
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
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(6, 0, 0, 0),
                            child: Container(
                              width: 60,
                              height: 60,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                              ),
                              child: CachedNetworkImage(
                                imageUrl: userRecord.photoUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                11, 0, 0, 0),
                            child: Text(
                              '${userRecord.name}#${userRecord.tag}',
                              style: FlutterFlowTheme.bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          )
                        ],
                      ),
                      if (friendsRecord.status == 1)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,13,0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final isGroupRecord =
                                  await queryGroupsRecord(
                                      queryBuilder:
                                          (groupsRecord) =>
                                          groupsRecord.where(
                                              'members_id',
                                              whereIn: [
                                                [
                                                  userRecord
                                                      .uid,
                                                  currentUserUid
                                                ],
                                                [
                                                  currentUserUid,
                                                  userRecord
                                                      .uid
                                                ]
                                              ])).first;

                                  GroupsRecord group;
                                  String myName = (await UsersRecord
                                      .getDocument(
                                      currentUserReference)
                                      .first)
                                      .name;

                                  if (isGroupRecord.isEmpty) {
                                    final gName =
                                        "${userRecord.name} and $myName";
                                    final gPhotoUrl =
                                        userRecord.photoUrl;
                                    final lastMessage = '...';

                                    final groupsRecordData = {
                                      ...createGroupsRecordData(
                                        gName: gName,
                                        gPhotoUrl: gPhotoUrl,
                                        lastMessage: lastMessage,
                                        lastMessageTimestamp: getCurrentTimestamp,
                                      ),
                                      'members_id': [
                                        userRecord.uid,
                                        currentUserUid
                                      ],
                                    };

                                    await GroupsRecord.collection
                                        .doc()
                                        .set(groupsRecordData);

                                    group =
                                        (await queryGroupsRecord(
                                            queryBuilder: (groupsRecord) =>
                                                groupsRecord.where(
                                                    'members_id',
                                                    whereIn: [
                                                      [
                                                        userRecord
                                                            .uid,
                                                        currentUserUid
                                                      ],
                                                      [
                                                        currentUserUid,
                                                        userRecord
                                                            .uid
                                                      ]
                                                    ])).first)
                                            .first;
                                  } else {
                                    group = isGroupRecord.first;
                                  }

                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChatPageWidget(
                                              groupName: group.gName,
                                              groupRef: group.reference,
                                              groupPf: group.gPhotoUrl
                                          ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  AntDesign.message1,
                                  color: Color(0xFFF2F2F2),
                                  size: 22,
                                ),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              InkWell(
                                onTap: () async {
                                  await friendsRecord
                                      .reference
                                      .delete();
                                },
                                child: Icon(
                                  FluentIcons.person_subtract_16_regular,
                                  color: Color(0xFFF2F2F2),
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (friendsRecord.status == 0 &&
                          !isRequested)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,13,0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final friendshipData = {
                                    ...createFriendsRecordData(
                                      status: 1,
                                    )
                                  };

                                  await friendsRecord
                                      .reference
                                      .update(friendshipData);
                                },
                                child: Icon(
                                  Icons.check,
                                  color: Color(0xFFF2F2F2),
                                  size: 24,
                                ),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              InkWell(
                                onTap: () async {
                                  await friendsRecord
                                      .reference
                                      .delete();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Color(0xFFF2F2F2),
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (friendsRecord.status == 0 &&
                          isRequested)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,13,0),
                          child: InkWell(
                            onTap: () async {
                              await friendsRecord
                                  .reference
                                  .delete();
                            },
                            child: Icon(
                              FluentIcons.person_delete_20_regular,
                              color: Color(0xFFF2F2F2),
                              size: 25,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
