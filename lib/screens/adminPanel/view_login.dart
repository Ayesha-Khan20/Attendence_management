import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginStudentsScreen extends StatelessWidget {
  final CollectionReference students = FirebaseFirestore.instance.collection('Users');

   LoginStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 241, 238),
      appBar: AppBar(
        title: const Text('Logged-In Students',style: TextStyle(color: Colors.blue),),
      ),
      body: StreamBuilder(
        stream: students.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No students found'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: 
                 Text('Name: ${data['name']}'),
                subtitle: Text('Roll number: ${data['rollnumber']}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
