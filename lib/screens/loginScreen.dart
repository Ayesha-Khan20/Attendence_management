import 'package:attendance_system/models/userModel.dart';
import 'package:attendance_system/screens/optScreen.dart';
import 'package:attendance_system/screens/registerScreen.dart';
import 'package:attendance_system/screens/studentPanel/welcome.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  Color color = const Color.fromARGB(255, 40, 143, 134);

  bool isChecked = false;

  void navigate() {
    if (isChecked) {
       Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  const OptScreen())
                              );
    } else {
       Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen())
                              );
    }
  }

    void updateCheckbox(bool value) {
    setState(() {
      isChecked = value;
    });
  }

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 236, 241),
    // backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          title: const Text('Hope',style: TextStyle(color:  Colors.white),),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 43, 193, 178),
          //backgroundColor: Color.fromARGB(255, 62, 59, 59),
        ),
        body: Container(
          padding: EdgeInsets.all(width / 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
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
                        'User Login',
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
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: color,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon:  Icon(Icons.perm_identity, color: color,),
                      hintText: 'Enter your Email',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: color,)),
                      focusedBorder:  OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2, color:color,)),
                    ),
                  ),
                ),

                // Password Text Field
                Container(
                  padding: EdgeInsets.fromLTRB(
                      width / 20, 0, width / 20, width / 20),
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
                      prefixIcon: Icon(Icons.password, color: color),
                      hintText: 'Enter your Password',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: color)),
                      focusedBorder:  OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2, color: color,)),
                    ),
                  ),
                ),
                 Container(
                          padding: EdgeInsets.fromLTRB(
                      width / 20, height / 40, width / 40, height / 70),
                        child: Row( 
                                        children: [
                                          const Text('Are You Admin?not student',style: TextStyle(color: Colors.black),),
                                          const SizedBox(width: 4,),
                                          CheckboxExample(onChanged: (bool value) => updateCheckbox(value)),
                                             ],
                               ),
                      ),

                // Login Button
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
                          'Login',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.00),
   ),
                        onPressed: () async {
  setState(() {
    userInfo.email = email;
  });
  if (email.isNotEmpty && password.isNotEmpty) {
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must contain 6 letters'),
        ),
      );
    } else if (!EmailValidator.validate(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email is not valid'),
        ),
      );
    } else {
      try {
        // Attempt to sign in with email and password
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // If sign-in is successful, save email to SharedPreferences
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("Hope", email);



        // Navigate to the WelcomeScreen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
            
        //     }
           
        //   ),
        // );
        navigate();
      } on FirebaseAuthException catch (e) {
        // Handle specific authentication exceptions
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
        // Show relevant error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication failed: ${e.message}'),
          ),
        );
      } catch (e) {
        // Catch any other exceptions
        print(e.toString());
        // Show generic error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Authentication failed. Please try again later.'),
          ),
        );
      }
    }
  } else {
    // Show error message if email or password is empty
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in both email and password.'),
      ),
    );
  }
}

                    ))),   
  
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp())
                              );
                        },
                        child: Text(
                          'Sign Up',
                          textScaler: const TextScaler.linear(1),
                          style: TextStyle(fontSize: 17, color: color),
                        ))
                  ],
                ),
                    ],
                    )
            )),
            );
          
  }
}

class CheckboxExample extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  const CheckboxExample({super.key, required this.onChanged});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}
class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.black,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
         widget.onChanged(isChecked);
      },
    );
  }
}