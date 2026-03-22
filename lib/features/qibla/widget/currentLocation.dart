// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// /// When the location services are not enabled or permissions
// /// are denied the `Future` will return an error.
// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.',
//     );
//   }
//
//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition();
// }
//
// class Currentlocation extends StatefulWidget {
//   const Currentlocation({super.key});
//
//   @override
//   State<Currentlocation> createState() => _CurrentlocationState();
// }
//
// class _CurrentlocationState extends State<Currentlocation> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       width: double.infinity,
//       color: Colors.teal[50],
//       child: FutureBuilder<Position>(
//         future: determinePosition(), // بننادي الدالة هنا
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('خطأ: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return Center(
//               child: Text(
//                 'خط العرض: ${snapshot.data!.latitude}\nخط الطول: ${snapshot.data!.longitude}',
//                 textAlign: TextAlign.center,
//               ),
//             );
//           }
//           return const Center(child: Text('لا توجد بيانات'));
//         },
//       ),
//     );
//   }
// }
