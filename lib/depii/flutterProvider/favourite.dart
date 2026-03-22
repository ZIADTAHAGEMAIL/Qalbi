import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamicapp/depii/flutterProvider/sharedProvider.dart';
import 'package:islamicapp/depii/flutterProvider/state.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'catalog.dart';

class Favourite extends StatelessWidget {
  Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsetsGeometry.all(20),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'WishList',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => Cart()),
              );
            },
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: BlocBuilder<FlutterCubit,depiState>(
          builder: (context,satte){
            final cubit =context.read<FlutterCubit>();

            return ListView.builder(
        itemCount: cubit.favouriteItems.length,

        itemBuilder: (context, index) {
          final item = cubit.favouriteItems[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text(item.keys.toString()),
              subtitle: Text(item.values.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      cubit.removeFromFavourite(item);
                    },
                    child: Icon(Icons.delete),
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.addToCart(index);
                    },

                    child: Icon(Icons.add_shopping_cart_outlined),
                  ),
                ],
              ),
            ),
          );
        },
      );})
    );
  }
}
