import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shineradio/global.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shineradio/widget/json.dart';
import 'package:flutter_html/flutter_html.dart';

class Message extends StatefulWidget {
  final int index;
  const Message({required this.index, Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  get hc => FromDatabase().fire[widget.index];
  late WebViewController controller;

  final html = '''<!DOCTYPE html>
  <html>
<body>
<h1>THIS IS THE DAY OF THE LORD</h1>

        
</body>

</html>
''';
  void loadHtml() async {
    final url = Uri.dataFromString(hc['message'],
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
    controller.loadUrl(url);
  }

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
  @override
  Widget build(BuildContext context) {
    print('hc');
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 14,
              color: Colors.white,
            ),
            //replace with our own icon data.
          ),
          backgroundColor: Colors.transparent,
        ),
        // backgroundColor: globalVariable.backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(contentt[widget.index]['image']),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * .33,
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: const LinearGradient(
                      stops: [.6, .9],
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black54, Colors.black26],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0, left: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hc['title'],
                              // 'Making Decisions for',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              hc['subtitle'],
                              // 'Living Healthy',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .7,
                        // child: Text(
                        //   'conversations about life, tech, science, and other interesting stuff',
                        //   style: TextStyle(color: Colors.white60, fontSize: 11),
                        // ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'by  ',
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: hc['author'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600))
                            ])),
                            Text(hc['timestamp']['__time__'].split('T')[0],
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -4,
                  left: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(8))),
                    margin: EdgeInsets.only(left: 8),
                    width: MediaQuery.of(context).size.width - 25,
                    height: 24,
                    child: ListView.builder(
                      itemCount: hc['scripture'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 6),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          alignment: Alignment.center,
                          height: 22,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            hc['scripture'][index],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'by  ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 93, 226, 160),
                        fontSize: 13,
                        fontWeight: FontWeight.w300)),
                TextSpan(
                    text: hc['author'],
                    style: TextStyle(
                        color: Color.fromARGB(255, 93, 226, 160),
                        fontSize: 14,
                        fontWeight: FontWeight.w600))
              ])),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
            //   child: RichText(
            //       text: TextSpan(children: [
            //     TextSpan(
            //         text:
            //             '100 technology facts, what more could your inner-geek need?! Technology, ever-changing and ever-growing, brings us the future we’ve always imagined. But how did it get to where we are now? And where will it go next? Did you know that you could earn money for finding bugs with Facebook? Do you know the actual meaning of “Android”? Or how much of the world’s currency is digital? Find the answers to these tech questions here! Before you begin, here’s a quick video with our 5 favorite facts from this list. 100 technology facts, what more could your inner-geek need?! Technology, ever-changing and ever-growing, brings us the future we’ve always imagined. But how did it get to where we are now? And where will it go next?',
            //         style: TextStyle(
            //             color: Colors.white54,
            //             fontSize: 11,
            //             fontWeight: FontWeight.w300)),
            //   ])),
            // ),
            // Expanded(
            //   child: WebView(
            //     javascriptMode: JavascriptMode.unrestricted,
            //     onWebViewCreated: (controller) {
            //       this.controller = controller;
            //       loadHtml();
            //     },
            //   ),
            // )

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    // onLinkTap: () {},
                    data: hc['message'],
                    tagsList: Html.tags,
                    style: {
                      "p": Style(
                          // fontSize: FontSize.em(6),
                          // backgroundColor: Colors.amber,
                          // color: Colors.white,
                          ),
                      // "br": Style(lineHeight: LineHeight.percent(1)),
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
