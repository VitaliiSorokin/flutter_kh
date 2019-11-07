import 'package:flutter/material.dart';
import 'package:good_place/model/favorite_place.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({Key key, this.place}) : super(key: key);

  final FavoritePlace place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(place.photo),
      title: Text(
        place.name,
        style: Theme.of(context).textTheme.subhead,
        maxLines: 1,
      ),
      subtitle: Text(
        place.description,
        style: Theme.of(context).textTheme.subtitle,
        maxLines: 1,
      ),
    );
  }
}
