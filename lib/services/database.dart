import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_firabse/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  DatabaseService.withoutUID() : uid = "";
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Brew(sugars: e.get('sugars')??"0", strength: e.get('strength')??0, name: e.get('name')??"");
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((event) => _brewListFromSnapshot(event));
  }
}
