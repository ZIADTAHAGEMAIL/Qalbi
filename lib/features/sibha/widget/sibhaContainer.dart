import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:islamicapp/shared/widget/customText.dart';
import 'package:islamicapp/shared/widget/customIcons.dart';
import '../../../core/constant/appColors.dart';

class Sibhacontainer extends StatelessWidget {
  final String text;
  final IconData icon;

  const Sibhacontainer({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ScalifyBox(
      referenceWidth: 360,
      referenceHeight: 731,
      fit: ScalifyFit.contain,
      alignment: Alignment.center,
      builder: (context, ls) {
        return Container(
          width: ls.w(160),
          height: ls.h(55),
          decoration: BoxDecoration(
            color: Appcolors.SibhaviewTeal,
            borderRadius: ls.br(15),
            border: Border.all(
              width: ls.s(1.5),
              color: Appcolors.SibhaviewGold,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Customicon(
                icon: icon,
                color: Appcolors.SibhaviewGold,
                size: ls.iz(20),
              ),
              ls.sbw(8),
              Customtext(
                text: text,
                textcolor: Appcolors.SibhaviewGold,
                textsize: ls.fz(20),
                textweight: FontWeight.w800,
              ),
            ],
          ),
        );
      },
    );
  }
}
