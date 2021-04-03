import 'package:flutter/material.dart';

class OutlineTextField extends StatelessWidget {

  String hintText;
  TextEditingController textEditingController;

  OutlineTextField({
    this.hintText,
    this.textEditingController
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
