import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:gestor_fire/core/ui/messages/timer_snackbar.dart';

extension BuildContextExtention on BuildContext {
  ThemeData get theme => Theme.of(this);

  NavigatorState get navigator => Navigator.of(this);

  RouteSettings get route => ModalRoute.of(this)!.settings;

  Brightness get brightness => MediaQuery.of(this).platformBrightness;

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  void unfocus() => FocusScope.of(this).unfocus();

  void showSnackMessage({
    required String message,
    required String title,
    required ContentType contentType,
  }) =>
      scaffoldMessenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: contentType,
              message: message,
              title: title,
              titleTextStyle: const TextStyle(fontSize: 16),
            ),
          ),
        );

  void showMaterialMessage({
    required String message,
    required String title,
    ContentType? contentType,
    List<Widget> actions = const [SizedBox.shrink()],
  }) =>
      scaffoldMessenger
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(
          MaterialBanner(
            elevation: 0,
            forceActionsBelow: true,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: contentType ?? ContentType.help,
              message: message,
              title: title,
              inMaterialBanner: true,
            ),
            actions: actions,
          ),
        );

  void timerMessage({
    required String message,
    Color backgroundColor = Colors.blueAccent,
    Color? backgroundColorButtonLabel,
    int second = 5,
    Widget buttonPrefixWidget = const SizedBox.shrink(),
    String? buttonLabel,
  }) {
    timerSnackbar(
      context: this,
      message: message,
      backgroundColor: backgroundColor,
      buttonPrefixWidget: buttonPrefixWidget,
      buttonLabel: buttonLabel,
      backgroundColorButtonLabel: backgroundColorButtonLabel,
      afterTimeExecute: () {},
      second: second,
    );
  }
}
