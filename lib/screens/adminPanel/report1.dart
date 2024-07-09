import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// class AdminAttendanceReportScreen extends StatefulWidget {
//   const AdminAttendanceReportScreen({super.key});

//   @override
//   _AdminAttendanceReportScreenState createState() => _AdminAttendanceReportScreenState();
// }

// class _AdminAttendanceReportScreenState extends State<AdminAttendanceReportScreen> {
//   final CollectionReference attendance = FirebaseFirestore.instance.collection('Attendance');
//   final TextEditingController emailController = TextEditingController();
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
//     if (emailController.text.isEmpty || fromDate == null || toDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return ;


//     }

//     QuerySnapshot snapshot = await attendance
//         .where('email', isEqualTo: emailController.text)
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
//         title: const Text('Generate Attendance Report'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'User Email'),
//             ),
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
//                   Map<String, dynamic> data = attendanceRecords[index].data()! as Map<String, dynamic>;
//                   return ListTile(
//                     title: Text('Date: ${data['date']}'),
//                     subtitle: const Text('Status: Present'),
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

// class ReportScreen extends StatefulWidget {
//   @override
//   _ReportScreenState createState() => _ReportScreenState();
// }

// class _ReportScreenState extends State<ReportScreen> {
//   DateTime? fromDate;
//   DateTime? toDate;
//   List<Map<String, dynamic>> attendances = [];

//   Future<void> _selectDate(BuildContext context, bool isFromDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isFromDate) {
//           fromDate = picked;
//         } else {
//           toDate = picked;
//         }
//       });
//     }
//   }

//   Future<void> _generateReport() async {
//     if (fromDate != null && toDate != null) {
//       final QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('Attendance')
//           .where('date', isGreaterThanOrEqualTo: fromDate)
//           .where('date', isLessThanOrEqualTo: toDate)
//           .get();

//       setState(() {
//         attendances = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance Report'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ListTile(
//               title: Text('From Date: ${fromDate == null ? 'Select Date' : DateFormat.yMd().format(fromDate!)}'),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () => _selectDate(context, true),
//             ),
//             ListTile(
//               title: Text('To Date: ${toDate == null ? 'Select Date' : DateFormat.yMd().format(toDate!)}'),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () => _selectDate(context, false),
//             ),
//             ElevatedButton(
//               onPressed: _generateReport,
//               child: Text('Generate Report'),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: attendances.length,
//                 itemBuilder: (context, index) {
//                   final attendance = attendances[index];
//                   return ListTile(
//                     title: Text('Email: ${attendance['email']}'),
//                     subtitle: Text('Date: ${DateFormat.yMd().format((attendance['date'] as Timestamp).toDate())} - Status: ${attendance['status']}'),
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


