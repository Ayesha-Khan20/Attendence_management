import 'package:attendance_system/screens/loginScreen.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amber,
      body: GestureDetector
      
      (
        onTap: (){
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
        },
        child: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
           
            children: [
              Image.asset('assests/images/attendence.gif',fit: BoxFit.cover,height: 180,width: 180),
              // SizedBox(
              //   height: 12,
              // ),
              const Text('Attendence system',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900,fontSize: 28),)
            ],
          ),
        ),
      ),
    );
  }
}