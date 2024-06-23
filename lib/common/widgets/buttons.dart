import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:get/get.dart';

// Custom widget for buttons

class ButtonType extends StatelessWidget {
  const ButtonType(
      {super.key,
      required this.text,
      required this.color,
      required this.type,
      this.onPressed});
  final String text;
  final Color color;
  final String type;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return type == "primary"
        ?
        // primary button
        SizedBox(
            width: context.width,
            child: ButtonTheme(
              child: FilledButton(
                  onPressed: onPressed,
                  style: FilledButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      overlayColor: const Color.fromARGB(0, 255, 255, 255),
                      textStyle: tButton,
                      foregroundColor: (color == pink5) ? blue8 : white1,
                      backgroundColor: color,
                      alignment: Alignment.center,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                  child: Text(text)),
            ),
          )
        : type == "secondary"
            ?
            // secondary button
            SizedBox(
                width: context.width,
                child: ButtonTheme(
                  child: TextButton(
                      onPressed: onPressed,
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        overlayColor: const Color.fromARGB(0, 255, 255, 255),
                        foregroundColor: color,
                        textStyle: tButton,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            side: BorderSide(
                              color: color,
                              width: 1,
                            )),
                      ),
                      child: Text(text)),
                ),
              )
            :
            // tertiary button
            Container(
                height: 36,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: color),
                  ),
                ),
                child: TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
                      foregroundColor: color,
                      textStyle: tButton,
                      iconColor: color,
                      alignment: Alignment.center),
                  child: Text(text),
                ),
              );
  }
}

class ButtonTypeIcon extends StatelessWidget {
  const ButtonTypeIcon(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.type,
      this.onPressed});
  final String text;
  final IconData icon;
  final Color color;
  final String type;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return type == "primary"
        ?
        // primary button
        SizedBox(
            width: context.width,
            child: ButtonTheme(
              child: FilledButton.icon(
                  onPressed: onPressed,
                  style: FilledButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      overlayColor: const Color.fromARGB(0, 255, 255, 255),
                      textStyle: tButton,
                      foregroundColor: (color == pink5) ? blue8 : white1,
                      backgroundColor: color,
                      alignment: Alignment.center,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                  icon: color == pink5
                      ? Icon(icon, color: blue8, size: 24)
                      : Icon(icon, color: white1, size: 24),
                  iconAlignment: IconAlignment.start,
                  label: Text(text)),
            ),
          )
        : type == "secondary"
            ?
            // secondary button
            SizedBox(
                width: context.width,
                child: ButtonTheme(
                    child: TextButton.icon(
                        onPressed: onPressed,
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          overlayColor: const Color.fromARGB(0, 255, 255, 255),
                          textStyle: tButton,
                          foregroundColor: color,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              side: BorderSide(
                                color: color,
                                width: 1,
                              )),
                        ),
                        icon: Icon(icon, color: color, size: 24),
                        iconAlignment: IconAlignment.start,
                        label: Text(text))),
              )
            :
            // tertiary button
            Container(
                height: 36,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: color),
                  ),
                ),
                child: TextButton.icon(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      textStyle: tButton,
                      foregroundColor: color,
                      alignment: Alignment.center,
                    ),
                    icon: Icon(icon, color: color, size: 24),
                    iconAlignment: IconAlignment.start,
                    label: Text(text)));
  }
}
