import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  static Stream<List<Workout?>> streamUserWorkouts({required String userId}) {
    return FirebaseFirestore.instance
        .collection('workouts')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
      (event) {
        return event.docs.map(
          (e) {
            return Workout.fromMap(
              Map<String, dynamic>.from(
                e.data()
                  ..addAll(
                    {'id': e.id},
                  ),
              ),
            );
          },
        ).toList();
      },
    );
  }

  static Future addWorkout(String name, String userId) {
    return FirebaseFirestore.instance.collection('workouts').add({
      'name': name,
      'userId': userId,
      'createdAt': DateTime.now(),
    });
  }

  static Future updateWorkout(String name, String docId) {
    return FirebaseFirestore.instance.collection('workouts').doc(docId).update({
      'name': name,
      'createdAt': DateTime.now(),
    });
  }

  static Future deleteWorkout(String docId) {
    return FirebaseFirestore.instance
        .collection('workouts')
        .doc(docId)
        .delete();
  }
}
