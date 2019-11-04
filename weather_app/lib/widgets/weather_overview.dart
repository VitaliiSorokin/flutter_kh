import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/model/weather_provider.dart';
import 'package:weather_app/widgets/weather_container.dart';

class WeatherOverview extends StatelessWidget {
  final _weatherProvider = WeatherProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Overview"),
        centerTitle: true,
        leading: Icon(Icons.wb_sunny),
      ),
      body: Center(
        child: FutureBuilder<Weather>(
          future: _weatherProvider.getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WeatherContainer(weather: snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
