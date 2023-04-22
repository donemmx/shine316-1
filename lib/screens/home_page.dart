import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widget/json.dart';
import 'message.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.player}) : super(key: key);
  final AudioPlayer player;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.player.playing == false) {
      getRequest();
    }

    Timer.periodic(Duration(seconds: 5), (timer) {
      getPlayTitle();
    });
    audiobackground();
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('messgaes')
      .orderBy('timestamp', descending: true)
      .snapshots();
  void audiobackground() async {
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await widget.player.setAudioSource(AudioSource.uri(
        Uri.parse(decodedResponse['data']['streaming_links'][1]['url']),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: '1',
          // Metadata to display in the notification:
          album: "Playing",
          title: decodedResponse2['data']['title'],
          artUri: Uri.parse(
              'https://firebasestorage.googleapis.com/v0/b/notify-cc847.appspot.com/o/zion%20radio.jpeg?alt=media&token=62123633-b815-4e57-bb53-2a208fb06477'),
        ),
      ));
    } catch (e) {
      print("Error loading audio source*******************************: $e");
    }
  }

  get hc => FromDatabase().fire;

  StreamController _streamController = StreamController();
  StreamController _streamController2 = StreamController();

  List contentt = [
    {'image': 'assets/1.png', 'title': 'Drawing Near to God'},
    {
      'image': 'assets/2.png',
      'title': 'Thy Word is a Lamp unto my feet and light to my path'
    },
    {'image': 'assets/3.png', 'title': 'The act of worship'},
    {'image': 'assets/4.png', 'title': 'The believer and the cross'},
    {'image': 'assets/5.png', 'title': 'Draw nigh unto God'},
    {'image': 'assets/6.png', 'title': 'Authority of the Beliver'},
    {'image': 'assets/7.png', 'title': 'Peace with God'},
    {'image': 'assets/8.jpeg', 'title': 'Peace with God'},
    {'image': 'assets/9.jpeg', 'title': 'Peace with God'},
    {'image': 'assets/10.jpeg', 'title': 'Peace with God'},
  ];
  String title = '';
  String image = '';
  String nowPlaying = '';
  String radioLink = '';
  // late final titleResponse;
  var decodedResponse;
  var decodedResponse2;
  var decodedResponse3;
  String url = 'https://public.radio.co/api/v2/sced7c0e79';
  String url2 = 'https://public.radio.co/api/v2/sced7c0e79/track/current';
  Future getRequest() async {
    await FirebaseMessaging.instance.subscribeToTopic("tundegideon");
    final response = await http.get(Uri.parse(url));
    final response2 = await http.get(Uri.parse(url2));
    decodedResponse = (jsonDecode(response.body));
    decodedResponse2 = (jsonDecode(response2.body));
    print(decodedResponse);
    print(decodedResponse2);
    image = (decodedResponse2['data']['artwork_urls']['standard']);
    title = (decodedResponse2['data']['title']);
    radioLink = decodedResponse['data']['streaming_links'][1]['url'];
    // print(decodedResponse['data']['streaming_links'][0]['url']);
    playSong();
  }

  Future getPlayTitle() async {
    final res = await http.get(Uri.parse(url2));
    decodedResponse3 = (jsonDecode(res.body));
    // print(decodedResponse3);
    _streamController.sink.add(decodedResponse3['data']['title']);
    _streamController2.sink
        .add(decodedResponse3['data']['artwork_urls']['standard']);
  }
