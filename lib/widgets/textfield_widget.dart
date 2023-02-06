import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  String? label;
  TextFieldWidget({this.label, this.controller,this.keyboardType});
  TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label ?? ""),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
