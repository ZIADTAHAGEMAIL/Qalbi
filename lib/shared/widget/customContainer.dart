
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customText.dart';

class customContainer extends StatelessWidget {
  final Color containerColor;
  final Color textcolor;
  final double textsize;
  final FontWeight textweight;

  final double buttonradius;
  final double buttonwidth;
  final double buttonheight;
  final Function() ontap;
  final String title;
  const customContainer({
    super.key,
    required this.containerColor,
    required this.buttonradius,
    required this.buttonwidth,
    required this.buttonheight,
    required this.title,
    required this.textcolor,
    required this.textsize,
    required this.textweight,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: CupertinoButton(
        onPressed: ontap,
        child: Container(
          width: buttonwidth,
          height: buttonheight,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(buttonradius),
          ),
          child: Center(
            child: Customtext(
              text: title,
              textcolor: textcolor,
              textsize: textsize,
              textweight: textweight,
            ),
          ),
        ),
      ),
    );
  }
}
