import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdscapp/DataModels/history.dart';
import 'package:gdscapp/index.dart';

class DBHandler {
  // Declare dbHandler as nullable using the `?` syntax
  static DBHandler? dbHandler;
  var db = FirebaseFirestore.instance;
  final dbUsers = "users";
  final dbVocals = "vocals";
  final dbHistory = "history";

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

  Future<Vocals> getVocalDetail(String word) async {
    try {
      QuerySnapshot querySnapshot =
          await db.collection(dbVocals).where('words', isEqualTo: word).get();
      if (querySnapshot.docs.isNotEmpty) {
        // Check if the query result is not empty
        DocumentSnapshot docSnapshot = querySnapshot.docs[0];
        Vocals vocal =
            Vocals.fromJson(docSnapshot.data() as Map<String, dynamic>);
        return vocal;
      } else {
        // Handle the case when no documents are found
        print('No documents found for word: $word');
        return Vocals(); // Or return a default or null object as needed
      }
    } catch (e) {
      print('Error retrieving vocals: $e');
      return Vocals();
    }
  }

  Future<List<History>> getHistory(String userID) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection(dbHistory)
          .where('userID', isEqualTo: userID)
          .get();
      List<History> historyList = querySnapshot.docs
          .map((doc) => History.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return historyList;
    } catch (e) {
      print('Error retrieving vocals: $e');
      return [];
    }
  }

  void setHistory(History history) async {
    await db.collection(dbHistory).doc().set(history.toJson());
  }
}
