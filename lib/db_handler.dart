import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdscapp/index.dart';

class DBHandler {
  // Declare dbHandler as nullable using the `?` syntax
  static DBHandler? dbHandler;
  var db = FirebaseFirestore.instance;
  final dbUsers = "users";

  // Private constructor
  DBHandler._();

  // Static method to get an instance of DBHandler
  static DBHandler getDBHandler() {
    dbHandler ??= DBHandler._();
    return dbHandler!;
  }

  void addUser(User user) {
    db.collection(dbUsers).doc(user.name).set(user.toJson());
  }

  Future<User> getUser(String name) async {
    DocumentSnapshot snapshot = await db.collection(dbUsers).doc(name).get();

    User user = User.fromJson(snapshot.data() as Map<String, dynamic>);
    return user;
  }
}
