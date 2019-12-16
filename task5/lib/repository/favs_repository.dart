import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesRepository {
  FavoritesRepository({FirebaseUser fbUser}) : _fbUser = fbUser;
  final FirebaseUser _fbUser;
  final userCollection = Firestore.instance.collection('user');

  Future<void> addToFavorites(User user) async {
    if (await _doesPersonAlreadyExist(user)) {
      _removeFromFavorites(user);
    } else {
      await userCollection
          .document(_fbUser.uid)
          .collection('favorites')
          .add(<String, dynamic>{
        'name': user.name,
        'location': {'lat': user.latitude, 'long': user.longitude},
        'image': user.image
      });
    }
  }

  Future<bool> _doesPersonAlreadyExist(User user) async {
    final QuerySnapshot result = await userCollection
        .document(_fbUser.uid)
        .collection('favorites')
        .where('name', isEqualTo: user.name)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

  void _removeFromFavorites(User user) {
    try {
      userCollection
          .document(_fbUser.uid)
          .collection('favorites')
          .where('name', isEqualTo: user.name)
          .getDocuments()
          .then((snapshot) {
        snapshot.documents.first.reference.delete();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<User>> getFavorites() async {
    final users = <User>{};
    await userCollection
        .document(_fbUser.uid)
        .collection('favorites')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var item in snapshot.documents) {
        users.add(User(
            item.data['location']['lat'],
            item.data['location']['long'],
            item.data['image'],
            item.data['name']));
      }
    });
    return users.toList();
  }
}
