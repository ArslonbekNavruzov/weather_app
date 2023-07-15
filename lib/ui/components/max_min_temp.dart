import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class MaxMinTemp extends StatelessWidget {
  const MaxMinTemp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TempLevel(
          icon: 'assets/icons/arrow_up.svg',
          temp: '${model.maxTemp}°',
          color: AppColors.redColor,
        ),
        const SizedBox(width: 65),
        TempLevel(
          icon: 'assets/icons/arrow_down.svg',
          temp: '${model.minTemp}°',
          color: AppColors.blueColor,
        ),
      ],
    );
  }
}

class TempLevel extends StatelessWidget {
  const TempLevel({
    super.key,
    required this.icon,
    required this.temp,
    required this.color,
  });

  final String icon, temp;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          temp,
          style: AppStyle.fontStyle.copyWith(
            fontSize: 25,
            color: AppColors.iconColor,
          ),
        ),
      ],
    );
  }
}
