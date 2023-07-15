import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/api/api.dart';
import 'package:weather_app/domain/hive/favorite_history.dart';
import 'package:weather_app/domain/hive/hive_boxes.dart';
import 'package:weather_app/domain/model/coord.dart';
import 'package:weather_app/domain/model/weather_data.dart';
import 'package:weather_app/ui/resources/app_bg.dart';
import 'package:weather_app/ui/theme/app_colors.dart';

class WeatherProvider extends ChangeNotifier {
  //хранение  координат
  static Coord? coords;

  //хранение данных о погоде
  WeatherData? weatherData;

  //хранение текущих данных о погоде
  Current? current;

  //контроллер поиска
  final searchController = TextEditingController();

  //Главная функция
  Future<WeatherData?> setUp({String? cityName}) async {
    coords = await Api.getCoords(cityName: cityName ?? 'Ташкент');
    weatherData = await Api.getWeather(coords);
    current = weatherData?.current;

    setCurrentTime();
    setCurrentTemp();
    setMinTemp();
    setMaxTemp();
    setSevenDays();
    return weatherData;
  }

  //изменение заднего фона

  String? currentBg;

  String setBg() {
    int id = current?.weather?[0].id ?? -1;
    if (id == -1 || current?.sunset == null || current?.dt == null) {
      currentBg = AppBg.shinyDay;
    }

    try {
      if (current!.sunset! < current!.dt!) {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyNight;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowNight;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogNight;
        } else if (id == 800) {
          currentBg = AppBg.shinyNight;
          AppColors.iconColor = AppColors.whiteColor;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyNight;
        }
      } else {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyDay;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowDay;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogDay;
        } else if (id == 800) {
          currentBg = AppBg.shinyDay;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyDay;
        }
      }
    } catch (e) {
      return AppBg.shinyDay;
    }

    return currentBg ?? AppBg.shinyDay;
  }

  //текущее время

  String? currentTime;

  String setCurrentTime() {
    final getTime = (current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0);

    // print(getTime);

    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);

    // print(setTime);

    currentTime = DateFormat('HH:mm a').format(setTime);

    return currentTime ?? 'Error';
  }

  ///*метод превращения первой буквы слова в заглавную, остальные строчные*/
  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  //текущий статус погоды
  String currentStatus = 'Ошибка';

  String getCurrentStatus() {
    currentStatus = current?.weather?[0].description ?? 'Ошибка';
    return capitalize(currentStatus);
  }

  //https://openweathermap.org/img/wn/

  String weatherIconsUrl = 'https://openweathermap.org/img/wn/';

  //получение текущей иконки
  String iconData() {
    return '$weatherIconsUrl${current?.weather?[0].icon}.png';
  }

  //получение текущей температуры

  int kelvin = -273;
  int currentTemp = 0;

  int setCurrentTemp() {
    currentTemp = ((current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
  }

  // max temp
  dynamic maxTemp = 0;

  setMaxTemp() {
    maxTemp = ((weatherData?.daily?[0].temp?.max ?? -kelvin) + kelvin)
        .roundToDouble();
    print(maxTemp);
    return maxTemp;
  }

  // min temp
  dynamic minTemp = 0;

  setMinTemp() {
    minTemp = ((weatherData?.daily?[0].temp?.min ?? -kelvin) + kelvin)
        .roundToDouble();
    return minTemp;
  }

  //установка дней недели

  final List<String> _date = [];
  List<String> get date => _date;

  List<Daily> _daily = [];
  List<Daily> get daily => _daily;

  void setSevenDays() {
    _daily = weatherData?.daily ?? [];

    for (var i = 0; i < _daily.length; i++) {
      if (i == 0 && _daily.isNotEmpty) {
        _date.clear();
      }

      if (i == 0) {
        date.add('Сегодня');
      } else {
        var timeNum = _daily[i].dt * 1000;
        var itemDate = DateTime.fromMillisecondsSinceEpoch(timeNum);
        _date.add(capitalize(DateFormat('EEEE', 'ru').format(itemDate)));
      }
    }
  }

  // получение иконок для каждого дня недели
  final String _iconUrlPath = 'http://openweathermap.org/img/wn/';

  String setDailyIcon(int index) {
    final String getIcon = '${weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$_iconUrlPath$getIcon.png';

    return setIcon;
  }

  // получение дневной температуры на каждый день
  int dailyTemp = 0;
  int setDailyTemp(int index) {
    dailyTemp =
        ((weatherData?.daily?[index].temp?.day ?? -kelvin) + kelvin).round();
    return dailyTemp;
  }

  // получение ночной температуры на каждый день
  int nightTemp = 0;
  int setNightTemp(int index) {
    nightTemp =
        ((weatherData?.daily?[index].temp?.night ?? -kelvin) + kelvin).round();
    return nightTemp;
  }

  //Добавление в массив данных о погодных условиях

  final List<dynamic> _weatherValues = [];
  List<dynamic> get weatherValues => _weatherValues;

  dynamic setValues(int index) {
    _weatherValues.add(current?.windSpeed ?? 0);
    _weatherValues.add(((current?.feelsLike ?? -kelvin) + kelvin).round());
    _weatherValues.add((current?.humidity ?? 0) / 1);

    print(current?.humidity);

    _weatherValues.add((current?.visibility ?? 0) / 1000);

    print(current?.visibility);

    return weatherValues[index];
  }

  //текущее время восхода
  String sunRise = '';
  String setCurrentSunrise() {
    final getSunTime =
        (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunRise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunRise = DateFormat('HH:mm a').format(setSunRise);

    return sunRise;
  }

  //текущее время заката
  String sunSet = '';
  String setCurrentSunSet() {
    final getSunTime =
        (current?.sunset ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunSet = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunSet = DateFormat('HH:mm a').format(setSunSet);

    return sunSet;
  }

  //добавление в избранное

  Future<void> setFavorite(BuildContext context, {String? cityName}) async {
    var box = Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox);

    box
        .add(
          FavoriteHistory(
            weatherData?.timezone ?? 'Error',
            currentBg ?? AppBg.shinyDay,
            AppColors.iconColor.value,
          ),
        )
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.sevenDaysBoxColor,
              content: Text(
                'Город $cityName добавлен в избранное',
              ),
            ),
          ),
        );
  }

  //удаление из избранного

  Future<void> deleteFavorite(int index) async {
    var box = Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox);
    box.deleteAt(index);
  }
}
