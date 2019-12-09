import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final bool isPrimary;
  final bool isPrimaryFilled;

  CommonButton({@required this.onPressed, @required this.text, this.isPrimary = false, this.isPrimaryFilled = false});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
      color: isPrimary ? Colors.white : isPrimaryFilled ? Theme.of(context).primaryColor : Colors.transparent,
      textColor: isPrimary ? Theme.of(context).primaryColor : Colors.white,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

