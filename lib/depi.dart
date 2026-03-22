import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class depi extends StatelessWidget {
  const depi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Counter App',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text('You have pushed this many time'),
            Consumer<depiProvider>(
              builder: (context, provier, child) {
                return Text(provier.count.toString());
              },
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<depiProvider>(context, listen: false).Increment();
              },
              child: Text('Increment'),
            ),

            ElevatedButton(
              onPressed: () {
                Provider.of<depiProvider>(context, listen: false).Decrement();
              },
              child: Text('Decrement'),
            ),

            ElevatedButton(
              onPressed: () {
                Provider.of<depiProvider>(context, listen: false).Reset();
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

class depiProvider extends ChangeNotifier {
  int count = 0;

  void Increment() {
    count++;
    notifyListeners();
  }

  void Decrement() {
    if (count > 0) count--;
    notifyListeners();
  }

  void Reset() {
    count = 0;
    notifyListeners();
  }
}
