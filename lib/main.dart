// ignore_for_file: sort_child_properties_last,, dead_code, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Duration countdownDuration = Duration(minutes: 1);
  Duration duration = Duration();
  Timer? timer;
  bool isCountDown = true;

  @override
  void initState() {
    super.initState();

    startTimer();
    reset();
  }

  void reset(){
    if(isCountDown){
      setState(() {
        duration = countdownDuration;
      });
    }else{
      setState(() {
        duration = Duration();
      });
    }
  }

  void addTime(){
    final addSeconds = isCountDown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if(seconds < 0){
        timer?.cancel();
        print('timer cancled');
      }else{
        duration = Duration(seconds: seconds);
        print("duration -------- $duration");
      }
    });
  }

  void startTimer({bool resets = true}){

    if(resets){
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1),(_) {
       addTime();
       print('add timer callled');
    });
    print('start timer called');
  }

  void stopTimer({bool resets = true}){
    if(resets){
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 600,
          color: Colors.green,
          child: Row(
            children: [
              buildTime(),
              SizedBox(width: 10,),
              buildButtons(),
              //  IconButton(
              //     onPressed: (){
              //       if(isRunning){
              //         stopTimer(resets: false);
              //       }else{
              //         startTimer(resets: false);
              //       }
              //     },
              //     icon: Icon(isRunning ? Icons.pause : Icons.play_arrow_rounded),
              //     color: Colors.white,
              // ),
            ],
          ),
        )
      ),
    );
  }

  Widget buildButtons(){
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || isCompleted
    ? ElevatedButton(
      onPressed: (){
        if(isRunning){
          stopTimer(resets: false);
        }
      }, 
      child: Text('pause'),)
    :
    ElevatedButton(
      onPressed: (){
        startTimer(resets: false);
      }, 
      child: Text('play'),);
  }

  Widget buildTime(){

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      children: [
        buildTimeCard(time: minutes,header: 'Minutes'),
        Container(
          child: const Text(':',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
              ),),
          ),
        buildTimeCard(time: seconds, header: 'Seconds'),
      ],
    );
  }

  buildTimeCard({required String time, required String header}){
   return Text(
    time,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 30,
      ),
    ); 
  }
}





