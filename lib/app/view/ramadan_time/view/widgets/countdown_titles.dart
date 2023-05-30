import 'package:flutter/material.dart';
import 'package:ramadan_app/core/constants/app_colors.dart';

class CountdownTitles extends StatelessWidget {
  const CountdownTitles({
    super.key,
    required this.text,
    this.isTypeTitle = false,
  });
  final String text;
  final bool isTypeTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: isTypeTitle
          ? Theme.of(context).textTheme.displayLarge!.copyWith(
                color: AppColors.primaryColor,
              )
          : Theme.of(context).textTheme.displayLarge,
    );
  }
}
