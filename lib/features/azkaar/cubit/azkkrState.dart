
import 'package:islamicapp/features/azkaar/data/azkarModel.dart';

abstract class Azkkrstate {}

class AzkaarInitial extends Azkkrstate {

}

class AzkaarLoading extends Azkkrstate {}

class azkaarloaded extends Azkkrstate {
  final Azkarmodel currentAzkar;

  azkaarloaded({
    required this.currentAzkar,
  });
}

class AzkaarError extends Azkkrstate {
  final String message;
  AzkaarError(this.message);
}