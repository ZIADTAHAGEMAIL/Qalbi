import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../basic/bloc.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<counterbloc, int>(
              builder: (context, state) {
                if (state == 2) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('NOOOOO')));
                }
                return Text(state.toString());
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<counterbloc>().plus();
              },
              child: Text('plus'),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<counterbloc>().minus();
              },
              child: Text('minus'),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<counterbloc>().reset();
              },
              child: Text('reset'),
            ),
          ],
        ),
      ),
    );
  }
}
