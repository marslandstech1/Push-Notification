import 'package:flutter/material.dart';

import '../helper/utils.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    this.text,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 62,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.pink[100]
        ),
        child: Center(
          child: Text("$text", style: Utils.customTextStyle(),),
        ),
      ),
    );
  }
}