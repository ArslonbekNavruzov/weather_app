import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/components/current_weather_status.dart';
import 'package:weather_app/ui/components/grid_items.dart';
import 'package:weather_app/ui/components/max_min_temp.dart';
import 'package:weather_app/ui/components/seven_days_weather.dart';
import 'package:weather_app/ui/components/sunrise_sunset_widget.dart';
import 'package:weather_app/ui/components/weather_appbar.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(context).setUp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomePageWidget();
          } else {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 25,
              ),
            );
          }
        },
      ),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            model.setBg(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const WeatherAppBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              children: [
                Text(
                  'Понедельник ${model.currentTime}',
                  textAlign: TextAlign.center,
                  style: AppStyle.fontStyle.copyWith(
                    color: AppColors.iconColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 36),
                const CurrentWeatherStatus(),
                const SizedBox(height: 28),
                Text(
                  '${model.currentTemp}℃',
                  textAlign: TextAlign.center,
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 90,
                    color: AppColors.iconColor,
                  ),
                ),
                const SizedBox(height: 18),
                const MaxMinTemp(),
                const SizedBox(height: 40),
                const SevenDaysWeather(),
                const SizedBox(height: 28),
                const SizedBox(
                  height: 382,
                  child: GridItems(),
                ),
                const SizedBox(height: 30),
                const SunRiseSunsetWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
