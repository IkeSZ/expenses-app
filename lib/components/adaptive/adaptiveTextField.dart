import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String) onSubmitted;
  final TextInputType keyboardType;

  AdaptiveTextField({
    @required this.label,
    this.controller,
    @required this.onSubmitted,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? Padding(
      padding: EdgeInsets.only(bottom: 10),

      child: CupertinoTextField(
        controller: controller,
        keyboardType: keyboardType,

        onSubmitted: onSubmitted,

        placeholder: label,

        padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 12
        ),
      ),
    ) : TextField(
      controller: controller,
      keyboardType: keyboardType,

      onSubmitted: onSubmitted,

      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
