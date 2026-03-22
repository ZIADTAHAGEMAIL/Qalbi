import 'package:islamicapp/features/prayer/data/prayerTimesModel.dart';

abstract class PrayerState {}
class PrayerInitial extends PrayerState{}
class PrayerError extends PrayerState {
  final String error;
  PrayerError({required this.error});
}

class Prayerloaded extends PrayerState {
  final Prayertimesmodel prayerTimes;
  final DateTime timestamp;
  Prayerloaded({required this.prayerTimes, required this.timestamp});
}

class PrayerLoading extends PrayerState {}
class TimerEnd extends PrayerState {}
