import 'package:flutter/material.dart';

class CustonTextField {
  final String title;
  final String placeholder;
  final bool ispass;
  String err;
  String _value;

  CustonTextField(
      {this.title = "",
      this.placeholder = "",
      this.ispass = false,
      this.err = ""});

  TextEditingController controller = new TextEditingController();

  TextFormField textFormField() {
    return TextFormField(
      controller: controller,
      onChanged: (e) {
        _value = e;
      },
      validator: (e) => e.isEmpty ? this.err : null,
      obscureText: this.ispass,
      decoration: InputDecoration(
          hintText: this.placeholder,
          labelText: this.title,
          labelStyle: TextStyle(color: Colors.black45),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45))),
    );
  }

  String get value {
    return _value;
  }
}
