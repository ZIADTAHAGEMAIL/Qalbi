import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class Empliciteanimation extends StatefulWidget {
  const Empliciteanimation({super.key});

  @override
  State<Empliciteanimation> createState() => _EmpliciteanimationState();
}

class _EmpliciteanimationState extends State<Empliciteanimation> {
  double side = 250;
  Color color = Colors.grey;
  CrossFadeState state = CrossFadeState.showFirst;
  CrossFadeState state2 = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated Profile Card'), centerTitle: true),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              alignment: Alignment.center,
              duration: Duration(milliseconds: 400),
              height: side * 1.5,
              width: side,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                spacing: 15,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedCrossFade(
                    firstCurve: Curves.linear,
                    secondCurve: Curves.linear,
                    firstChild: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.redAccent,
                      child: Icon(Icons.star, size: 70, color: Colors.white),
                    ),
                    secondChild: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.military_tech,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    crossFadeState: state,
                    duration: Duration(seconds: 1),
                  ),
                  Column(
                    children: [
                      Text(
                        'Cap Ziad Taha',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Special Operations',
                        style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    firstChild: Gap(50),
                    secondChild: Column(
                      spacing: 15,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(color: Colors.white54, thickness: 1),
                        ),
                        Text(
                          'Flutter Dev - UI/UX Designer',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shield, color: Colors.amber, size: 30),
                            SizedBox(width: 15),
                            Icon(
                              Icons.gps_fixed,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Icon(Icons.security, color: Colors.blue, size: 30),
                          ],
                        ),
                      ],
                    ),
                    crossFadeState: state2,
                    duration: Duration(seconds: 1),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _elevatedButton(
                  icon: Icons.check_box_outline_blank,
                  text: Text('Resize & Color'),
                  ontap: () {
                    side = side == 250 ? 350 : 250;
                    color = color == Colors.grey ? Colors.teal : Colors.grey;
                    setState(() {});
                  },
                ),
                SizedBox(width: 10),
                _elevatedButton(
                  icon: Icons.person,
                  text: Text('Toggle Avatar'),
                  ontap: () {
                    setState(() {
                      state = state == CrossFadeState.showFirst
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst;
                    });
                  },
                ),
              ],
            ),
            _elevatedButton(
              icon: Icons.details,
              text: Text('Show / Hide Details'),
              ontap: () {
                setState(() {
                  state2 = state2 == CrossFadeState.showFirst
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _elevatedButton({
  required IconData icon,
  required Text text,
  required void Function() ontap,
}) {
  return ElevatedButton(
    onPressed: ontap,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon), SizedBox(width: 5), text],
    ),
  );
}
