import 'package:flutter/material.dart';
import 'package:flutter_scalify/responsive_scale/scalify_box.dart';
import 'package:islamicapp/shared/widget/customText.dart';

class Griditem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback ontap;
  final LocalScaler ls;
  const Griditem({
    super.key,
    required this.icon,
    required this.title,
    required this.ontap,
    required this.ls,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
      height: ls.h(120),
        width: ls.w(95),
        padding: ls.pv(15),
        decoration: BoxDecoration(
          color: Colors.teal[50],
          borderRadius: ls.br(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: ls.iz(30), color: const Color(0xFF1D8E74)),
            ls.sbh(10),
            Customtext(
              text: title,
              textcolor: Colors.black,
              textsize: ls.fz(14),
              textweight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
