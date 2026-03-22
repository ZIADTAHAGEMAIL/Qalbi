import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class dragAplle extends StatefulWidget {
  dragAplle({super.key});

  @override
  State<dragAplle> createState() => _dragAplleState();
}

class _dragAplleState extends State<dragAplle> {
  bool accepte = false;
  bool _onMove = false;
  Widget _widget = Text(
    'Drop Here',
    style: TextStyle(color: Colors.white, fontSize: 22),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Drag The Apple To Box',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Draggable<Widget>(
                childWhenDragging: Column(
                  children: [Icon(Icons.apple, size: 50, color: Colors.grey)],
                ),
                feedback: Icon(Icons.apple, size: 50, color: Colors.red),
                data: Icon(Icons.apple, size: 50, color: Colors.red),
                child: Column(
                  children: [Icon(Icons.apple, size: 50, color: Colors.red)],
                ),
              ),
              Gap(50),
              DragTarget<Widget>(
                onMove: (details) {
                  _onMove = true;
                  setState(() {});
                },

                onLeave: (d) {
                  _onMove = false;
                  setState(() {});
                },

                onAccept: (data) {
                  accepte = true;
                  _widget = Icon(Icons.apple, size: 50, color: Colors.red);
                  setState(() {});
                },

                builder: (context, data, rejectedData) {
                  return GestureDetector(
                    onDoubleTap: () {
                      accepte = false;
                      _onMove = false;
                      _widget = Text(
                        'Drop Here',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      );
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: accepte || _onMove ? Colors.grey : Colors.green,
                        borderRadius: BorderRadiusGeometry.circular(15),
                      ),
                      height: 150,
                      width: 150,
                      child: Center(
                        child: data.isNotEmpty
                            ? Icon(Icons.apple, size: 50, color: Colors.red)
                            : _widget,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
