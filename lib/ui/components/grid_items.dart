import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class GridItems extends StatelessWidget {
  const GridItems({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: WeatherGridIcons.weatherGridIcons.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 181,
          height: 181,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: AppColors.sevenDaysBoxColor,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 57,
                horizontal: 20,
              ),
              leading:
                  SvgPicture.asset(WeatherGridIcons.weatherGridIcons[index]),
              title: Text(
                '${model.setValues(index)} ${WeathergridUnits.weathergridUnits[index]}',
                style: AppStyle.fontStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.iconColor,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                WeathergridDesc.itemDescription[index],
                style: AppStyle.fontStyle.copyWith(
                  fontSize: 10,
                  color: AppColors.iconColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class WeatherGridIcons {
  static List<String> weatherGridIcons = [
    'assets/icons/wind_speed.svg',
    'assets/icons/thermometer.svg',
    'assets/icons/raindrops.svg',
    'assets/icons/glasses.svg',
  ];
}

class WeathergridDesc {
  static List<String> itemDescription = [
    'Скорость ветра',
    'Ощущается',
    'Влажность',
    'Видимость',
  ];
}

// Alt + 0176 = °
class WeathergridUnits {
  static List<String> weathergridUnits = [
    'км/ч',
    '°',
    '%',
    'км',
  ];
}
