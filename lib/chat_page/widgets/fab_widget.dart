import 'package:flutter/material.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FancyFab({this.onPressed, this.tooltip, this.icon});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  AnimationController controller;
  Animation animation;
  Icon presenticon = Icon(
    Icons.add,
    size: 25,
    color: Colors.purpleAccent,
  );

  get onPressed => false;

  @override
  initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween(begin: 0.0, end: 0.75).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

Widget test(){
  return Container(width: 83,
    height: 56,
    child: Card(
      elevation: 8,
      shadowColor: Colors.black,
      color:  Color(0xFF4D5078),
      shape: CircleBorder(
        ),
      child:  InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.blue.withAlpha(30),
        highlightColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Center(
          child: Text(
            'Save',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15
            ),
          ),
        ),
      ),
    ),
    decoration: BoxDecoration(

        shape: BoxShape.rectangle,

        boxShadow: [
          BoxShadow(

            color: Color(0xFF373856).withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 23,
            offset: Offset(0, 7),
          )
        ]),

  );
}
  Widget onichan() {
    return AnimatedOpacity(
      opacity: isOpened ? 1.0 : 0.0,
      duration: Duration(milliseconds: 200),
      child: Container(

        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 7.0),
        alignment: Alignment.center,
        height: 138,
        width: 45,
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.6),

          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <IconButton>[

            IconButton(
                icon: const Icon(Icons.add_a_photo),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Colors.purpleAccent,
                onPressed: () {
                  setState(() {
                    //quesque sa fait
                  });
                }),
            IconButton(
                icon: const Icon(Icons.image),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Colors.purpleAccent,
                onPressed: () {
                  setState(() {
                    //quesque sa fait
                  });
                }),

          ],
        ),
      ),
    );
  }

  Widget bouton() {
    return Container(

        width: 45.0,
        height: 45.0,
        //margin: EdgeInsets.fromLTRB(7.0, 7.0, 0.0, 0.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.purple)),
        child: FloatingActionButton(
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          splashColor: Colors.transparent,
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              isOpened = !isOpened;
            });
            if (animation.status == AnimationStatus.completed) {
              controller.reverse();
              onichan();
              presenticon = Icon(
                Icons.add,
                size: 25,
                color: Colors.purpleAccent,
              );
            } else if (animation.status == AnimationStatus.dismissed) {
              controller.forward();
            }
          },
          child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: animation.value,
                  child: presenticon,
                );
              }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

       );
  }
}
