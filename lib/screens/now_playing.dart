import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * .75,
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(.1),
              ),
              child: TextFormField(
                style: TextStyle(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusColor: Colors.transparent,
                  hintText: 'Search Fm',
                  suffixIcon: Icon(Icons.search),
                  hintStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            PlayBar(),
            PlayCategory(),
            MessageBar()
          ],
        ),
      ),
    );
  }

  PlayCategory() {
    return Container(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Category',
            style: TextStyle(
                // color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
          Container(
            height: 120,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                PlayBox(),
                PlayBox(),
                PlayBox(),
                PlayBox(),
                PlayBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PlayBox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/audience.png'),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Entertainment',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '15 Staions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  PlayBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.grey,
            offset: Offset(
              3,
              3,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.play_circle_fill_outlined),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Now Playing',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              Text(
                'Blessings of Daniel',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45),
              )
            ],
          ),
          Image.asset('assets/waveform.png')
        ],
      ),
    );
  }

  MessageBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Messages',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            Text(
              'All',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                color: Colors.grey,
                offset: Offset(
                  3,
                  3,
                ),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(8),
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.play_circle_fill_outlined),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Zion FM',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  Text(
                    'Your choice\n radio',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
