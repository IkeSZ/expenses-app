import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptiveButton({ this.label, this.onPressed });

  @override
  Widget build(BuildContext ctx) {
    return Platform.isIOS ? CupertinoButton(
      child: Text(label),
      onPressed: onPressed,
      color: CupertinoColors.opaqueSeparator,

      padding: EdgeInsets.symmetric(
        horizontal: 20
      ),
    ) : RaisedButton(
      textColor: Colors.white,
      color: Theme.of(ctx).primaryColor,

      child: Text(label),
      onPressed: onPressed,
    );
  }
}
