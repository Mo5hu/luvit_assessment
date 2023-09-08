import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeDatabaseService {
  late DatabaseReference _databaseReference;

  FirebaseRealtimeDatabaseService() {
    _databaseReference = FirebaseDatabase.instance.ref();
  }

  Stream<DatabaseEvent> listenToDataUpdates(String path) {
    DatabaseReference reference = _databaseReference.child(path);
    return reference.onValue;
  }
}
