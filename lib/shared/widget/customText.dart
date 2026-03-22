import 'package:flutter/cupertino.dart';

class Customtext extends StatelessWidget {
  final String text;
  final Color textcolor;
  final double textsize;
  final FontWeight textweight;
  double ?height;

  Customtext({
    super.key,
    required this.text,
    required this.textcolor,
    required this.textsize,
    required this.textweight,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      textDirection: TextDirection.rtl,
      style: TextStyle(
        color: textcolor,
        height: height,
        fontSize: textsize,
        fontWeight: textweight,
      ),
    );
  }
}