// AudioSource.uri(
//   Uri.parse('https://example.com/song1.mp3'),
//   tag: MediaItem(
//     // Specify a unique ID for each media item:
//     id: '1',
//     // Metadata to display in the notification:
//     album: "Album name",
//     title: "Song name",
//     artUri: Uri.parse('https://example.com/albumart.jpg'),
//   ),
// ),
//   // Stream getRandomValues() async* {
  //   var random = Random(2);
  //   while (true) {
  //     print('titleResponse');
  //     await Future.delayed(Duration(seconds: 1));
  //     yield random.nextDouble();
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // player.dispose();
    _streamController.close();
  }

  void playSong() {
    try {
      widget.player.setAudioSource(AudioSource.uri(
          Uri.parse(decodedResponse['data']['streaming_links'][1]['url'])));
      print(radioLink);
      widget.player.play();
    } catch (e) {
      // print(e);
    }
  }

  void backgroundSong() {
    try {
      AudioSource.uri(
        Uri.parse(decodedResponse['data']['streaming_links'][1]['url']),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: '1',
          // Metadata to display in the notification:
          album: "Shine Radio",
          title: decodedResponse3['data']['title'],
          artUri: Uri.parse('https://example.com/albumart.jpg'),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: globalVariable.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Container(
            height: 30, width: 30, child: Image.asset('assets/logo.jpeg')),
        actions: [
          IconButton(
              onPressed: (() {
                // showMaterialModalBottomSheet(
                //   context: context,
                //   builder: (context) => Container(),
                // );
              }),
              icon: Icon(Icons.bookmark)),
          SizedBox(
            width: 18,
          )
        ],
        // leading:
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 22, left: 22),
          child: Column(
            children: [
              // SizedBox(
              //   height: 30,
              //   child: StreamBuilder(
              //       stream: _streamController.stream,
              //       builder: ((context, snapshot) {
              //         // var decodedResponse3 = (jsonDecode(snapshot.data!.body));
              //         print(snapshot.data);
              //         return Text(
              //           snapshot.data.toString(),
              //           style: TextStyle(color: Colors.white),
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 3,
              //         );
              //       })),
              // ),
              Container(
                margin: EdgeInsets.only(top: 40),
                height: MediaQuery.of(context).size.height * .35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Now Playing',
                      // style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .3,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(stops: [.4,.7],
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.black, Colors.white],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(fit: StackFit.expand, children: [
                        StreamBuilder(
                            stream: _streamController2.stream,
                            builder: ((context, snapshot) {
                              // var decodedResponse3 = (jsonDecode(snapshot.data!.body));
                              print(snapshot.data);
                              if (snapshot.hasData) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data,
                                      fit: BoxFit.cover,
                                    ));
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                );
                              }
                            })),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              stops: [.05, .9],
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.black, Colors.black26],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Positioned(
                            top: 15,
                            left: 15,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .6,
                              padding: EdgeInsets.only(right: 20),
                              child: StreamBuilder(
                                  stream: _streamController.stream,
                                  builder: ((context, snapshot) {
                                    // var decodedResponse3 = (jsonDecode(snapshot.data!.body));
                                    print(snapshot.data);
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.toString(),
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      );
                                    } else {
                                      return Text('');
                                    }
                                  })),
                            )),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: StreamBuilder(
                              stream: widget.player.playerStateStream,
                              builder: (context, snapshot) {
                                final playerState = snapshot.data;
                                final processingState =
                                    playerState?.processingState;
                                final playing = playerState?.playing;
                                print(playing);
                                print(processingState);
                                if (processingState ==
                                    ProcessingState.loading) {
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: 30.0,
                                    height: 30.0,
                                    child: const CircularProgressIndicator(
                                        // color: Color.fromRGBO(108, 184, 186, 1),
                                        ),
                                  );
                                } else if (playing == true) {
                                  return InkWell(
                                      onTap: (() {
                                        if (widget.player.playerState.playing)
                                          widget.player.pause();
                                      }),
                                      child: const Icon(
                                        Icons.stop_circle_rounded,
                                        size: 38,
                                        color: Colors.blue,
                                      ));
                                } else if (playing == false) {
                                  return InkWell(
                                      onTap: (() {
                                        widget.player.play();
                                      }),
                                      child: const Icon(
                                        Icons.play_circle_fill,
                                        size: 38,
                                        color: Colors.blue,
                                      ));
                                }
                                return const SizedBox.shrink();
                              }),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Messages',
                    // style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'See All',
                    // style: TextStyle(color: Colors.white24),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _usersStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.data);
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: const Text("Loading"));
                      }

                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: hc.length,
                          itemBuilder: (context, index) {
                            return Messages(contentt, index);
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Messages(content, index) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => Message(index: index))));
      }),
      child: Container(
        height: 90,
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15),
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white10),
                borderRadius: BorderRadius.circular(18),
              ),
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  content[index]['image'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  child: Text(
                    hc[index]['title'],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  child: Text(
                    'Shine 3:16',
                    style: TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
