import 'package:islamicapp/features/Hadith/data/hadithModel.dart';

abstract class hadithState {}

class hadithInitial extends hadithState {}

class hadithLoading extends hadithState {}

class hadithloaded extends hadithState {
  final List<HadithModel> hadith;

  hadithloaded({required this.hadith});
}

class hadithError extends hadithState {
  final String message;
  hadithError(this.message);
}
class togleFavourite extends hadithState{}
class favouriteLoaded extends hadithState{
  List<HadithModel>favouritesHadiths;
  favouriteLoaded({required this.favouritesHadiths});

}
class favouriteError extends hadithState{
  final String error;
  favouriteError({required this.error});
}
