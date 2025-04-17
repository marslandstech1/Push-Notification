import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utils {
  static AppBar customAppBar({String text = "AppBar", List<Widget>? actions}) {
    return AppBar(
      title: Text(
        text,
        style: customTextStyle(),
      ),
      centerTitle: true,
      backgroundColor: Colors.pink[200],
      actions: actions,
    );
  }

  static TextStyle customTextStyle(
      {Color? color = Colors.black,
      double? fontSize = 16,
      FontWeight? fontWeight = FontWeight.normal}) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  static changeFocusOfField(BuildContext context, FocusNode originFocusNode,
      FocusNode? destinationFocusNode) {
    originFocusNode.unfocus();
    destinationFocusNode != null
        ? FocusScope.of(context).requestFocus(destinationFocusNode)
        : null;
  }

  static toastMsg(String msg){
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}
