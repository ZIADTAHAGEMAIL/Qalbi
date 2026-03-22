
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamicapp/depii/flutterProvider/state.dart';

class FlutterCubit extends Cubit<depiState> {
  List<Map<String, double>> items = [
    {'Headphone': 120},
    {'SmartWatch': 90},
    {'PrtableCharger': 50},
    {'Speaker': 70},
    {'FitnessTracker': 170},
    {'Phone': 390},
  ];



  double totalPrice = 0;
  List<Map<String, double>> cartItems = [];
  List<Map<String, double>> favouriteItems = [];

  FlutterCubit():super(initial());



  void addToCart(int index) {
    cartItems.add(items[index]);
    totalPrice += items[index].values.first;
    emit(AddCart(totalPrice: totalPrice, cartItems: cartItems));
  }

  void addToFavourite(int index) {
    favouriteItems.add(items[index]);

    emit(AddFavourites(favouriteItems: favouriteItems));
  }

  void removeFromCart(Map<String, double> item) {
    cartItems.remove(item);
    totalPrice -= item.values.first;
    emit(RemoveFromCart());
  }

  void removeFromFavourite(Map<String, double> item) {
    favouriteItems.remove(item);
    emit(removeFromFavourites());
    ;
  }

  void checkOut() {
    cartItems.clear();
    totalPrice = 0;
    emit(CheckOut());
  }
}
