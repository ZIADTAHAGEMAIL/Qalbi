import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:islamicapp/depii/flutterProvider/sharedProvider.dart';
import 'package:islamicapp/depii/flutterProvider/state.dart';
import 'package:provider/provider.dart';


class Cart extends StatelessWidget {
  Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsetsGeometry.all(20),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'Cart',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FlutterCubit,depiState>(builder: (context,state){
              final cubit =context.read<FlutterCubit>();
              return ListView.builder(
                itemCount: cubit.cartItems.length,

                itemBuilder: (context, index) {
                  final item = cubit.cartItems[index];
                  return Card(
                    child: ListTile(
                      leading: Text(
                        item.keys.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      trailing: Consumer<FlutterCubit>(
                        builder: (context, provider, child) {
                          return GestureDetector(
                            onTap: () {
                              provider.removeFromCart(item);
                            },
                            child: Icon(Icons.remove, size: 30),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            })
          ),
          BlocBuilder<FlutterCubit,depiState>(builder: (context,state){
            final cubit =context.read<FlutterCubit>();


            return Row(
              children: [
                Text('Total: \$'),
                Gap(10),
                Text(cubit.totalPrice.toString()),
              ],
            );

          })
        ],
      ),
      bottomNavigationBar:
      BlocBuilder<FlutterCubit,depiState>(builder: (context,state){
        final cubit =context.read<FlutterCubit>();

        return ElevatedButton(
          onPressed: () {
            cubit.checkOut();
          },
          child: Text('CheckOut'),
        );
      })
    );
  }
}
