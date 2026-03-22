import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tileswap extends StatefulWidget {
  const Tileswap({super.key});

  @override
  State<Tileswap> createState() => _TileswapState();
}

class _TileswapState extends State<Tileswap> {
  List<int> numbers = [5, 4, 1, 9, 2, 3, 6, 7, 8];
  int num1 = -1;
  int num2 = -1;

  @override
  Widget build(BuildContext context) {
    bool all = true;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'tile Swap Puzzle ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            'Tap a Tile to Select',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsetsGeometry.all(10),
              itemCount: numbers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    num1 == -1 ? num1 = index : num2 = index;
                    if (num1 != -1 && num2 != -1) {
                      int temp = numbers[num1];
                      numbers[num1] = numbers[num2];
                      numbers[num2] = temp;

                      setState(() {});
                      num1 = -1;
                      num2 = -1;
                      for (int i = 0; i < numbers.length; i++) {
                        if (numbers[i] != i + 1) {
                          all = false;
                        }
                      }
                      if (all) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Congratulation'),
                            duration: Duration(seconds: 6),
                          ),
                        );
                      }
                    }
                  },
                  child: Card(
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        '${numbers[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