import '../../models/grade_service.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime? fromDate;
  DateTime? toDate;
  List<Map<String, dynamic>> attendances = [];
  final GradeService gradeService = GradeService();

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Future<void> _generateReport() async {
    if (fromDate != null && toDate != null) {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Attendance')
          .where('date', isGreaterThanOrEqualTo: fromDate)
          .where('date', isLessThanOrEqualTo: toDate)
          .get();

      List<Map<String, dynamic>> attendanceData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      
      for (var data in attendanceData) {
        String grade = await gradeService.calculateGrade(data['email']);
        data['grade'] = grade;
      }

      setState(() {
        attendances = attendanceData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('From Date: ${fromDate == null ? 'Select Date' : DateFormat.yMd().format(fromDate!)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, true),
            ),
            ListTile(
              title: Text('To Date: ${toDate == null ? 'Select Date' : DateFormat.yMd().format(toDate!)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, false),
            ),
            ElevatedButton(
              onPressed: _generateReport,
              child: const Text('Generate Report'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: attendances.length,
                itemBuilder: (context, index) {
                  final attendance = attendances[index];
                  return ListTile(
                    title: Text('Email: ${attendance['email']}'),
                    subtitle: Text('Date: ${DateFormat.yMd().format((attendance['date'] as Timestamp).toDate())} - Status: ${attendance['status']}'),
                    trailing: Text('Grade: ${attendance['grade']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//leave approval module



// class LeaveApprovalScreen extends StatelessWidget {
//   final CollectionReference leaves = FirebaseFirestore.instance.collection('Leaves');

//    LeaveApprovalScreen({super.key});

//   void approveLeave(DocumentSnapshot doc) async {
//     await leaves.doc(doc.id).update({'isApproved': true});
//   }

//   void rejectLeave(DocumentSnapshot doc) async {
//     await leaves.doc(doc.id).update({'isApproved': false});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Leave Approvals'),
//       ),
//       body: StreamBuilder(
//         stream: leaves.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No leave requests found'));
//           }

//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//               return ListTile(
//                 title: Text('Email: ${data['email']}'),
//                 subtitle: Text('Reason: ${data['reason']}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.check, color: Colors.green),
//                       onPressed: () => approveLeave(document),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.red),
//                       onPressed: () => rejectLeave(document),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }



// class LeaveApprovalScreen3 extends StatefulWidget {
//   const LeaveApprovalScreen3({super.key});

//   @override
//   _LeaveApprovalScreenState createState() => _LeaveApprovalScreenState();
// }

// class _LeaveApprovalScreenState extends State<LeaveApprovalScreen3> {
//   final List<Leave> leaveRequests = [];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final Leave? newLeaveRequest =
//         ModalRoute.of(context)!.settings.arguments as Leave?;
//     if (newLeaveRequest != null) {
//       setState(() {
//         leaveRequests.add(newLeaveRequest);
//       });
//     }
//   }

//   void approveLeave(Leave leave) {
//     setState(() {
//       leave.isApproved = true;
//     });
//   }

//   void rejectLeave(Leave leave) {
//     setState(() {
//       leave.isApproved = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Leave Approval'),
//       ),
//       body: ListView.builder(
//         itemCount: leaveRequests.length,
//         itemBuilder: (context, index) {
//           Leave leave = leaveRequests[index];

//           return ListTile(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                     'Name: ${leave.name} - ${leave.startDate.toLocal()} to ${leave.endDate.toLocal()}'),
//                 Text('Email: ${leave.email}'),
//                 Text('Reason: ${leave.reason}'),
//               ],
//             ),
//             subtitle: Text('Status: ${leave.isApproved ? 'Approved' : 'Pending'}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.check, color: Colors.green),
//                   onPressed: () => approveLeave(leave),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close, color: Colors.red),
//                   onPressed: () => rejectLeave(leave),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



class AdminLeaveApprovalScreen extends StatefulWidget {
  const AdminLeaveApprovalScreen({super.key});

  @override
  _AdminLeaveApprovalScreenState createState() => _AdminLeaveApprovalScreenState();
}

class _AdminLeaveApprovalScreenState extends State<AdminLeaveApprovalScreen> {
  Future<void> _approveLeave(String id) async {
    await FirebaseFirestore.instance.collection('LeaveRequests').doc(id).update({'isApproved': true});
  }

  Future<void> _rejectLeave(String id) async {
    await FirebaseFirestore.instance.collection('LeaveRequests').doc(id).update({'isApproved': false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 247, 243),
      appBar: AppBar(
        title: const Text('Approve Leave Requests',style: TextStyle(color: Color.fromARGB(255, 43, 193, 178),fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
            Image.asset('assests/images/attendence.gif',fit: BoxFit.cover,height: 100,width: 100),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('LeaveRequests').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
            
                final leaveRequests = snapshot.data?.docs ?? [];
            
                return ListView.builder(
                  itemCount: leaveRequests.length,
                  itemBuilder: (context, index) {
                    final leaveRequest = leaveRequests[index];
                    final leaveData = leaveRequest.data() as Map<String, dynamic>;
            
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${leaveData['name']}'),
                          Text('Email: ${leaveData['email']}'),
                          Text('Reason: ${leaveData['reason']}'),
                          Text('Start Date: ${DateFormat.yMd().format((leaveData['startDate'] as Timestamp).toDate())}'),
                          Text('End Date: ${DateFormat.yMd().format((leaveData['endDate'] as Timestamp).toDate())}'),
                        ],
                      ),
                      subtitle: Text('Status: ${leaveData['isApproved'] ? 'Approved' : 'Pending'}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () => _approveLeave(leaveRequest.id),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _rejectLeave(leaveRequest.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
