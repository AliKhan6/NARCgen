import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double elevation;
  final Color textColor;
  final Color buttonColor;

  CustomButton(
      {this.title,
      this.onPressed,
      this.textColor,
      this.elevation,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(8),
        elevation: elevation,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 52,
          width: double.infinity,
          child: Center(
              child: Text(
            title,
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
