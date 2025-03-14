import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  final firestore = FirebaseFirestore.instance;

  Future<String> write(String key, dynamic value) async {
    var doc = await firestore.collection(key).add(value);
    await doc.update({'docid': doc.id});
    return doc.id;
  }

  dynamic read(String key, String uid) async {
    var snapshot =
        await firestore.collection(key).where('uid', isEqualTo: uid).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> delete(String key, String docid) async {
    await firestore.collection(key).doc(docid).delete();
  }

  Future<void> update(String key, String docid, dynamic value) async {
    await firestore.collection(key).doc(docid).update(value);
  }
}
