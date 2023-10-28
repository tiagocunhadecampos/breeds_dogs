import 'package:flutter/material.dart';
import '../utils/theme.utils.dart';

class ButtonWidget extends StatelessWidget {
  final String? title;
  final Color? textColor;
  final Color? selectColor;
  final void Function()? onPressed;

  const ButtonWidget({
    Key? key,
    this.title,
    this.onPressed,
    this.textColor,
    this.selectColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: selectColor ?? Colors.white,
            border: Border.all(color: selectColor ?? ThemeUtils.getTheme(), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Center(
              child: Text(
                title!,
                style: TextStyle(
                  color: selectColor != null ? ThemeUtils.getBackGround() : ThemeUtils.getTheme(),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
