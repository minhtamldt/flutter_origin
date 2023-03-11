import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DemoIsolateWidget extends StatefulWidget {
  const DemoIsolateWidget({Key? key}) : super(key: key);

  @override
  State<DemoIsolateWidget> createState() => _DemoIsolateWidgetState();
}

class _DemoIsolateWidgetState extends State<DemoIsolateWidget> {

  Future<int> loopCompute(int n) async {
    int result = await compute(loop, n);
    return result;
  }

  int loop(int n) {
    int result = 1;
    for (int i = 0; i <= n; i++) {
      print(i);
    }
    return result;
  }

  void spawnDemo() async {
    ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(backgroundTask, receivePort.sendPort);
    receivePort.listen((data) {
      print("Received data from isolate: $data");
    });
  }
  static void backgroundTask(SendPort sendPort) {
    // Thực hiện các tác vụ nặng ở đây
    int sum = 0;
    for (int i = 0; i < 1000000000; i++) {
      sum += i;
    }
    sendPort.send(sum);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo Isolate")),
      body: Container(
        child: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            CircularProgressIndicator(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // var t = loopCompute(1000000000);
                // spawnDemo();
                 loop(1000);
              },
              child: Text('Click me'),
            )
          ],
        ),
    ),
    ),
    );
  }
}
