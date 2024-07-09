// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(const AttendanceApp());
// }

// class AttendanceApp extends StatelessWidget {
//   const AttendanceApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Attendance Marking',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const AttendanceScreen(),
//     );
//   }
// }

// class AttendanceScreen extends StatefulWidget {
//   const AttendanceScreen({super.key});

//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _studentCodeController = TextEditingController();
//   final List<Map<String, String>> _attendanceList = [];

//   void _markAttendance() {
//     if (_formKey.currentState!.validate()) {
//       String studentCode = _studentCodeController.text;
//       String currentDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

//       setState(() {
//         _attendanceList.add({
//           'studentCode': studentCode,
//           'date': currentDate,
//         });
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Attendance marked for student code: $studentCode')),
//       );

//       _studentCodeController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attendance App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   TextFormField(
//                     controller: _studentCodeController,
//                     decoration: const InputDecoration(
//                       labelText: 'Enter Student Code',
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a student code';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _markAttendance,
//                     child: const Text('Mark Attendance'),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _attendanceList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('Student Code present: ${_attendanceList[index]['studentCode']}'),
//                     subtitle: Text('Date: ${_attendanceList[index]['date']}'),
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


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceMarkingScreen extends StatelessWidget {
  final CollectionReference attendance = FirebaseFirestore.instance.collection('Attendance');

  AttendanceMarkingScreen({super.key});

  void markAttendance(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    Navigator.push(
                              context,
                              MaterialPageRoute(
                                                          builder: (context) => (AttendanceViewingScreen()))
           );

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You need to log in first')));
      return;
    }

    String email = user.email!;
    DateTime now = DateTime.now();
    String date = '${now.year}-${now.month}-${now.day}';

    DocumentReference docRef = attendance.doc('$email-$date');

    DocumentSnapshot docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You have already marked your attendance for today')));
    } else {
      await docRef.set({
        'email': email,
        'date': date,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attendance marked successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
      ),

      body:  Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
         
          children: [
            Image.asset('assests/images/attendence.gif',fit: BoxFit.cover,height: 180,width: 180),

             Center(
            child: ElevatedButton(
              onPressed: () => markAttendance(context),
              child: const Text('Mark Attendance'),
            ),
          ),
            const SizedBox(
              height: 10,
            ),
            Center(child: const Text('Mark Atendence by taping once',style: TextStyle(color: Colors.blue,fontSize: 20),))
          ],
        ),
      ),
      // body: Column(
      //   children: [



      //     Center(
      //       child: ElevatedButton(
      //         onPressed: () => markAttendance(context),
      //         child: const Text('Mark Attendance'),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
// view screen 



class AttendanceViewingScreen extends StatelessWidget {
  final CollectionReference attendance = FirebaseFirestore.instance.collection('Attendance');

  AttendanceViewingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('View Attendance'),
        ),
        body: const Center(
          child: Text('You need to log in first'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Attendance'),
      ),
      body: Column(
        children: [
            const SizedBox(height: 10,),

          Image.asset('assests/images/attendence.gif',fit: BoxFit.cover,height: 100,width: 100),
          const SizedBox(height: 20,),
          SizedBox(
            height: 200,
            width: 200,
            child: StreamBuilder(
              stream: attendance.where('email', isEqualTo: user.email).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No attendance records found'));
                }
            
                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text('Date: ${data['date']}'),
                      subtitle: Text('Time: ${data['timestamp'].toDate()}'),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
