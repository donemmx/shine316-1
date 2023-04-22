import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  var dateSelected = 0;
  var messageClickSelect = 0;
  void click(index) {
    dateSelected = index;
    setState(() {});
  }

  void MessageClick(index) {
    messageClickSelect = index;
    setState(() {});
  }

  final myBlack = Colors.black87;
  List messages = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List date = [
    {'day': 'MON', 'date': '23 Aug'},
    {'day': 'TUE', 'date': '24 Aug'},
    {'day': 'WED', 'date': '25 Aug'},
    {'day': 'THU', 'date': '26 Aug'},
    {'day': 'FRI', 'date': '27 Aug'},
    {'day': 'SAT', 'date': '28 Aug'},
    {'day': 'SUN', 'date': '29 Aug'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Schedule',
          style: TextStyle(
              // color: myBlack,
              ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Date(date[index]['day'], date[index]['date'], index);
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return MessageReel(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Date(week, date, index) {
    return GestureDetector(
      onTap: () {
        click(index);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == dateSelected ? myBlack : Colors.white),
        height: 60,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              week,
              style: TextStyle(
                color: index == dateSelected ? Colors.white : myBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                color: index == dateSelected ? Colors.white : myBlack,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  MessageReel(index) {
    return GestureDetector(
      onTap: () {
        MessageClick(index);
      },
      child: Stack(alignment: Alignment.topRight, children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 80,
          width: double.infinity,
          child: Row(
            children: [
              Image.asset('assets/face.png'),
              SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '6am-7am',
                    style: TextStyle(
                      // color: myBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Early Morning with Dave',
                    style: TextStyle(
                      // color: myBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Dave Breakfast',
                    style: TextStyle(
                      // color: myBlack,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        messageClickSelect == index
            ? Positioned(
                top: 22,
                child: Container(
                  // padding: EdgeInsets.all(3),
                  alignment: Alignment.center,
                  width: 60,
                  height: 18,
                  color: Color.fromARGB(255, 233, 30, 182),
                  child: Text(
                    'On Air',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            : SizedBox.shrink()
      ]),
    );
  }
}
