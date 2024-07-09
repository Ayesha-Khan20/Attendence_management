import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceCountsScreen extends StatelessWidget {
  final CollectionReference attendance = FirebaseFirestore.instance.collection('Attendance');
  final CollectionReference leaves = FirebaseFirestore.instance.collection('Leaves');

 AttendanceCountsScreen({super.key});

  Future<Map<String, int>> getCounts(String email) async {
    QuerySnapshot attendanceSnapshot = await attendance.where('email', isEqualTo: email).get();
    QuerySnapshot leaveSnapshot = await leaves.where('email', isEqualTo: email).get();

    int presentCount = attendanceSnapshot.docs.length;
    int leaveCount = leaveSnapshot.docs.length;

    // Assuming a total of 30 days in the month for simplicity
    int totalDays = 30;
    int absentCount = totalDays - presentCount - leaveCount;

    return {
      'present': presentCount,
      'leave': leaveCount,
      'absent': absentCount,
    };
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Attendance Counts'),
        ),
        body: const Center(
          child: Text('You need to log in first'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Counts'),
      ),
      body: FutureBuilder(
        future: getCounts(user.email!),
        builder: (context, AsyncSnapshot<Map<String, int>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          Map<String, int> counts = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Present: ${counts['present']}'),
                Text('Leave: ${counts['leave']}'),
                Text('Absent: ${counts['absent']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
