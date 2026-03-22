import 'package:flutter_bloc/flutter_bloc.dart';

class counterbloc extends Cubit<int>{
  counterbloc():super(0);
  void plus(){
    emit(state+1);
  }


  void minus(){
    emit(state-1);
  }


  void reset(){
    emit(0);
  }
}

