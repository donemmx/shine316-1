import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shineradio/global.dart';
import 'package:http/http.dart' as http;
import 'package:shineradio/widget/json.dart';
import '../navigation_bar.dart';
import '../widget/clip.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        extendedPadding: EdgeInsets.symmetric(horizontal: 105),
        label: Text('Next'),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => Navigation())));
        },
      ),
      backgroundColor: globalVariable.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // decodedResponse

            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .38,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      'Shine 316 Radio',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      'Enjoy your \nfavorite \npodcast',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          height: 1.1),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      'conversations about life, tech, science \nand other interesting stuff',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   alignment: Alignment.centerRight,
            //   child: Stack(alignment: Alignment.bottomRight, children: [
            //     AnimatedContainer(
            //       duration: Duration(seconds: 5),
            //       alignment: Alignment.center,
            //       width: 250,
            //       height: 250,
            //       decoration: BoxDecoration(
            //           gradient: LinearGradient(colors: [
            //             Colors.grey,
            //             Colors.white.withOpacity(.09),
            //           ], stops: [
            //             .3,
            //             .7
            //           ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            //           borderRadius: BorderRadius.circular(150),
            //           color: Colors.grey),
            //       child: Container(
            //           width: 180,
            //           height: 180,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(100),
            //               color: globalVariable.backgroundColor),
            //           child: Text('')),
            //     ),
            //     Container(
            //       alignment: Alignment.center,
            //       width: 170,
            //       height: 170,
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(colors: [
            //           Colors.white,
            //           Colors.white.withOpacity(.1),
            //         ], stops: [
            //           .4,
            //           .8
            //         ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            //         borderRadius: BorderRadius.circular(100),
            //       ),
            //       child: Container(
            //           width: 110,
            //           height: 110,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(100),
            //               color: globalVariable.backgroundColor),
            //           child: Text('')),
            //     ),
            //   ]),
            // )
            customCircle()
          ],
        ),
      )),
    );
  }
}
