// import 'package:flutter/material.dart';
// import '../../models/leave.dart';


// class LeaveDataEntryScreen extends StatefulWidget {
//   const LeaveDataEntryScreen({super.key});

//   @override
//   _LeaveDataEntryScreenState createState() => _LeaveDataEntryScreenState();
// }

// class _LeaveDataEntryScreenState extends State<LeaveDataEntryScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _reasonController = TextEditingController();
//   DateTime? _startDate;
//   DateTime? _endDate;

//   void _addLeaveRequest() {
//     if (_startDate != null &&
//         _endDate != null &&
//         _nameController.text.isNotEmpty &&
//         _emailController.text.isNotEmpty &&
//         _reasonController.text.isNotEmpty) {
//       Leave newLeave = Leave(
//         name: _nameController.text,
//         email: _emailController.text,
//         reason: _reasonController.text,
//         startDate: _startDate!,
//         endDate: _endDate!,
//       );

//       Navigator.pushNamed(context, '/approval', arguments: newLeave);
//       _nameController.clear();
//       _emailController.clear();
//       _reasonController.clear();
//       _startDate = null;
//       _endDate = null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Leave Data Entry'),
       
//       ),
       
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _reasonController,
//               decoration: const InputDecoration(labelText: 'Reason'),
//             ),
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () async {
//                     DateTime? picked = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (picked != null) {
//                       setState(() {
//                         _startDate = picked;
//                       });
//                     }
//                   },
//                   child: const Text('Select Start Date'),
//                 ),
//                 if (_startDate != null)
//                   Text('Selected: ${_startDate!.toLocal()}'.split(' ')[0]),
//               ],
//             ),
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () async {
//                     DateTime? picked = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (picked != null) {
//                       setState(() {
//                         _endDate = picked;
//                       });
//                     }
//                   },
//                   child: const Text('Select End Date'),
//                 ),
//                 if (_endDate != null)
//                   Text('Selected: ${_endDate!.toLocal()}'.split(' ')[0]),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: _addLeaveRequest,
//               child: const Text('Add Leave Request'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:attendance_system/models/leave.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? reason;
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && startDate != null && endDate != null) {
      _formKey.currentState!.save();

      final leaveRequest = Leave(
        id: DateTime.now().toString(),
        name: name!,
        email: email!,
        reason: reason!,
        startDate: startDate!,
        endDate: endDate!,
      );

      await FirebaseFirestore.instance.collection('LeaveRequests').add(leaveRequest.toMap());

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Leave request submitted')));

      setState(() {
        name = null;
        email = null;
        reason = null;
        startDate = null;
        endDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Leave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                onSaved: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reason'),
                validator: (value) => value!.isEmpty ? 'Enter reason for leave' : null,
                onSaved: (value) => reason = value,
              ),
              ListTile(
                title: Text('Start Date: ${startDate == null ? 'Select Date' : DateFormat.yMd().format(startDate!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, true),
              ),
              ListTile(
                title: Text('End Date: ${endDate == null ? 'Select Date' : DateFormat.yMd().format(endDate!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, false),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Leave Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
