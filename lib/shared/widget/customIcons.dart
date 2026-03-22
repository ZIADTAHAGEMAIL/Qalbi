import 'package:flutter/cupertino.dart';

class Customicon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  FontWeight? fontWeight;
  double? fill;
  double? weight;
  VoidCallback? ontap;
  Customicon({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
    this.fill,
    this.fontWeight,
    this.weight,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: SizedBox(
        child: Icon(
          icon,
          color: color,
          size: size,
          fontWeight: fontWeight,

          fill: fill,

          weight: weight,
        ),
      ),
    );
  }
}
