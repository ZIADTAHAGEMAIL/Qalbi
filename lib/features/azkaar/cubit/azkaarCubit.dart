import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamicapp/core/constant/cash.dart';
import 'package:islamicapp/features/Hadith/data/hadithModel.dart';
import 'package:islamicapp/features/azkaar/cubit/azkkrState.dart';

import '../data/azkarModel.dart';

class azkaarCubit extends Cubit<Azkkrstate> {
  bool selectedFromMenu=false;
  Future<void> selectFromMenuDone(String val) async {
    
    
    try{
      selectedFromMenu=true;
      await getazkarByCateogory(val);
      print('\n\n\n');
      print(selectedFromMenu);
      print(azkaarUnderCategory?.category);
      print('\n\n\n');
    }
    catch(e){
      print(e.toString());
    }


  }
  static List<Azkarmodel> _cachedAzkar = [];
  azkaarCubit()
    : super(AzkaarInitial()){
    init();

  }

  Azkarmodel? azkaarUnderCategory;

  List<Azkarmodel> allAzkar = [];
  int selected = 1;
  Future<void>init()async{
if(_cachedAzkar.isEmpty){
  print('\n\cash Empty\n\n');

  emit(AzkaarLoading());
  await loadJsonAsset();
  getazkarByCateogory("أذكار الصباح والمساء");
}

else {
  print('\n\cash not Empty\n\n');

  allAzkar = _cachedAzkar;
  getazkarByCateogory("أذكار الصباح والمساء");

}
  }
  Future<void> loadJsonAsset() async {

    if (allAzkar.isNotEmpty) return;
    final String jsonString = await rootBundle.loadString(
      'assets/azkarJson/adhkar.json',
    );
    final data = jsonDecode(jsonString);
    List<Azkarmodel> azkaar = data
        .map((e) => Azkarmodel.fromjson(e))
        .toList()
        .cast<Azkarmodel>();
    ;
    allAzkar = azkaar;
    _cachedAzkar=allAzkar;

  }

  Future<void> getazkarByCateogory(Category) async {

    Azkarmodel zikr = allAzkar.firstWhere((e) {
      return e.category == Category;
    });
    azkaarUnderCategory = zikr;
    if(azkaarUnderCategory!=null)
    emit(azkaarloaded(  currentAzkar: azkaarUnderCategory!));
  }


  List<HadithModel>favouritesHadiths=[];
  void addTofavourite(value){
    favouritesHadiths.add(value);
  }
  void saveFavouritesIncash(){
    cash.insertIntoCash(key: 'hadithFavourites', value: favouritesHadiths.toString());
  }

}
