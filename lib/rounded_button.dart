import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btntext;
  final Function onBtnPressed;
  const RoundedButton(
      {super.key, required this.btntext, required this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: const Color.fromRGBO(3, 37, 140, 1),
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () {
          onBtnPressed();
        },
        minWidth: 320,
        height: 60,
        child: Text(
          btntext,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
