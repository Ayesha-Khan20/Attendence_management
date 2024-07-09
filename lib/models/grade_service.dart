import 'package:cloud_firestore/cloud_firestore.dart';

class GradeService {
  Future<String> calculateGrade(String email) async {
    QuerySnapshot attendanceSnapshot = await FirebaseFirestore.instance
        .collection('Attendance')
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'present')
        .get();
    int presentCount = attendanceSnapshot.docs.length;

    QuerySnapshot gradesSnapshot = await FirebaseFirestore.instance
        .collection('Grades')
        .orderBy('days', descending: true)
        .get();

    for (var doc in gradesSnapshot.docs) {
      int days = doc['days'];
      String grade = doc['grade'];
      if (presentCount >= days) {
        return grade;
      }
    }

    return 'F'; // Default grade if no criteria met
  }
}
