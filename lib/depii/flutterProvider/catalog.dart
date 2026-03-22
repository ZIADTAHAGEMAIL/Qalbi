import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:islamicapp/depii/flutterProvider/sharedProvider.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'favourite.dart';



class catalog extends StatelessWidget {
  catalog({super.key});

  @override
  Widget build(BuildContext context) {
    // ربط الـ UI بالـ Provider
    var watchProvider = Provider.of<FlutterCubit>(context);

    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.all(20),
        leadingWidth: 100,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'Catalog',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => Favourite()));
            },
            child: const Icon(Icons.favorite),
          ),
          const Gap(10),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => Cart()));
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart),
                Positioned(
                  left: -5,
                  top: -9,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      watchProvider.cartItems.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: watchProvider.items.length,
        itemBuilder: (context, index) {
          final item = watchProvider.items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text(item.keys.first),
              subtitle: Text("${item.values.first.toStringAsFixed(2)} \$"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      watchProvider.addToFavourite(index);
                    },
                    child: Icon(
                      watchProvider.favouriteItems.contains(item)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      watchProvider.addToCart(index);
                    },
                    child: const Icon(Icons.add_shopping_cart_outlined),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

