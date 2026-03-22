import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';

import '../../../shared/widget/customText.dart';

class Dailyayaahcard extends StatelessWidget {
  final String randomAyah;
  final int surahNumber;
  final int verseNumber;
  final LocalScaler ls;
  final Function() onTap;
   Dailyayaahcard({super.key, required this.ls, required this.randomAyah,
    required this.surahNumber,
    required this.verseNumber, required this.onTap

   });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ls.p(20),
      decoration: BoxDecoration(
        borderRadius: ls.br(24),
        color: Colors.grey.shade100,
        image: DecorationImage(
          // image: Image.asset('assets/image/mosque.png'),
          image: AssetImage('assets/image/mosque.png'),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Customtext(
            text: 'Daily Ayah ',
            textcolor: Colors.black,
            textsize: ls.fz(16),
            textweight: FontWeight.bold,
          ),

ls.sbh(10),
          Customtext(
            text: randomAyah,
            textcolor: Colors.black,
            textsize: ls.fz(14),
            textweight: FontWeight.bold,
          ),

          ls.sbh(15),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.8),
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: ls.br(12),
              ),
            ),
            child:

            Customtext(
              text: 'Read Tafsir',
              textcolor: Colors.black,
              textsize: ls.fz(16),
              textweight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );  }
}
