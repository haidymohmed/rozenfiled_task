import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
showToastError({required String msg, required state, ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: chooseToastTextColor(state),
      fontSize: 16.0
  );
}

// ignore: constant_identifier_names
enum ToastedStates { SUCCESS, ERROR, WARNING , NORMAL}

Color chooseToastColor(ToastedStates states) {
  Color color;
  switch (states) {
    case ToastedStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastedStates.ERROR:
      color = Colors.red;
      break;
    case ToastedStates.WARNING:
      color = Colors.amber;
      break;
    case ToastedStates.NORMAL:
      color = Colors.grey.shade400 ;
  }
  return color;
}
Color chooseToastTextColor(ToastedStates states) {
  Color color;
  switch (states) {
    case ToastedStates.NORMAL:
      color = Colors.black;
      break;
    default:
      color = Colors.white ;
  }
  return color;
}