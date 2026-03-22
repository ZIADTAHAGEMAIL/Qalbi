import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/responsive_scale/responsive_extensions.dart';
import 'package:flutter_scalify/responsive_scale/scalify_box.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import 'package:islamicapp/shared/widget/customText.dart';

class Azkaarcontainer extends StatelessWidget {
  String? zikr;
  Azkaarcontainer({super.key, this.zikr});

  @override
  Widget build(BuildContext context) {
    return ScalifyBox(
      referenceWidth: 360,
      referenceHeight: 820,
      builder: (context, ls) {
        BoxConstraints(minHeight: ls.h(200));
        return Container(
          padding: [20, 10].p,

          width: double.infinity,

          decoration: BoxDecoration(
            color: Appcolors.azkaarWhite,
            borderRadius: ls.br(14),
          ),
          child: Customtext(
            text: zikr ?? "الله",
            textcolor: Appcolors.azkaarViewTeal,
            textsize: ls.fz(30),
            textweight: FontWeight.bold,
          ),
          // child: Column(
          //   children: [
          //     // Row(
          //     //   children: [
          //     //     CircleAvatar(
          //     //       radius: ls.s(22),
          //     //       child: Icon(Icons.nightlight_round,size: ls.iz(25),),
          //     //
          //     //       backgroundColor: Color(0xffcbad6f),
          //     //     ),
          //     //     ls.sbh(25),
          //     //     Expanded(
          //     //       child: Customtext(
          //     //
          //     //         // text: 'Subhana allah',
          //     //         text: zikr??"الله",
          //     //         textcolor: Appcolors.azkaarViewTeal,
          //     //         textsize: ls.fz(30),
          //     //         textweight: FontWeight.bold,
          //     //       ),
          //     //     ),
          //     //   ],
          //     // ),
          //     Customtext(
          //       text: zikr ?? "الله",
          //       textcolor: Appcolors.azkaarViewTeal,
          //       textsize: ls.fz(30),
          //       textweight: FontWeight.bold,
          //     ),
          //     ls.sbh(25),
          //     // Row(
          //     //   children: [
          //     //     Stack(
          //     //       alignment: Alignment.center,
          //     //       children: [
          //     //         Container(
          //     //
          //     //           decoration: BoxDecoration(
          //     //               color: Appcolors.azkaarWhite,
          //     //               shape: BoxShape.circle
          //     //           ),
          //     //           width: ls.w(95),
          //     //           height: ls.h(95),
          //     //
          //     //           child:   CircularProgressIndicator(
          //     //             value: 0.33,
          //     //             strokeWidth: 8,
          //     //             backgroundColor: Color(0xffddd2b6),
          //     //             valueColor: AlwaysStoppedAnimation<Color>(
          //     //               Appcolors.azkaarViewTeal,
          //     //             ),
          //     //           ),
          //     //         ),
          //     //
          //     //         Container(
          //     //           decoration: BoxDecoration(
          //     //             color: Appcolors.azkaarViewTeal,
          //     //             shape: BoxShape.circle,
          //     //           ),
          //     //           width: ls.w(80),
          //     //           height: ls.h(80),
          //     //
          //     //         ),
          //     //         Customtext(text: '33',
          //     //             textcolor: Appcolors.azkaarWhite,
          //     //             textsize: ls.fz(24), textweight: FontWeight.bold),
          //     //
          //     //
          //     //       ],
          //     //     ),
          //     //     Spacer(),
          //     //
          //     //     Column(
          //     //       children: [
          //     //         Customtext(
          //     //           text: 'سبحان الله',
          //     //           textcolor: Appcolors.azkaarViewTeal,
          //     //           textsize: ls.fz(26),
          //     //           textweight: FontWeight.bold,
          //     //         ),
          //     //
          //     //         Customtext(
          //     //           text: 'sobhana allah ',
          //     //           textcolor: Appcolors.azkaarViewTeal,
          //     //           textsize: ls.fz(20),
          //     //           textweight: FontWeight.w800,
          //     //         ),
          //     //
          //     //         // LinearProgressIndicator(color: Colors.teal,value: 2,),
          //     //       ],
          //     //     ),
          //     //   ],
          //     // ),
          //   ],
          // ),
        );
      },
    );
  }
}
