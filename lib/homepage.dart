import 'dart:async';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = ConfettiController();
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startCounter() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counterTime > 0) {
        setState(() {
          counterTime--;
          indicPercentage = counterTime / 50;
        });
      };
      if(counterTime ==0){
        _controller.play();
      }else{
        _controller.stop();
      };
    });
  }

  double indicPercentage = 1.0;
  int counterTime = 50;
  @override
  Widget build(BuildContext context) {
    //  print('hi');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: const Text('Custom CountDown',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [
              Stack(
              //  alignment: Alignment.topCenter,
                children: [
                Center(
                  child: CircularPercentIndicator(
                    //animation: true,
                    animateFromLastPercent: true,
                    radius: 80.0,
                    lineWidth: 8.0,
                    percent: indicPercentage,
                    center: Center(
                      child: counterTime == 0
                          ? Center(
                              child: ConfettiWidget(
                                confettiController: _controller,
                                blastDirection: pi/2,
                                emissionFrequency: 0.08 ,
                                gravity: 0.01,
                              ),
                            )
                          : Text(counterTime.toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    progressColor: Colors.green,
                  ),
                ),
                //Container(height: 150, width:150, color:Colors.red),
              ]),
              const SizedBox(height: 3),
              Text(counterTime==0? 'You reached a new milestone:)':'Your countdown is on :-)',
                  style: TextStyle(color:counterTime ==0? Colors.deepPurple : Colors.grey[800], fontSize: 25)),
            ],
          ),

          //const Center(child:const Text('BOnjour le monde'),),
          GestureDetector(
            onTap: startCounter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 50,
                width: 150,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'Start',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
