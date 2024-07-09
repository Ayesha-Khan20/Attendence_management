// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';


// class CompleteSystemReportScreen extends StatefulWidget {
//   @override
//   _CompleteSystemReportScreenState createState() => _CompleteSystemReportScreenState();
// }

// class _CompleteSystemReportScreenState extends State<CompleteSystemReportScreen> {
//   final CollectionReference attendance = FirebaseFirestore.instance.collection('Attendance');
//   DateTime? fromDate;
//   DateTime? toDate;

//   List<DocumentSnapshot> attendanceRecords = [];

//   Future<void> _selectDate(BuildContext context, bool isFromDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != (isFromDate ? fromDate : toDate)) {
//       setState(() {
//         if (isFromDate) {
//           fromDate = picked;
//         } else {
//           toDate = picked;
//         }
//       });
//     }
//   }

//   void generateReport() async {
//     if (fromDate == null || toDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select both dates')));
//       return;
//     }

//     QuerySnapshot snapshot = await attendance
//         .where('timestamp', isGreaterThanOrEqualTo: fromDate)
//         .where('timestamp', isLessThanOrEqualTo: toDate)
//         .get();

//     setState(() {
//       attendanceRecords = snapshot.docs;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Complete System Report'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: ListTile(
//                     title: Text('From: ${fromDate == null ? 'Select Date' : DateFormat.yMd().format(fromDate!)}'),
//                     trailing: Icon(Icons.calendar_today),
//                     onTap: () => _selectDate(context, true),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListTile(
//                     title: Text('To: ${toDate == null ? 'Select Date' : DateFormat.yMd().format(toDate!)}'),
//                     trailing: Icon(Icons.calendar_today),
//                     onTap: () => _selectDate(context, false),
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: generateReport,
//               child: Text('Generate Report'),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: attendanceRecords.length,
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic> data = attendanceRecords[index].data()! as Map<String, dynamic>;
//                   return ListTile(
//                     title: Text('Email: ${data['email']}'),
//                     subtitle: Text('Date: ${data['date']} - Status: ${data['status']}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// //grading system


// class GradingSystemScreen extends StatefulWidget {
//   @override
//   _GradingSystemScreenState createState() => _GradingSystemScreenState();
// }

// class _GradingSystemScreenState extends State<GradingSystemScreen> {
//   final CollectionReference grades = FirebaseFirestore.instance.collection('Grades');
//   final TextEditingController daysController = TextEditingController();
//   final TextEditingController gradeController = TextEditingController();

//   void addGrade() async {
//     if (daysController.text.isEmpty || gradeController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
//       return;
//     }

//     await grades.add({
//       'days': int.parse(daysController.text),
//       'grade': gradeController.text,
//     });

//     daysController.clear();
//     gradeController.clear();
//   }

//   void deleteGrade(String docId) async {
//     await grades.doc(docId).delete();
//   }

// //   Future<String> calculateGrade(String email) async {
// //   QuerySnapshot attendanceSnapshot = await attendance.where('email', isEqualTo: email).get();
// //   int presentCount = attendanceSnapshot.docs.length;

// //   QuerySnapshot gradesSnapshot = await grades.orderBy('days', descending: true).get();

// //   for (var doc in gradesSnapshot.docs) {
// //     int days = doc['days'];
// //     String grade = doc['grade'];
// //     if (presentCount >= days) {
// //       return grade;
// //     }
// //   }

// //   return 'F'; // Default grade if no criteria met
// // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Grading System'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: daysController,
//               decoration: InputDecoration(labelText: 'Days Attended'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: gradeController,
//               decoration: InputDecoration(labelText: 'Grade'),
//             ),
//             ElevatedButton(
//               onPressed: addGrade,
//               child: Text('Add Grade'),
//             ),
//             Expanded(
//               child: StreamBuilder(
//                 stream: grades.snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return Center(child: Text('No grades found'));
//                   }

//                   return ListView(
//                     children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//                       return ListTile(
//                         title: Text('Days: ${data['days']} - Grade: ${data['grade']}'),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => deleteGrade(document.id),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// //



