import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdscapp/DataModels/vocals.dart';
import 'package:gdscapp/index.dart';

class DBHandler {
  // Declare dbHandler as nullable using the `?` syntax
  static DBHandler? dbHandler;
  var db = FirebaseFirestore.instance;
  final dbUsers = "users";
  final dbVocals = "vocals";

  // Private constructor
  DBHandler._();

  // Static method to get an instance of DBHandler
  static DBHandler getDBHandler() {
    dbHandler ??= DBHandler._();
    return dbHandler!;
  }

  void addUser(User user) async {
    await db.collection(dbUsers).doc(user.emailAddress).set(user.toJson());
  }

  Future<User?> getUser(String email) async {
    DocumentSnapshot snapshot = await db.collection(dbUsers).doc(email).get();
    User? user;
    if (snapshot.exists) {
      user = User.fromJson(snapshot.data() as Map<String, dynamic>);
    }

    return user;
  }

  Future<List<Vocals>> getAllVocals() async {
    try {
      QuerySnapshot querySnapshot = await db.collection(dbVocals).get();
      List<Vocals> vocalsList = querySnapshot.docs
          .map((doc) => Vocals.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return vocalsList;
    } catch (e) {
      print('Error retrieving vocals: $e');
      return [];
    }
  }
}
