import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

void showSnackBar(BuildContext context, String message) {
  return VxToast.show(
    position: VxToastPosition.bottom,
    context,
    msg: message,
    bgColor: Colors.black,
    textColor: Colors.white,
  );
}
