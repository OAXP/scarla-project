import 'package:scarla/util/transparent_route.dart';
import 'package:selectable_circle/selectable_circle.dart';

import '../add_post_page/add_post_page_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../profile_page/profile_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>  with  TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> isSelected=new List.filled(6, false);
  AnimationController _animationController;
  Color color1=Color(0xff0b323e);
  Color color2= Color(0xff010b15);

  @override
  initState() {

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400),);
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      drawer:  SizedBox(
        width: MediaQuery.of(context).size.width * 0.20,
        child: Drawer(
          child: Container(
            color: Color(0xff292e5c),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                SelectableCircle(
                  color: Colors.white12,
                  selectedColor: Colors.red,
                  width: 80.0,
                  isSelected: isSelected[5],
                  borderColor: Colors.deepPurpleAccent,
                  selectedBorderColor: Colors.green,
                  selectMode: SelectMode.simple,
                  onTap: () {

                    setState(() {
                      if(!isSelected[5]) {
                        if(!isSelected.contains(true)) { }
                        isSelected.fillRange(0, isSelected.length, false);
                        isSelected[5] = true;
                        if (isSelected[5]) {



                        }
                      }else{

                        isSelected.fillRange(0, isSelected.length, false);


                      }
                    }
                    );
                  },
                  child:  Text('All'),
                ),

                SizedBox(height: 30),
                SelectableCircle(

                    width: 80.0,
                    isSelected: isSelected[0],
                    borderColor: Colors.deepPurpleAccent,
                    selectedBorderColor: Colors.green,
                    color: Color(0xffff4654),
                    selectedColor: Colors.green,

                    selectMode: SelectMode.simple,
                    onTap: () {

                      setState(() {
                        if(!isSelected[0]) {
                          if(!isSelected.contains(true)) { }
                          isSelected.fillRange(0, isSelected.length, false);
                          isSelected[0] = true;
                          if (isSelected[0]) {



                          }
                        }else{

                          isSelected.fillRange(0, isSelected.length, false);


                        }
                      }
                      );
                    },
                    child: CircleAvatar(backgroundImage:AssetImage('assets/images/valorantIcon.jpg'),maxRadius: 28.5)
                ),
                SizedBox(height: 30),
                SelectableCircle(
                    selectMode: SelectMode.simple,
                    selectedColor: Colors.grey[900],
                    width: 80.0,
                    color:Colors.grey[900],

                    isSelected: isSelected[1],
                    borderColor: Colors.red,
                    selectedBorderColor: Colors.green,
                    onTap: () {
                      setState(() {
                        if(!isSelected[1]) {
                          if(!isSelected.contains(true)) { }
                          isSelected.fillRange(0, isSelected.length, false);
                          isSelected[1] = true;
                          if (isSelected[1]) {

                          }
                        }else{



                          isSelected.fillRange(0, isSelected.length, false);



                        }
                      }
                      );
                    },
                    child: CircleAvatar(
                      maxRadius: 28.5,
                      backgroundColor: Colors.grey[900],
                      child:Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(image:ExactAssetImage('assets/images/MWIcon.png'),scale:2.5,),
                          shape: BoxShape.circle,


                        ),
                      ),
                      //backgroundImage:AssetImage('assets/images/mwIcon.png'),maxRadius: 26,backgroundColor: Colors.grey[900],foregroundColor: Colors.red,
                    )
                ),
                SizedBox(height: 30),
                SelectableCircle(
                    width: 80.0,
                    selectMode: SelectMode.simple,
                    color:  Color(0xff0a2f39),
                    isSelected: isSelected[2],
                    borderColor: Colors.red,
                    selectedBorderColor: Colors.green,
                    onTap: () {
                      setState(() {
                        if(!isSelected[2]) {
                          if(!isSelected.contains(true)) { }
                          isSelected.fillRange(0, isSelected.length, false);
                          isSelected[2] = true;
                          if (isSelected[2]) {


                          }
                        }else{



                          isSelected.fillRange(0, isSelected.length, false);


                        }
                      }
                      );
                    },
                    child: CircleAvatar(maxRadius: 28.5,
                      //backgroundImage:AssetImage('assets/images/lolIcon.png'),
                      child:Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(image:ExactAssetImage('assets/images/LOLIcon.png'),scale: 12),
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              color1,
                              color2,
                            ],begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),

                        ),
                      ),
                      //backgroundImage:AssetImage('assets/images/lolIcon.png'),maxRadius: 25,backgroundColor: Color(0xff0a2f39),
                    )
                ),
                SizedBox(height: 30),
                SelectableCircle(
                  color: Color(0xff004ca3),
                  width: 80.0,
                  isSelected: isSelected[3],
                  borderColor: Colors.deepPurpleAccent,
                  selectedBorderColor: Colors.green,
                  selectMode: SelectMode.simple,
                  onTap: () {

                    setState(() {
                      if(!isSelected[3]) {
                        if(!isSelected.contains(true)) { }
                        isSelected.fillRange(0, isSelected.length, false);
                        isSelected[3] = true;
                        if (isSelected[3]) {


                        }
                      }else{

                        isSelected.fillRange(0, isSelected.length, false);


                      }
                    }
                    );
                  },

                  child: CircleAvatar(maxRadius: 28.5,
                    backgroundColor: Color(0xff004ca3),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(2, 3, 0, 0),
                      width: 150,
                      height: 150,

                      decoration: BoxDecoration(

                        color: Color(0xff004ca3),
                        image: DecorationImage(image:ExactAssetImage('assets/images/rlIcon.png'),scale: 28,),
                        shape: BoxShape.circle,


                      ),
                    ),
                  ),/* CircleAvatar(backgroundImage:AssetImage('assets/images/rlIcon.png'),radius: 20,backgroundColor: Color(0xff004ca3),)*/
                ),
                SizedBox(height: 30),
                SelectableCircle(
                  color: Colors.grey[350],
                  width: 80.0,
                  isSelected: isSelected[4],
                  borderColor: Colors.red,
                  selectMode: SelectMode.simple,
                  selectedBorderColor: Colors.green,
                  onTap: () {
                    setState(() {
                      if (!isSelected[4]) {
                        if (!isSelected.contains(true)) {

                        }
                        isSelected.fillRange(
                            0, isSelected.length, false);
                        isSelected[4] = true;
                        if (isSelected[4]) {

                        }
                      }else{



                        isSelected.fillRange(0, isSelected.length, false);

                      }
                    }
                    );
                  },
                  child: CircleAvatar(radius: 28,


                    child: Container(

                      width: 150,
                      height: 150,

                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: DecorationImage(image:ExactAssetImage('assets/images/OwIcon.png'),scale: 26,),
                        shape: BoxShape.circle,


                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
      body:  Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.primaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                TransparentRoute(
                                  builder: (context) => AddPostPageWidget(
                                    userRef: currentUserReference,
                                    initValue: '',
                                    initImage: '',
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.tertiaryColor,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      'Make a post',
                                      style: FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder<List<FeedRecord>>(
                            stream: queryFeedRecord(
                              queryBuilder: (feedRecord) => feedRecord
                                  .orderBy('timestamp', descending: true),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }
                              List<FeedRecord> listViewFeedRecordList =
                                  snapshot.data;
                              // Customize what your widget looks like with no query results.
                              if (listViewFeedRecordList.isEmpty) {
                                return Center(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://i.pinimg.com/originals/65/ba/48/65ba488626025cff82f091336fbf94bb.gif',
                                    width: 200,
                                    height: 200,
                                  ),
                                );
                              }
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewFeedRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewFeedRecord =
                                      listViewFeedRecordList[listViewIndex];
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0,
                                        (listViewIndex == listViewFeedRecordList.length-1) ? 90 : 0),
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
                                              padding:
                                                  EdgeInsets.fromLTRB(10, 2, 10, 2),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00EEEEEE),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ProfilePageWidget(
                                                                  userRef:
                                                                      listViewFeedRecord
                                                                          .authorRef,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            width: 30,
                                                            height: 30,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape:
                                                                  BoxShape.circle,
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  listViewFeedRecord
                                                                      .authorPhotoUrl,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  5, 0, 0, 0),
                                                          child: Text(
                                                            listViewFeedRecord
                                                                .authorName,
                                                            style: FlutterFlowTheme
                                                                .bodyText1
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
                                                        print(
                                                            'IconButton pressed ...');
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
                                            Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(5, 0, 5, 0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 300,
                                                  maxHeight: 100,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0x00EEEEEE),
                                                ),
                                                child: Text(
                                                  listViewFeedRecord.content,
                                                  style: FlutterFlowTheme.bodyText2
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: (listViewFeedRecord.imageUrl.trim() == "") ? 0 : 200,
                                              decoration: BoxDecoration(
                                                color: Color(0x00EEEEEE),
                                              ),
                                              child: (listViewFeedRecord.imageUrl.trim() == "") ? Container()
                                                  : CachedNetworkImage(
                                                imageUrl:
                                                    listViewFeedRecord.imageUrl,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    1,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    await Navigator.push(
                                                      context,
                                                      TransparentRoute(
                                                        builder: (context) =>
                                                            AddPostPageWidget(
                                                          userRef:
                                                              currentUserReference,
                                                          initValue:
                                                              listViewFeedRecord
                                                                  .content,
                                                          initImage:
                                                              listViewFeedRecord
                                                                  .imageUrl,
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
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),

    );
  }
}
