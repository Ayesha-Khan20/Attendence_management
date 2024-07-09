import 'package:attendance_system/screens/adminPanel/admin_markingscreen.dart';
import 'package:attendance_system/screens/adminPanel/counts.dart';
import 'package:attendance_system/screens/adminPanel/grading_report.dart';
import 'package:attendance_system/screens/adminPanel/report1.dart';
//import 'package:attendance_system/screens/adminPanel/report1.dart' ;
import 'package:attendance_system/screens/adminPanel/view_login.dart';
// ignore: unused_import
import 'package:attendance_system/screens/extra/leave.dart';
import 'package:flutter/material.dart';


class AdminScreen extends StatefulWidget {
 const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
   final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _reasonController = TextEditingController();

  DateTime? _startDate;

  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
     var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 100,),
           Image(
                    image: const AssetImage('assests/images/nVehicle_logo.png'),
                    height: height / 4,
                    width: 0.75 * width,
                  ),
                  const SizedBox(height: 50,),
        
                  const Text('Welcome Admin Panel',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),),
         const SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
        height: height,
        width: width,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>   LoginStudentsScreen())
                              );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Center(child: Text("logins")),
              ),
            ),
            GestureDetector(
              onTap:()=> { Navigator.push(
                                context,
                                MaterialPageRoute(
                                                            builder: (context) => ( AdminAttendanceScreen()))
             ) },
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[200],
                child: const Center(child: Text('Attendance')),
              ),
            ),
            GestureDetector(
              onTap: (){
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                                            builder: (context) => (  const GradeConfigurationScreen())));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[300],
                child: const Center(child: Text('grading')),
              ),
            ),
            // GestureDetector(
            //   onTap: (){
            //     Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                                                 builder: (context) => (  const ReportScreen())));
             
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.all(8),
            //     color: Colors.teal[400],
            //     child: const Center(child: Text('Report of abesents')),
            //   ),
            // ),
            
          ],
        ),
            ),
          ],
        ),
        ElevatedButton(onPressed: (){
          // Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                                                   builder: (context) => ( LeaveApprovalScreen2()))
          //    ) ;
          
         

      // Navigator.pushNamed(context, LeaveApprovalScreen3() as String , arguments: newLeave);
       Navigator.push(
                                context,
                                MaterialPageRoute(
                                                            builder: (context) => (const AdminLeaveApprovalScreen()))
             ) ;
     

        }, child: const Text('leave approval')),
        //SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          Navigator.push(
                                context,
                                MaterialPageRoute(
                                                            builder: (context) => ( AttendanceCountsScreen()))
             ) ;
        }, child: const Text('counts'))
            ],
           
            ),
      )
    );
  
}
}
