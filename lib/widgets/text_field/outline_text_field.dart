import 'package:flutter/material.dart';

class OutlineTextField extends StatelessWidget {

  String hintText;
  TextEditingController textEditingController;
  TextInputType textInputType;
  int maxLines = null;

  OutlineTextField({
    this.hintText,
    this.textEditingController,
    this.textInputType,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      maxLines: maxLines,
      controller: textEditingController,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: true,
          hintStyle: new TextStyle(color: Colors.grey[800]),
          hintText: this.hintText,
          fillColor: Colors.white70
          ),
    );
  }
}
