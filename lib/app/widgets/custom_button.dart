import 'package:flutter/material.dart';

import '../configs/app_textStyles.dart';

class CustomTextElevatedBtn extends ElevatedButton {
  final String? btnText;
  final TextStyle? textStyle;

  const CustomTextElevatedBtn(
      {super.key, required super.onPressed, this.btnText, super.child, super.style, this.textStyle});

  @override
  Widget? get child => super.child ?? _buildChild();

  Widget _buildChild() {
    return Center(
      child: Text(
        btnText ?? '',
        style: textStyle ?? AppTextStyles.customText16(color: Colors.black),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  @override
  ButtonStyle? get style => super.style;
}