// class AdminAttendanceWithGradesScreen extends StatefulWidget {
//   @override
//   _AdminAttendanceWithGradesScreenState createState() => _AdminAttendanceWithGradesScreenState();
// }

// class _AdminAttendanceWithGradesScreenState extends State<AdminAttendanceWithGradesScreen> {
//   final CollectionReference attendance = FirebaseFirestore.instance.collection('Attendance');
//   final CollectionReference grades = FirebaseFirestore.instance.collection('Grades');
//   DateTime? fromDate;
//   DateTime? toDate;

//   List<Map<String, dynamic>> attendanceRecords = [];

//   Future<void> _selectDate(BuildContext context, bool isFromDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != (isFromDate ? fromDate : toDate)) {
//       setState(() {
//         if (isFromDate) {
//           fromDate = picked;
//         } else {
//           toDate = picked;
//         }
//       });
//     }
//   }

//   Future<String> calculateGrade(String email) async {
//     QuerySnapshot attendanceSnapshot = await attendance.where('email', isEqualTo: email).get();
//     int presentCount = attendanceSnapshot.docs.length;

//     QuerySnapshot gradesSnapshot = await grades.orderBy('days', descending: true).get();

//     for (var doc in gradesSnapshot.docs) {
//       int days = doc['days'];
//       String grade = doc['grade'];
//       if (presentCount >= days) {
//         return grade;
//       }
//     }

//     return 'F'; // Default grade if no criteria met
//   }

//   void generateReport() async {
//     if (fromDate == null || toDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select both dates')));
//       return;
//     }

//     QuerySnapshot snapshot = await attendance
//         .where('timestamp', isGreaterThanOrEqualTo: fromDate)
//         .where('timestamp', isLessThanOrEqualTo: toDate)
//         .get();

//     List<Map<String, dynamic>> records = [];

//     for (var doc in snapshot.docs) {
//       Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
//       String grade = await calculateGrade(data['email']);
//       records.add({
//         ...data,
//         'grade': grade,
//       });
//     }

//     setState(() {
//       attendanceRecords = records;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance with Grades'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: ListTile(
//                     title: Text('From: ${fromDate == null ? 'Select Date' : DateFormat.yMd().format(fromDate!)}'),
//                     trailing: Icon(Icons.calendar_today),
//                     onTap: () => _selectDate(context, true),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListTile(
//                     title: Text('To: ${toDate == null ? 'Select Date' : DateFormat.yMd().format(toDate!)}'),
//                     trailing: Icon(Icons.calendar_today),
//                     onTap: () => _selectDate(context, false),
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: generateReport,
//               child: Text('Generate Report'),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: attendanceRecords.length,
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic> data = attendanceRecords[index];
//                   return ListTile(
//                     title: Text('Email: ${data['email']}'),
//                     subtitle: Text('Date: ${data['date']} - Status: ${data['status']} - Grade: ${data['grade']}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class AdminAttendanceWithGradesScreen extends StatefulWidget {
//   const AdminAttendanceWithGradesScreen({super.key});

//   @override
//   _AdminAttendanceWithGradesScreenState createState() => _AdminAttendanceWithGradesScreenState();
// }

// class _AdminAttendanceWithGradesScreenState extends State<AdminAttendanceWithGradesScreen> {
//   final CollectionReference attendance = FirebaseFirestore.instance.collection('Attendance');
//   final CollectionReference grades = FirebaseFirestore.instance.collection('Grades');
//   DateTime? fromDate;
//   DateTime? toDate;

//   List<Map<String, dynamic>> attendanceRecords = [];

//   Future<void> _selectDate(BuildContext context, bool isFromDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != (isFromDate ? fromDate : toDate)) {
//       setState(() {
//         if (isFromDate) {
//           fromDate = picked;
//         } else {
//           toDate = picked;
//         }
//       });
//     }
//   }

//   Future<String> calculateGrade(String email) async {
//     QuerySnapshot attendanceSnapshot = await attendance.where('email', isEqualTo: email).get();
//     int presentCount = attendanceSnapshot.docs.length;

