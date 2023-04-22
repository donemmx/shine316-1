import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shineradio/global.dart';
import 'package:http/http.dart' as http;

class RadioScreen extends StatefulWidget {
  const RadioScreen(AudioPlayer this.player, {super.key});
  final AudioPlayer player;

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      getPlayTitle();
    });
  }

  var decodedResponse4;

  StreamController _streamController = StreamController();

  String url2 = 'https://public.radio.co/api/v2/sced7c0e79/track/current';

  Future getPlayTitle() async {
    final res = await http.get(Uri.parse(url2));
    decodedResponse4 = (jsonDecode(res.body));
    // print(decodedResponse3);
    _streamController.sink.add(decodedResponse4['data']['title']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black87,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Radio Local'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                // gradient: LinearGradient(colors: [
                //   globalVariable.backgroundColor,
                //   globalVariable.backgroundColor.withOpacity(.99),
                //   Color.fromARGB(255, 53, 23, 104)
                // ], stops: [
                //   .4,
                //   .7,
                //   .9
                // ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                ),
            alignment: Alignment(0, .5),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .46,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Image.asset(
                'assets/radiolocal.png',
                scale: 1.3,
              ),
              StreamBuilder(
                  stream: widget.player.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState?.processingState;
                    final playing = playerState?.playing;
                    if (processingState == ProcessingState.loading) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        width: 30.0,
                        height: 30.0,
                        child: const CircularProgressIndicator(
                            // color: Color.fromRGBO(108, 184, 186, 1),
                            ),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 238, 71, 174),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: (() {
                              widget.player.playerState.playing
                                  ? widget.player.stop()
                                  : widget.player.play();
                            }),
                            child: Icon(
                              playing == false
                                  ? Icons.play_arrow
                                  : Icons.stop_circle_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          Text(
                            playing == true ? 'Playing...' : 'Play',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                    );
                  }),
            ]),
          ),
          Container(
            height: 55,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: _streamController.stream,
                          builder: ((context, snapshot) {
                            // var decodedResponse3 = (jsonDecode(snapshot.data!.body));
                            print(snapshot.data);
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data.toString(),
                                // style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              );
                            } else {
                              return Text('');
                            }
                          })),
                      Text(
                        '10am-12pm',
                        // style: TextStyle(color: Colors.white60, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recently Played',
                  style: TextStyle(fontSize: 17),
                ),
                playReel()
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Fancybutton(icon: Icons.music_note, label: 'Request Track'),
          //     Fancybutton(icon: Icons.message_outlined, label: 'Request Track'),
          //     // Fancybutton()
          //   ],
          // )
        ],
      ),
    );
  }

  Fancybutton({icon, label}) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 10),
      height: 65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 238, 71, 174),
            ),
            child: Icon(
              icon,
              size: 14,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.white60, fontSize: 12),
          )
        ],
      ),
    );
  }

  playReel() {
    return Container(
      height: 50,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [Play(), Play(), Play()],
      ),
    );
  }
}

class Play extends StatelessWidget {
  const Play({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/audience.png',
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Permission To Dan',
              style: TextStyle(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Cassete face',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 10),
            ),
          ],
        )
      ],
    );
  }
}
