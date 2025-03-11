import 'dart:async';

import 'package:flutter/material.dart';

timerSnackbar({
  required BuildContext context,
  required String message,
  Widget? buttonPrefixWidget,
  String? buttonLabel,
  required void Function() afterTimeExecute,
  int second = 4,
  Color? backgroundColor,
  Color? backgroundColorButtonLabel,
  TextStyle? contentTextStyle,
}) {
  bool isExecute = true;
  final snackbar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 22.0),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: second * 1000.toDouble()),
            duration: Duration(seconds: second),
            builder: (context, double value, child) {
              return Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      value: value / (second * 1000),
                      color: Colors.grey.shade800,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Center(
                    child: Text((second - (value / 1000)).toInt().toString()),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(message, style: contentTextStyle ?? const TextStyle()),
        ),
        InkWell(
          splashColor: Colors.white,
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            isExecute = !isExecute;
            return;
          },
          child: Container(
            color: backgroundColorButtonLabel ?? Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (buttonPrefixWidget != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: buttonPrefixWidget,
                  ),
                if (buttonLabel != null)
                  Text(
                    buttonLabel,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor ?? Colors.transparent,
    duration: Duration(seconds: second),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(6.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);

  Timer(Duration(seconds: second), () {
    if (isExecute) afterTimeExecute();
  });
}
