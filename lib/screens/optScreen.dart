import 'package:attendance_system/screens/adminPanel/adminScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attendance_system/models/userModel.dart';

class OptScreen extends StatefulWidget {
   const OptScreen({super.key});

  @override
  State<OptScreen> createState() => _OptScreenState();
}

class _OptScreenState extends State<OptScreen> {
    late String password;
    late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
  
      var screenSize = MediaQuery.of(context).size;
     var width = screenSize.width;
    var height = screenSize.height;
     Color color = const Color.fromARGB(255, 40, 143, 134);
    return Scaffold(
      body: Column(
        children: [
          Image(
                  image: const AssetImage('assests/images/nVehicle_logo.png'),
                  height: height / 4,
                  width: 0.75 * width,
                ),
                  SizedBox(height: height / 25),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: width / 14),
                      child: const Text(
                        'Admin Verification',
                        style: TextStyle(
                          fontSize: 20.00,
                          color: Color.fromARGB(255, 43, 193, 178) ,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                // Login Text Field
                Container(
                  padding: EdgeInsets.all(width / 20),
                  child: TextField(
                     onChanged: (value) {
                      password = value;
                    },
                    
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    cursorColor: color,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon:  Icon(Icons.pin, color: color,),
                      hintText: 'Enter your Faculty pin',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: color,)),
                      focusedBorder:  OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2, color:color,)),
                    ),
                  ),
                ),
                 Container(
                  padding: EdgeInsets.fromLTRB(
                      width / 20, height / 30, width / 20, height / 50),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 43, 193, 178),
                        borderRadius: BorderRadius.all(
                          Radius.circular(45.0),
                        )),
                    child: MaterialButton(
                      
                        elevation: 10.00,
                        minWidth: width / 1.2,
                        height: height / 11.5,
                        child: const Text(
                          'Verify Now',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.00),
   ),
                        onPressed: () async {
  setState(() {
    userInfo.password = password;
  });
  if ( password.isNotEmpty) {
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('pin must contain 6 letters'),
        ),
      );
    }  else {
      try {
         ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('verification was successful')));
        // Attempt to sign in with email and password
        // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: email,
        //   password: password,
        // );

        // If sign-in is successful, save email to SharedPreferences
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("attendendce", password);



        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminScreen()
           
          ),
        );
      
      // } on FirebaseAuthException catch (e) {
      //   // Handle specific authentication exceptions
      //   if (e.code == 'user-not-found') {
      //     print('No user found for that email.');
      //   } else if (e.code == 'wrong-password') {
      //     print('Wrong password provided for that user.');
      //   }
        // Show relevant error message to the user
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Authentication failed: ${e.message}'),
        //   ),
        // );
      } catch (e) {
        // Catch any other exceptions
        print(e.toString());

        // Show generic error message to the user

        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Authentication failed. Please try again later.'),
        //   ),
        // );
      }
    }
  } else {
    // Show error message if email or password is empty
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in pin.'),
      ),
    );
  }
}

                    ))),  
          
        ],
      ),
    );
  }
}