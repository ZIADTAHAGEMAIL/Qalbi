// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_qiblah/flutter_qiblah.dart';
// import 'dart:async';
// import 'dart:math' show pi;
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:stream_transform/stream_transform.dart' show CombineLatest;
// import 'package:flutter_svg/flutter_svg.dart';
//
// class QiblahCompassWidget extends StatelessWidget {
//   final _compassSvg = SvgPicture.asset('assets/compass.svg');
//   final _needleSvg = SvgPicture.asset(
//     'assets/needle.svg',
//     fit: BoxFit.contain,
//     height: 300,
//     alignment: Alignment.center,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FlutterQiblah.qiblahStream,
//       builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final qiblahDirection = snapshot.data!;
//         double qiblaAngle = (qiblahDirection.qiblah -
//             qiblahDirection.direction) * (pi / 180);
//         return Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             _compassSvg,
//             Transform.rotate(
//               angle: ((qiblahDirection.direction) * (pi / 180) * -1),
//               alignment: Alignment.center,
//               child: _needleSvg,
//             ),
//             Transform.rotate(
//               angle: qiblaAngle,
//               child: Transform.translate(
//                 // هنا بنحدد بُعد الكلمة عن السنتر
//                 // 150- يعني هتطلع لفوق (شمال) بمقدار 150 بكسل
//                 offset: const Offset(0, -150),
//                 child: const Text(
//                   'K',
//                   style: TextStyle(color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 8,
//               child: Text("${qiblahDirection.offset.toStringAsFixed(3)}°"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
