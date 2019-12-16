import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/bloc/details_bloc/bloc.dart';
import 'package:dating_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({Key key, this.user, this.person}) : super(key: key);

  final User person;
  final FirebaseUser user;
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name),
      ),
      body: BlocProvider<DetailsBloc>(
        create: (context) =>
            DetailsBloc(user: person, fbUser: user)..add(GetDistance()),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'avatar',
                child: Image.network(
                  person.image,
                  fit: BoxFit.fill,
                  height: 400,
                  width: 400,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<DetailsBloc, DetailsState>(
                      builder: (context, state) {
                    if (state is DistanceCalculated) {
                      return Text(
                        '${person.name} is ${state.distance} km away from you!',
                        style: Theme.of(context).textTheme.headline,
                      );
                    } else if (state is Error) {
                      return Text(
                        state.message,
                        style: Theme.of(context).textTheme.headline,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })),
              BlocBuilder<DetailsBloc, DetailsState>(
                builder: (context, state) => Ink(
                  decoration: ShapeDecoration(
                    color: Colors.red,
                    shape: const CircleBorder(),
                  ),
                  child: IconButton(
                    iconSize: 36,
                    onPressed: () {
                      BlocProvider.of<DetailsBloc>(context)
                          .add(LikePerson(person: person));
                    },
                    icon: Icon(Icons.favorite),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<LatLng> _getCoordinates() async {
    final permission = LocationPermissions();
    await permission.requestPermissions();

    final geolocator = Geolocator();
    final position = await geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  Future<void> _likeUser() async {
    if (await _doesPersonAlreadyExist()) {
      _deletePerson();
    } else {
      await _addPerson();
    }
  }

  Future<bool> _doesPersonAlreadyExist() async {
    final QuerySnapshot result = await Firestore.instance
        .collection('user')
        .document(user.uid)
        .collection('favorites')
        .where('name', isEqualTo: person.name)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

  void _deletePerson() {
    try {
      databaseReference
          .collection('user')
          .document(user.uid)
          .collection('favorites')
          .where('name', isEqualTo: person.name)
          .getDocuments()
          .then((snapshot) {
        snapshot.documents.first.reference.delete();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _addPerson() async {
    await databaseReference
        .collection('user')
        .document(user.uid)
        .collection('favorites')
        .add(<String, dynamic>{
      'name': person.name,
      'location': {'lat': person.latitude, 'long': person.longitude},
      'image': person.image
    });
  }
}
