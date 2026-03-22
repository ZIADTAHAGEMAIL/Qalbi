import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Scrollingui extends StatelessWidget {
  const Scrollingui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Grid Builder',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
        crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(color: Colors.green[50],borderRadius: BorderRadiusGeometry.circular(15)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                Icon(Icons.star,size: 40,color: Colors.green[400],),
                Divider(height: 1,),
              Text('Index $index'),

              ]),
            );
          },
        ),
      ),
    );
  }
}
