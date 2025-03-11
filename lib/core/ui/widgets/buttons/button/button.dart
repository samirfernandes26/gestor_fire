import 'package:flutter/material.dart';

abstract class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.textButton,
    required this.colorText,
    required this.colorButton,
    required this.onPressed,
    this.traillingIcon,
    this.leadingIcon,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.useFlexible = false,
    this.minimumSize,
    this.widthButton,
  });

  Widget body();

  final Widget? leadingIcon, traillingIcon;
  final String textButton;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color colorText, colorButton;
  final FontWeight? fontWeight;
  final bool useFlexible;
  final Size? minimumSize;
  final double? widthButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

class Button extends BaseButton {
  const Button({
    super.key,
    required super.textButton,
    required super.colorText,
    required super.colorButton,
    required Function() super.onPressed,
    super.traillingIcon,
    super.leadingIcon,
    super.textAlign,
    super.fontWeight,
    super.fontSize,
    super.useFlexible,
    super.minimumSize,
    super.widthButton,
  });

  @override
  Widget body() {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: minimumSize ?? const Size.fromHeight(48),
        backgroundColor: colorButton,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingIcon != null) leadingIcon ?? const SizedBox.shrink(),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              textButton,
              textAlign: textAlign ?? TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 16,
                color: colorText,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          if (traillingIcon != null) traillingIcon ?? const SizedBox.shrink(),
        ],
      ),
    );

    if (widthButton != null) {
      return SizedBox(
        width: widthButton,
        child: button,
      );
    }

    if (useFlexible) {
      return Flexible(
        child: button,
      );
    }

    return button;
  }
}
