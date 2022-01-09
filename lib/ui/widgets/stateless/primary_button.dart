import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';

class PrimaryButton extends StatelessWidget {
  final String content;
  final Function onPressed;

  const PrimaryButton(
      {Key? key, required this.content, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed.call(),
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: AniColor.colorBlack,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFF313233)),
        ),
        alignment: Alignment.center,
        child: Text(
          content,
          style: const TextStyle(fontSize: 16, color: AniColor.textMainColor),
        ),
      ),
    );
  }
}
