import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamicapp/features/sibha/bloc/sibhaState.dart';

import '../../../core/constant/cash.dart';

class SibhaCubit extends Cubit<SibhaState> {
  SibhaCubit() : super(SibhaInitail());

  String? item;
  int base = 100;
  int current = 0;
void resetTasabeeh(){

  for (var e in Tasaabeeh) {
    String key = e.keys.first;
    e[key] = false;
  }



  emit(newState());

  saveTasaabeehInCash();
}
  void increament() {
    current++;

    if (current == 10) {
      for (int i = 0; i < Tasaabeeh.length; i++) {
        String key = Tasaabeeh[i].keys.first;

        if (key.trim() == item?.trim()) {
          Tasaabeeh[i][key] = true;
          break;
        }
      }
      saveTasaabeehInCash();
      resetCounter();
    }
    emit(newState());
  }

  void resetCounter() {
    current = 0;
    emit(newState());
  }

  void selectZikr(String zikr) {
    item = zikr;
    current = 0;
    emit(newState());
  }

  // List<String> Tasaabeeh = [
  //   "سبحان الله وبحمده",
  //   "سبحان ربي العظيم ",
  //   "سبحان ربي الاعلي",
  //   "الحمد لله ",
  //   "لا اله الا الله وحده لا شريك له ",
  //   "الله اكبر",
  //   "لا حول ولا قوة الا بالله العلي العظيم ",
  //   "استغفر الله العلي العظيم واتوب اليه ",
  //   "اللهم صل وسلم وبارك علي نبينا محمد",
  // ];

  List<Map<String, bool>> Tasaabeeh = [
    {"سبحان الله وبحمده": false},
    {"سبحان ربي العظيم ": false},
    {"الحمد لله ": false},
    {"لا اله الا الله وحده لا شريك له ": false},
    {"الله اكبر": false},
    {"لا حول ولا قوة الا بالله العلي العظيم ": false},
    {"استغفر الله العلي العظيم واتوب اليه ": false},
    {"اللهم صل وسلم وبارك علي نبينا محمد": false},
  ];

  TextEditingController controller = TextEditingController();

  void addToTassabeeh() {
    Tasaabeeh.add({controller.text.trim(): false});
    controller.clear();
    saveTasaabeehInCash();
    emit(newState());
  }

  void removeFromTassabeeh(index) {
    Tasaabeeh.removeAt(index);
    saveTasaabeehInCash();
    emit(newState());
  }

  Future<void> saveTasaabeehInCash() async {
    String jsonString = jsonEncode(Tasaabeeh);
    await cash.insertIntoCash(key: 'Tasaabeeh', value: jsonString);
  }

  List<Map<String, bool>> getTasaabeehFromCash() {
    String? jsonString = cash.getFromCash(key: 'Tasaabeeh');

    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        List<dynamic> decoded = jsonDecode(jsonString);

        return decoded.map((item) {
          return Map<String, bool>.from(item as Map);
        }).toList();
      } catch (e) {
        print("Error decoding JSON: $e");
        return [];
      }
    }
    return [];
  }

  // Future<void> saveTasaabeehInCash() async {
  //   cash.initialpref();
  //   cash.saveListToCash(key: 'Tasaabeeh', value: Tasaabeeh);
  // }

  void initial() {
    final res = getTasaabeehFromCash();
    // نحدث القائمة فقط لو الكاش يحتوي على بيانات فعلاً
    if (res.isNotEmpty) {
      Tasaabeeh = res;
      emit(newState());
    } else {
      // لو الكاش فاضي، ممكن نحفظ الأذكار الافتراضية فيه لأول مرة
      saveTasaabeehInCash();
    }
  }

  // Future<List<String>?> getTasaabeehFromCash() async {
  //   cash.initialpref();
  //   return cash.getListFromCash(key: 'Tasaabeeh');
  // }
}
