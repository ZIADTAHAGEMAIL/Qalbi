import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../data/hadithModel.dart';
import 'hadithState.dart';

class hadithCubit extends Cubit<hadithState> {
  hadithCubit() : super(hadithInitial()) {
    // init();
  }

  List<HadithModel> hadith = [];
  static List<HadithModel> finalHadith = [];
  Box favourites = Hive.box('favourites');
  Box hadithBox = Hive.box('hadiths');

  Future<void> init() async {
    getFavourites();

    print('Cubit side - ID: ${this.hashCode}');
    print('Init=====================================================');
    if (finalHadith.isEmpty) {
      await loadHadithFromJson();
    } else {
      this.hadith = List.from(finalHadith);
      print('Cach contain hadith');
      emit(hadithloaded(hadith: finalHadith));
      // Future.delayed(Duration.zero, () {
      //   print('Emitting now after frame delay...');
      //   emit(hadithloaded(hadith: List.from(finalHadith)));
      // });
    }
  }

  Future<void> loadHadithFromJson() async {
    try {
      emit(hadithLoading());

      if (hadithBox.isEmpty) {
        print('Hive lengh=================================${hadithBox.length}');
        final response = await rootBundle.loadString(
          'assets/hadithJson/hadith.json',
        );
        final data = jsonDecode(response)['hadiths']['data'];
        hadith = List<HadithModel>.from(
          data.map((e) => HadithModel.fromJson(e)),
        );
        finalHadith = hadith;



        final Map<String, dynamic> itemsToCache = {
          for (var item in hadith) item.hadithNumber: item.toJson(),
        };
        await hadithBox.putAll(itemsToCache);

        print('Data saved to Hive for the first time! ✅');

        print('Load hadith From json=================');

        emit(hadithloaded(hadith: hadith));
      } else {
        print('Load hadith From Hive=================');
        final data = hadithBox.values.toList();
        hadith = data
            .map(
              (element) =>
                  HadithModel.fromJson(Map<String, dynamic>.from(element)),
            )
            .toList();
        finalHadith = hadith;

        emit(hadithloaded(hadith: hadith));
      }

      print('Load Now');
    } catch (e, stacktrace) {
      print(" ERROR LOADING JSON: $e");
      print(" STACKTRACE: $stacktrace");
      emit(hadithError(e.toString()));
    }
  }

  List<HadithModel> favouriteshadith = [];

  void togleFavourites(HadithModel hadith) {
    String key = hadith.hadithNumber;

    if (favourites.containsKey(key)) {
      favourites.delete(key);
    } else {
      favourites.put(key, hadith.toJson());
    }
    getFavourites();

    if (state is favouriteLoaded) {
    } else {
      emit(hadithloaded(hadith: finalHadith));
    }
  }

  void getFavourites() {
    try {
      final rawData = favourites.values.toList();
      favouriteshadith = rawData
          .map((e) => HadithModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      emit(favouriteLoaded(favouritesHadiths: favouriteshadith));
    } catch (e) {
      emit(favouriteError(error: e.toString()));
    }
  }
}


