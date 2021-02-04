import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner : false,
    home: Pomodoro(),
  ));
}

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro>{
  static int TimerInMinut = 25;
  int TimeInSec = TimerInMinut * 60;
  double percent = 0;
  Timer timer;
  bool _hasBeenPressed = false;
  _startTimer(){
    TimerInMinut = 25;
    int Time = TimerInMinut * 60;
    double SecPercent = (Time/100);
    _hasBeenPressed = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) { 
      setState(() {
        if(Time > 0 && TimerInMinut >= 0){
          Time --;
          if(Time % 60 == 0){
            TimerInMinut --;
          }if(Time % (SecPercent.toInt()) == 0){
            if(percent < 1){
              percent += 0.01;
            }else{
              percent = 1.0;
            }
          }
        }else{
          percent = 0.0;
          TimerInMinut = 25;
          _hasBeenPressed = false;
          timer.cancel();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600],Colors.blueGrey[600]],
              begin: FractionalOffset(0.5, 1)
            )
          ),
          width: double.infinity,
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget> [
              Padding(
                padding:EdgeInsets.only(top: 25.0),
                child: Text(
                  "Manager Timer",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 50.0
                    ),
                ),
              ),
            Expanded(
              child: CircularPercentIndicator(
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                radius: 250.0,
                lineWidth: 25,
                progressColor: Colors.red,
                center: Text(
                  "$TimerInMinut",
                  style: TextStyle( 
                    color: Colors.white,
                    fontSize: 80.0
                  ),
                ),
              ),
              ),
              SizedBox(height: 30.0,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0, right: 20.0, left : 20.0,),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Study Timer",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                        ),
                                      ),
                                      SizedBox(height: 10.0,
                                      ),
                                      Text(
                                        "25",
                                        style: TextStyle(
                                          fontSize: 80.0,),
                                      ),
                                    ],
                                ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Pause Timer",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                        ),
                                      ),
                                      SizedBox(height: 10.0,
                                      ),
                                      Text(
                                        "5",
                                        style: TextStyle(
                                          fontSize: 80.0,),
                                      ),
                                    ],
                                ),
                                ),
                              ],
                            )
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 28.0),
                              child: RaisedButton(
                                onPressed: _startTimer,
                                color: _hasBeenPressed ? Colors.blue : Colors.brown,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)
                                  ),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text("Start Study ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                  ),
                                  ),
                              ), 
                              ),
                        ],
                      ),
                    ),
                ),
              )
            ],
          ),
        ),
      ), 
      );
  }

}
