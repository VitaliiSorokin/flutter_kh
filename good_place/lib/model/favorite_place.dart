import 'dart:io';

class FavoritePlace {
  FavoritePlace(this.name, this.description, this.photo);

  final File photo;
  final String name;
  final String description;
}
