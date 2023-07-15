import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/routes/app_routes.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WeatherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return SafeArea(
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child: Center(
                child: TextButton.icon(
                  onPressed: () {
                    model.setFavorite(
                      context,
                      cityName: model.weatherData?.timezone,
                    );
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: AppColors.redColor,
                  ),
                  label: Text(
                    'Ташкент',
                    style:
                        AppStyle.fontStyle.copyWith(color: AppColors.iconColor),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
              icon: Icon(
                Icons.add,
                color: AppColors.iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => throw const SizedBox(height: 20);
}
