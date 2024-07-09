import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAttendanceScreen extends StatelessWidget {
  final CollectionReference attendance = FirebaseFirestore.instance.collection('Attendance');

  AdminAttendanceScreen({super.key});

  void deleteAttendance(String docId) async {
    await attendance.doc(docId).delete();
  }

  void addAttendance(BuildContext context) async {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Attendance'),
          content: Column(
            children: [
               

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await attendance.add({
                  'email': emailController.text,
                  'date': dateController.text,
                  'timestamp': FieldValue.serverTimestamp(),
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void editAttendance(BuildContext context, DocumentSnapshot doc) async {
    final TextEditingController emailController = TextEditingController(text: doc['email']);
    final TextEditingController dateController = TextEditingController(text: doc['date']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Attendance'),
          content: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await attendance.doc(doc.id).update({
                  'email': emailController.text,
                  'date': dateController.text,
                });
                Navigator.pop(context);
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 214, 241, 238),
      appBar: AppBar(
        title: const Text('Admin: Manage Attendance',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => addAttendance(context),
          ),
        ],
      ),
      body: Column(
        children: [
            Image.asset('assests/images/attendence.gif',fit: BoxFit.cover,height: 100,width: 100),

          Expanded(
            child: StreamBuilder(
              stream: attendance.snapshots(),
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
                      title: Text('Email: ${data['email']}'),
                      subtitle: Text('Date: ${data['date']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => editAttendance(context, document),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteAttendance(document.id),
                          ),
                        ],
                      ),
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
