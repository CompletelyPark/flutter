import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_application_1/widget/textwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  int totalpomodoros = 0; // 포모도로 횟수

  static int priminutes = 1500; // 기본 시간
  static int breakminutes = 300; // 휴식

  int totaltime = priminutes; // 전체 남은 시간

  bool isrun = false; // 시계가 작동하는지 여부

  bool _visibility = true;
  bool _visibility2 = false;
  bool _visibility3 = false;

  @override
  void initState() {
    super.initState();
    _loadtotal();
  }

  _loadtotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalpomodoros = (prefs.getInt('totalpomodoros') ?? 0);
    });
  }

  _incrementpomo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalpomodoros = (prefs.getInt('totalpomodoros') ?? 0) + 1;
      prefs.setInt('totalpomodoros', totalpomodoros);
    });
  }

  // 타이머 종료시 함수
  void onTick(Timer timer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (totaltime == 0) {
      setState(
        () {
          if (breakState == false) {
            totaltime = priminutes;
            _incrementpomo();
          } else {
            totaltime = breakminutes;
          }
          isrun = false;

          _visibility = true;
          _visibility2 = false;
          _visibility3 = false;
        },
      );
      timer.cancel();
    } else {
      setState(() {
        totaltime -= 1;
      });
    }
  }

  // 타이머 시작시 함수
  void onstart() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      _visibility = false;
      _visibility2 = false;
      _visibility3 = true;
      isrun = true;
    });
  }

  // 타이머 일시정지 함수
  void onpause() {
    timer.cancel();
    setState(() {
      isrun = false;
      _visibility2 = true;
      _visibility3 = true;
    });
  }

  // 타이머 리셋 함수
  void onreset() {
    timer.cancel();
    isrun = false;
    _visibility = true;
    _visibility2 = false;
    _visibility3 = false;

    // totaltime = priminutes;
    setState(() {});
  }

  // 시간 표시 00:00
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  // 시간 표시2 00 MIN
  String format1(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 4);
  }

  bool breakState = false; // 공부 휴식 상태
  void statefunc() {
    if (breakState == true) {
      totaltime = priminutes;
      breakState = false;
    } else {
      totaltime = breakminutes;
      breakState = true;
    }

    setState(() {});
  }

  // double radians = -35 * math.pi / 180; //45 = degree

  void minustime() {
    if (priminutes >= 0 && breakminutes >= 0) {
      if (totaltime == priminutes) {
        priminutes -= 60;
      } else {
        breakminutes -= 60;
      }
      totaltime -= 60;
    }
    setState(() {});
  }

  void plustime() {
    if (totaltime == priminutes) {
      priminutes += 60;
    } else {
      breakminutes += 60;
    }
    totaltime += 60;
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // actions: [
        //   IconButton(
        //     onPressed: showDialogPop,
        //     icon: Icon(Icons.settings),
        //   ),
        // ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 300,
                    onPressed: isrun ? onpause : onstart,
                    icon: Icon(
                      isrun
                          ? Icons.pause_circle_outline_rounded
                          : Icons.play_circle_outline_rounded,
                    ),
                  ),
                  Visibility(
                    visible: _visibility2,
                    child: Container(
                      child: IconButton(
                        iconSize: 50,
                        onPressed: onreset,
                        icon: Icon(
                          Icons.stop_circle_sharp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Visibility(
                            visible: _visibility,
                            child: TextButton(
                              onPressed: statefunc,
                              child: TextWidget(
                                  input_text: breakState
                                      ? 'BREAK ${format1(breakminutes)} MIN'
                                      : 'POMODORO ${format1(priminutes)} MIN',
                                  size: 20),
                            ),
                          ),
                          Visibility(
                            visible: _visibility,
                            child: IconButton(
                              onPressed: minustime,
                              icon: Icon(Icons.arrow_downward),
                            ),
                          ),
                          Visibility(
                            visible: _visibility,
                            child: IconButton(
                              onPressed: plustime,
                              icon: Icon(Icons.arrow_upward),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _visibility3,
                    child: TextWidget(input_text: format(totaltime), size: 20),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(input_text: '$totalpomodoros', size: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDialogPop() {
    showDialog(
      context: context,
      barrierDismissible:
          true, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            //내용 정의
            child: ListBody(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: minustime,
                      icon: Icon(Icons.arrow_downward),
                    ),
                    TextWidget(
                      input_text: format1(totaltime),
                      size: 30,
                    ),
                    IconButton(
                      onPressed: plustime,
                      icon: Icon(Icons.arrow_upward),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
