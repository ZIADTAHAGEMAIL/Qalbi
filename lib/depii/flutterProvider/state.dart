  import 'package:flutter/cupertino.dart';

abstract class depiState {}

class initial extends depiState {
   // List<Map<String, double>> itemss;
   //  initial({required this.itemss});
}

class AddCart extends depiState {
  final double totalPrice;
  final List<Map<String, double>> cartItems;
  AddCart({required this.totalPrice, required this.cartItems});
}

class AddFavourites extends depiState {
  final List<Map<String, double>> favouriteItems;

  AddFavourites({required this.favouriteItems});
}

class RemoveFromCart extends depiState {}

class removeFromFavourites extends depiState {}

class CheckOut extends depiState {}
