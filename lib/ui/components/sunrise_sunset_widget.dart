import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class SunRiseSunsetWidget extends StatelessWidget {
  const SunRiseSunsetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.all(40),
      width: MediaQuery.of(context).size.width,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.sevenDaysBoxColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ItemWidget(
            icon: 'assets/icons/sunrise.svg',
            text: 'Восход ${model.setCurrentSunrise()}',
          ),
          ItemWidget(
            icon: 'assets/icons/sunset.svg',
            text: 'Закат ${model.setCurrentSunSet()}',
          ),
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon, color: AppColors.iconColor),
        const SizedBox(height: 20),
        Text(
          text,
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.iconColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
