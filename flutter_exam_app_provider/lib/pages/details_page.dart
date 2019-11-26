import 'package:dating_app/models/location_provider.dart';
import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key key, this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'avatar',
              child: Image.network(
                user.image,
                fit: BoxFit.fill,
                height: 400,
                width: 400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChangeNotifierProvider<LocationProvider>(
                builder: (context) => LocationProvider()..getLocation(),
                child: _buildDistance(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistance(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, _) {
        if (provider.status == LocationStatus.success) {
          final km = const Distance().as(LengthUnit.Kilometer,
              provider.location, LatLng(user.latitude, user.longitude));
          return Text(
            '${user.name} is $km km away from you!',
            style: Theme.of(context).textTheme.headline,
          );
        } else if (provider.status == LocationStatus.error) {
          return Text(
            provider.error,
            style: Theme.of(context).textTheme.headline,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
