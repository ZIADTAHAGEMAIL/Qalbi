import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class tween extends StatefulWidget {
  const tween({super.key});

  @override
  State<tween> createState() => _tweenState();
}

class _tweenState extends State<tween> with TickerProviderStateMixin {
  double side = 150;
  CrossFadeState _state = CrossFadeState.showFirst;

  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
    // TODO: implement initState
    super.initState();
  }

  bool revers = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,

            children: [
              Image.asset(
                fit: BoxFit.cover,
                'assets/animation/space.jpg',
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                height: 100,
                width: 100,
                child: Icon(Icons.sunny),
              ),

              Transform.translate(
                offset: Offset(
                  100 *
                      cos(
                        revers
                            ? -_animationController.value * 2 * pi
                            : _animationController.value * 2 * pi,
                      ),
                  100 *
                      sin(
                        revers
                            ? -_animationController.value * 2 * pi
                            : _animationController.value * 2 * pi,
                      ),
                ),
                child: AnimatedContainer(
                  height: side,
                  width: side,
                  duration: Duration(seconds: 3),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(360),
                    child: Image.asset('assets/animation/ground.jpg'),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                  100 *
                      cos(
                        revers
                            ? -(_animationController.value * 2 * pi) + pi
                            : (_animationController.value * 2 * pi) + pi,
                      ),
                  100 *
                      sin(
                        revers
                            ? -(_animationController.value * 2 * pi) + pi
                            : (_animationController.value * 2 * pi) + pi,
                      ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  height: 50,
                  width: 50,
                ),
              ),

              Positioned(
                bottom: 120,
                child: AnimatedCrossFade(
                  firstChild: Column(
                    children: [
                      Text(
                        'Planet A Blue World ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'Planet B Green World ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  secondChild: SizedBox(),
                  crossFadeState: _state,
                  duration: Duration(seconds: 1),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              revers = !revers;
              // if(revers){
              // _animationController.repeat();
              // }
              // else {
              //
              //   _animationController.reverse();
              // }
            },
            child: Icon(Icons.repeat),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_animationController.isAnimating) {
                  _animationController.stop();
                } else {
                  _animationController.repeat();
                }
              });
            },
            child: Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: () {
              _state = _state == CrossFadeState.showFirst
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst;
              setState(() {});
            },
            child: Icon(Icons.info),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                side = side == 150 ? 300 : 150;
              });
            },
            child: Icon(Icons.zoom_in),
          ),
        ],
      ),
    );
  }
}
