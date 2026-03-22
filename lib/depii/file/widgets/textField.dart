import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String label;
  final void Function(String?) onSaved;
  final TextEditingController controller;
  const Textfield({
    super.key,
    required this.label,
    required this.onSaved,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: label=='Description'?5:1,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'please enter $label';
        }
        return null;
      },
      onSaved: onSaved,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
