// import 'dart:convert';
// import 'dart:ffi';
//
// import 'package:flutter/cupertino.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:islamicapp/features/prayer/bloc/prayerState.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../core/constant/cash.dart';
// import '../data/prayerTimesModel.dart';
// import '../data/prayerTimesRepo.dart';
//
// class PrayerBloc extends Cubit<PrayerState> {
//   PrayerBloc():super(PrayerInitial());
//
//   List<Prayertimesmodel> allDaysPrayer = [];
//   Prayertimesmodel? today;
//   String? nextPrayerName;
//   DateTime nextPrayerTime=DateTime.now();
//
//   final Prayertimesrepo _prayerTimesRepo = Prayertimesrepo();
//
//   Future<List<Prayertimesmodel>> getallprayerTimes(
//     latitude,
//     longitude,
//     method,
//   ) async {
//     emit(PrayerLoading());
//     final res = await _prayerTimesRepo.getprayerTimes(
//       latitude,
//       longitude,
//       method,
//     );
//
//     return res;
//   }
//
//   Future<Prayertimesmodel?> getTodayPrayer(
//     List<Prayertimesmodel>? alldaysPrayer,
//   ) async {
//     emit(PrayerLoading());
//     int dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
//     final todayPrayer = alldaysPrayer?[dayOfYear - 1];
//
//     if (todayPrayer == null) {
//       emit(PrayerError(error: 'Null data'));
//     } else {
//       emit(Prayerloaded(prayerTimes: todayPrayer));
//     }
//     return todayPrayer;
//   }
//
//   void startLogic() async {
//     final localRes = cash.getFromCash(key: 'prayerTimes');
//     if (localRes != null && localRes.isNotEmpty) {
//       try {
//         emit(PrayerLoading());
//         // List<dynamic> decodedList      list<map<String ,dynamic >> is Correct
//         List<dynamic> decodedList = jsonDecode(localRes);
//         allDaysPrayer = decodedList
//             .map((item) => Prayertimesmodel.fromJson(item))
//             .toList();
//         int dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
//         today = allDaysPrayer[dayOfYear - 1];
//         getNextPrayerTime();
//         emit(
//           today != null
//               ? Prayerloaded(prayerTimes: today!)
//               : PrayerError(error: 'today is null'),
//         );
//
//
//       } catch (e) {
//         emit(PrayerError(error: 'Error on cach'));
//       }
//     }
//
//     try {
//       LocationPermission permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }
//       if (permission == LocationPermission.always ||
//           permission == LocationPermission.whileInUse) {
//         Position position = await Geolocator.getCurrentPosition();
//         if (today == null) {
//           emit(PrayerLoading());
//         }
//         var data = await _prayerTimesRepo.getprayerTimes(
//           position.latitude,
//           position.longitude,
//           5,
//         );
//
//         if (data.isNotEmpty) {
//           int dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
//
//           allDaysPrayer = data;
//           today = allDaysPrayer[dayOfYear - 1];
//           emit(Prayerloaded(prayerTimes: today!));
//           final encodedData = jsonEncode(data.map((e) => e.toJson()).toList());
//           cash.insertIntoCash(key: 'prayerTimes', value: encodedData);
//         }
//       }
//       else {
//         if (today == null) {
//
//           emit(PrayerError(error: 'Location permission is denied'));
//         }
//       }
//     } catch (e) {
//       emit(PrayerError(error: e.toString()));
//     }
//
//   }
//
//
//
//
//
//   void getNextPrayerTime() {
//     if (today == null) nextPrayerTime= DateTime.now().add(const Duration(minutes: 10));
//
//     DateTime now = DateTime.now();
//
//     Map<String, String> prayerTimes = {
//       "الفجر": today!.fajr,
//       "الظهر": today!.dhohr,
//       "العصر": today!.asr,
//       "المغرب": today!.magrib,
//       "العشاء": today!.isha,
//     };
//
//     prayerTimes.forEach((key, value){
//       String cleanTime = key.replaceAll(RegExp(r'[^\d:]'), '');
//       List<String> parts = cleanTime.split(':');
//
//       DateTime prayerDateTime = DateTime(
//         now.year, now.month, now.day,
//         int.parse(parts[0]),
//         int.parse(parts[1]),
//       );
//
//       // إذا كانت الصلاة بعد الوقت الحالي، هي دي "الصلاة القادمة"
//       if (prayerDateTime.isAfter(now)) {
//
//         nextPrayerName=key;
//       nextPrayerTime= prayerDateTime;
//       if(today!=null)
//       emit(Prayerloaded(prayerTimes: today!));
//
//     }
//     });
//
//     // for (var time in prayerTimes.values) {
//     //   // تنظيف النص (لو فيه AM/PM أو مسافات) وتحويله لـ DateTime
//     //   String cleanTime = time.replaceAll(RegExp(r'[^\d:]'), '');
//     //   List<String> parts = cleanTime.split(':');
//     //
//     //   DateTime prayerDateTime = DateTime(
//     //     now.year, now.month, now.day,
//     //     int.parse(parts[0]),
//     //     int.parse(parts[1]),
//     //   );
//     //
//     //   // إذا كانت الصلاة بعد الوقت الحالي، هي دي "الصلاة القادمة"
//     //   if (prayerDateTime.isAfter(now)) {
//     //     nextPrayerName=prayerTimes.keys.toString());
//     //     nextPrayerTime= prayerDateTime;
//     //     if(today!=null)
//     //     emit(Prayerloaded(prayerTimes: today!));
//     //     break;
//     //   }
//     // }
//
//     // لو خلصنا كل الصلوات (بعد العشاء)، يبقى الصلاة الجاية هي فجر بكرة
//
//     // nextPrayerTime= DateTime(now.year, now.month, now.day + 1, 5, 0);
//     emit(state);
//   }
//
// void onEnd(){
//     emit(TimerEnd());
// }
//
//
//
//
// }

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../../core/constant/cash.dart';
import '../data/prayerTimesModel.dart';
import '../data/prayerTimesRepo.dart';
import 'prayerState.dart';

