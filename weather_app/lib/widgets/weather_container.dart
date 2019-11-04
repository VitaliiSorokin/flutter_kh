import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/widgets/weather_landscape.dart';
import 'package:weather_app/widgets/weather_portrait.dart';

class WeatherContainer extends StatelessWidget {
  final Weather weather;

  WeatherContainer({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? WeatherPortrait(
                weather: weather,
              )
            : WeatherLandscape(
                weather: weather,
              );
      },
    );
  }
}
