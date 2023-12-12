import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static addUrlToUserCollection(String userName, String url) async {
    var db = FirebaseFirestore.instance;
    var userCollection = db.collection(userName);
    await userCollection.doc().set({"url": url});
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getNotifications() async {
    var db = FirebaseFirestore.instance;
    var notificationsCollection = db.collection("notifications");
    var q = await notificationsCollection.get();
    return q.docs;
  }

  static void addNotification(
      String title, String body, Map<String, dynamic> data) async {
    var db = FirebaseFirestore.instance;
    var notificationsCollection = db.collection("notifications");
    await notificationsCollection.doc().set(
      {
        "title": title,
        "body": body,
        "data": data,
      },
    );
  }
}
