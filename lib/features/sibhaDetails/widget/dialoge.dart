
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';

import '../../../core/constant/appColors.dart';

class dialoge extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const dialoge({required this.controller, required this.onAdd});

  @override
  _dialogeState createState() => _dialogeState();
}

class _dialogeState extends State<dialoge> {
  @override
  Widget build(BuildContext context) {
    return ScalifyBox(
      referenceWidth: 360,
      referenceHeight: 731,
      builder: (context,ls){
        return AlertDialog(
          elevation: 0,

          alignment: AlignmentGeometry.center,
          backgroundColor: Appcolors.SibhaviewTeal,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                cursorColor: Colors.white,

                controller: widget.controller,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),

                decoration: InputDecoration(
                  labelText: 'اكتب هنا',

                  labelStyle: TextStyle(color: Colors.white),

                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: ls.br(15),
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: ls.br(15),
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: ls.br(15),
                    gapPadding: ls.s(5),
                  ),
                ),
              ),
              ls.sbh(10),
              ElevatedButton(onPressed: widget.onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.SibhaviewGold, // لون خلفية الزر
                  foregroundColor: Colors.black,         // لون النص والأيقونة داخل الزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // لو حابب تخليه بحدود دائرية متناسقة
                  ),), child: Text('اضف الذكر',
                style: TextStyle(

                ),

              ),)
            ],
          ),
        );
      },
    
    );
  }
}
