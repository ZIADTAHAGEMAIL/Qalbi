import 'package:flutter/material.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import '../../../shared/widget/customText.dart';

class ZakatInputCard extends StatelessWidget {
  final dynamic ls;
  final String title;
  final TextEditingController controller;
  final IconData icon;
  final String suffix;
  final bool isPrimary;

  const ZakatInputCard({
    super.key,
    required this.ls,
    required this.title,
    required this.controller,
    required this.icon,
    required this.suffix,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ls.p(15),
      decoration: BoxDecoration(
        color: isPrimary ? Colors.amber[50] : Colors.white,
        borderRadius: ls.br(15),
        border: isPrimary
            ? Border.all(color: Colors.amber.withOpacity(0.5))
            : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.amber[800] : Appcolors.prayerTimesTeal,
              ),
              ls.sbw(10),
              Customtext(
                text: title,
                textcolor: isPrimary ? Colors.amber[900]! : Appcolors.prayerTimesTeal,
                textsize: ls.fz(14),
                textweight: FontWeight.bold,
              ),
            ],
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: ls.fz(20), fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: "0.00",
              border: InputBorder.none,
              suffixText: suffix,
              suffixStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}