//     QuerySnapshot gradesSnapshot = await grades.orderBy('days', descending: true).get();

//     for (var doc in gradesSnapshot.docs) {
//       int days = doc['days'];
//       String grade = doc['grade'];
//       if (presentCount >= days) {
//         return grade;
//       }
//     }

//     return 'F'; // Default grade if no criteria met
//   }

//   void generateReport() async {
//     if (fromDate == null || toDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select both dates')));
//       return;
//     }

//     QuerySnapshot snapshot = await attendance
//         .where('timestamp', isGreaterThanOrEqualTo: fromDate)
//         .where('timestamp', isLessThanOrEqualTo: toDate)
//         .get();

//     List<Map<String, dynamic>> records = [];

//     for (var doc in snapshot.docs) {
//       Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
//       String grade = await calculateGrade(data['email']);
//       records.add({
//         ...data,
//         'grade': grade,
//       });
//     }

//     setState(() {
//       attendanceRecords = records;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attendance with Grades'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: ListTile(
//                     title: Text('From: ${fromDate == null ? 'Select Date' : DateFormat.yMd().format(fromDate!)}'),
//                     trailing: const Icon(Icons.calendar_today),
//                     onTap: () => _selectDate(context, true),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListTile(
//                     title: Text('To: ${toDate == null ? 'Select Date' : DateFormat.yMd().format(toDate!)}'),
//                     trailing: const Icon(Icons.calendar_today),
//                     onTap: () => _selectDate(context, false),
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: generateReport,
//               child: const Text('Generate Report'),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: attendanceRecords.length,
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic> data = attendanceRecords[index];
//                   return ListTile(
//                     title: Text('Email: ${data['email']}'),
//                     subtitle: Text('Date: ${data['date']} - Status: ${data['status']} - Grade: ${data['grade']}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:attendance_system/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/grade_service.dart';


class AdminScreen2 extends StatefulWidget {
  const AdminScreen2({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen2> {
  final GradeService gradeService = GradeService();
  String userGrade = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchGrade();
  }

  Future<void> fetchGrade() async {
    String grade = await gradeService.calculateGrade(userInfo.email??""); // Replace with dynamic email
    setState(() {
      userGrade = grade;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Screen'),
      ),
      body: Center(
        child: Text('User Grade: $userGrade'),
      ),
    );
  }
}



class GradeConfigurationScreen extends StatefulWidget {
  const GradeConfigurationScreen({super.key});

  @override
  _GradeConfigurationScreenState createState() => _GradeConfigurationScreenState();
}

class _GradeConfigurationScreenState extends State<GradeConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  int? days;
  String? grade;
  String? name;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('Grades').add({
        'days': days,
        'grade': grade,
        'name':  name,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Grade criteria added')));
    }
  }

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
    String name=doc['name'];
    if (presentCount >= days) {
      return grade;
    }
  }

  return 'F'; // Default grade if no criteria met
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 242, 237),
      appBar: AppBar(
        title: const Text('Grade Configuration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Days'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter days' : null,
                onSaved: (value) => days = int.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Grade'),
                validator: (value) => value!.isEmpty ? 'Enter grade' : null,
                onSaved: (value) => grade = value,
              ),
               TextFormField(
                decoration: const InputDecoration(labelText: 'name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
                onSaved: (value) => name = value,
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Grade Criteria'),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Grades').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const CircularProgressIndicator();

                    final grades = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: grades.length,
                      itemBuilder: (context, index) {
                        final gradeData = grades[index];
                        return ListTile(
                          title: Text('Days: ${gradeData['days']}'),
                          subtitle: Text('Grade: ${gradeData['grade']}'),
                          trailing:  Text('name: ${gradeData['name']} ',style: const TextStyle(fontSize: 20,color: Colors.blue,),
                        ));
                      },
                    );
                  },
                ),
              ),
             // ElevatedButton(onPressed: (){calculateGrade(email)}, child: child)
            ],
          ),
        ),
      ),
    );
  }
}
