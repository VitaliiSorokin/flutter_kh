import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';

class WeatherLandscape extends StatelessWidget {
  final Weather weather;

  WeatherLandscape({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '${weather.locationName}   ${weather.temperature} °C',
          style: Theme.of(context).textTheme.display1,
          textAlign: TextAlign.center,
        ),
        Image.network(weather.iconUrl),
      ],
    );
  }
}
