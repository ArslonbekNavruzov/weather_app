import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class SevenDaysWeather extends StatelessWidget {
  const SevenDaysWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.sevenDaysBoxColor,
      ),
      height: 350,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SevenDaysWidget(
            text: model.date[index],
            daylyIcon: model.setDailyIcon(index),
            dayTemp: model.setDailyTemp(index),
            nightTemp: model.setNightTemp(index),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: model.date.length,
      ),
    );
  }
}

class SevenDaysWidget extends StatelessWidget {
  const SevenDaysWidget({
    super.key,
    required this.text,
    required this.daylyIcon,
    this.dayTemp = 0,
    this.nightTemp = 0,
  });

  final String text, daylyIcon;
  final int dayTemp, nightTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            text,
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.iconColor,
            ),
          ),
        ),
        const SizedBox(width: 30),
        Image.network(daylyIcon, width: 30, height: 30),
        const SizedBox(width: 20),
        Text('$dayTemp °C', style: AppStyle.fontStyle),
        const SizedBox(width: 10),
        Text(
          '$nightTemp °C',
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
