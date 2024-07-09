import 'package:attendance_system/screens/extra/leave.dart';
import 'package:attendance_system/screens/studentPanel/leaveScreen.dart';
import 'package:flutter/material.dart';



class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leave Management System',
      initialRoute: '/',
      routes: {
        '/': (context) =>  const LeaveRequestScreen(),
        '/approval': (context) => const LeaveApprovalScreen2(),
      },
    );
  }
}