class PrayerBloc extends Cubit<PrayerState> {
  PrayerBloc() : super(PrayerInitial());

  List<Prayertimesmodel> allDaysPrayer = [];
  Prayertimesmodel? today;
  String? nextPrayerName;
  DateTime nextPrayerTime = DateTime.now();
  late String nextPrayerTimeString = nextPrayerTime.toString().substring(
    10,
    16,
  );

  final Prayertimesrepo _prayerTimesRepo = Prayertimesrepo();

  // 1. الدالة الأساسية لبدء التطبيق
  void startLogic() async {

// cash.delete('prayerTimes');


    final localRes = cash.getFromCash(key: 'prayerTimes');
    if (localRes != null && localRes.isNotEmpty ) {
      try {
        List<dynamic> decodedList = jsonDecode(localRes);
        allDaysPrayer = decodedList
            .map((item) => Prayertimesmodel.fromJson(item))
            .toList();

        _updateTodayData();
      } catch (e) {
        emit(PrayerError(error: e.toString()));
        print("Cach Error: $e");
      }
    }


    else {
      try {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          Position position = await Geolocator.getCurrentPosition();


          if (today == null) emit(PrayerLoading());

          var data = await _prayerTimesRepo.getprayerTimes(
            position.latitude,
            position.longitude,
            5,
            3
          );
          // print('===========================');
          // print('===========================');
          // print(position.latitude);
          // print(position.longitude);
          // print('===========================');
          // print('===========================');


          if (data.isNotEmpty ||data !=null) {
            allDaysPrayer = data;
            _updateTodayData();


            final encodedData = jsonEncode(data.map((e) => e.toJson()).toList());
            cash.insertIntoCash(key: 'prayerTimes', value: encodedData);
          }
        } else {
          if (today == null)
            emit(PrayerError(error: 'Location permission is denied'));
        }
      } catch (e) {
        emit(PrayerError(error: e.toString()));
      }
    }
  }

  void _updateTodayData() {
    int dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
    if (allDaysPrayer.isNotEmpty) {
      today = allDaysPrayer[dayOfYear - 1];
      getNextPrayerTime();
      emit(Prayerloaded(prayerTimes: today!, timestamp: DateTime.now()));
    }
  }

  void getNextPrayerTime() {
    if (today == null) return;

    DateTime now = DateTime.now();
    Map<String, String> prayerTimesMap = {
      "الفجر": today!.fajr,
      "الظهر": today!.dhohr,
      "العصر": today!.asr,
      "المغرب": today!.magrib,
      "العشاء": today!.isha,
    };

    bool foundNext = false;

    prayerTimesMap.forEach((name, time) {
      if (foundNext) return;

      String cleanTime = time.split(' ')[0].replaceAll(RegExp(r'[^\d:]'), '');
      List<String> parts = cleanTime.split(':');

      DateTime prayerDT = DateTime(
        now.year, now.month, now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (prayerDT.isAfter(now)) {
        nextPrayerName = name;
        nextPrayerTime = prayerDT;

        nextPrayerTimeString = DateFormat('HH:mm').format(nextPrayerTime);

        foundNext = true;
      }
    });

    if (!foundNext) {
      nextPrayerName = "الفجر";
      nextPrayerTime = DateTime(now.year, now.month, now.day + 1, 5, 0);

      nextPrayerTimeString = DateFormat('HH:mm').format(nextPrayerTime);
    }
  }

  void onEnd() {
    emit(TimerEnd());
  }
}
