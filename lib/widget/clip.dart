import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class customCircle extends StatefulWidget {
  const customCircle({super.key});

  @override
  State<customCircle> createState() => _customCircleState();
}

class _customCircleState extends State<customCircle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    runAnimation();
  }

  bool stopAnimation = false;
  runAnimation() {
    Future.delayed(Duration(seconds: 2), (() {
      setState(() {
        stopAnimation = true;
      });
    }));
  }

  double y = 250;
  double x = 250;
  double w = 40;
  @override
  Widget build(BuildContext context) {
    double height = 250;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 120),
      // alignment: Alignment.centerRight,
      // color: Colors.blueGrey,
      height: height,
      width: width,
      child: Stack(alignment: Alignment.bottomRight, children: [
        AnimatedOpacity(
          curve: Curves.fastOutSlowIn,
          opacity: stopAnimation ? 1 : 0.1,
          duration: Duration(seconds: 5),
          child: ClipPath(
              clipper: Clip(x: x, y: y, w: w),
              child: Container(
                color: Colors.grey,
                height: y,
                width: x,
              )),
        ),
        Positioned(
          left: 14,
          child: AnimatedOpacity(
            curve: Curves.fastOutSlowIn,
            opacity: stopAnimation ? 1 : 0.1,
            duration: Duration(seconds: 2),
            child: AnimatedContainer(
              duration: Duration(seconds: 3),
              margin: EdgeInsets.only(left: !stopAnimation ? 130 : 100),
              height: 180,
              alignment: Alignment.centerRight,
              // color: Colors.green,
              child: ClipPath(
                  clipper: Clip(x: 180, y: 180, w: 30),
                  child: Container(
                    color: Colors.white,
                    height: y,
                    width: x,
                  )),
            ),
          ),
        ),
      ]),
    );
  }
}

class Clip extends CustomClipper<Path> {
  double x;
  double y;
  double w;
  Clip({required this.x, required this.y, required this.w});

  @override
  Path getClip(Size size) {
    var path = Path();
    var rect = Rect.fromLTRB(0, 0, x, y);
    path.addOval(rect);
    path.fillType = PathFillType.evenOdd;
    var rect2 = Rect.fromLTRB(0 + w, 0 + w, x - w, y - w);
    path.addOval(rect2);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
