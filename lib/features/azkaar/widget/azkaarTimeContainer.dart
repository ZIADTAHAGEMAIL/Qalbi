// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_scalify/flutter_scalify.dart';
// import 'package:flutter_scalify/responsive_scale/responsive_extensions.dart';
// import 'package:islamicapp/shared/widget/customText.dart';
//
// import '../../../core/constant/appColors.dart';
//
// class Azkaartimecontainer extends StatelessWidget {
//   final bool isSelected;
//   final String text;
//   final VoidCallback  ontap;
//   const Azkaartimecontainer({super.key, required this.isSelected,
//     required this.text, required this.ontap});
//
//   @override
//   Widget build(BuildContext context) {
//     return   GestureDetector(
//       onTap: ontap,
//       child: ScalifyBox(
//         referenceWidth: 360,
//         referenceHeight: 820,
//        builder: (context,ls){
//          return Container(
//            height: ls.h(33).clamp(28, 90),
//            width: ls.w(98).clamp(90, 250),
//            decoration: BoxDecoration(
//              color: isSelected?   Appcolors.azkaarViewTeal  :Appcolors.azkaarViewGold,
//              borderRadius: 14.br,
//            ),
//
//            child: Center(
//              child: Customtext
//                (text: text,
//                  textcolor: isSelected?Colors.white:Appcolors.azkaarViewTeal ,
//                  textsize:  isSelected?ls.fz(15):ls.fz(13),
//                  textweight: isSelected?FontWeight.bold:FontWeight.w700
//
//              )
//              ,
//            ),
//          );
//
//        },
//
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_scalify/responsive_scale/responsive_extensions.dart';

import '../../../core/constant/appColors.dart';
import '../../../shared/widget/customText.dart';

class Azkaartimecontainer extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback ontap;

  const Azkaartimecontainer({super.key,
    required this.isSelected, required this.text,
    required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 33.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: isSelected ? Appcolors.azkaarViewTeal : Appcolors.azkaarViewGold,
          borderRadius: 14.br,
        ),
        child: Center(
          child: Customtext(
            text: text,
            textcolor: isSelected ? Colors.white : Appcolors.azkaarViewTeal,
            textsize: isSelected ? 14.fz : 12.fz,
            textweight: isSelected ? FontWeight.bold : FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
