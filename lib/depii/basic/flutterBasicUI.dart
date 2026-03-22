import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Flutterbasicui extends StatelessWidget {
  const Flutterbasicui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('First App',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Keep Coding...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(height: 120, width: 120, color: Colors.green),
                Container(height: 100, width: 100, color: Colors.orange),
                Container(
                  height: 80,
                  width: 80,
                  color: Colors.yellow,
                  child: Center(child: Text('H')),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  color: Colors.yellow,
                  child: Center(child: Text('H')),
                ),
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.green,
                  child: Center(child: Text('H')),
                ),
                Container(
                  height: 90,
                  width: 90,
                  color: Colors.orange,
                  child: Center(child: Text('H')),
                ),
              ],
            ),

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(height: 120, width: 120, color: Colors.green),
                Container(height: 100, width: 100, color: Colors.orange),
                Container(
                  height: 80,
                  width: 80,
                  color: Colors.yellow,
                  child: Center(child: Text('H')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
