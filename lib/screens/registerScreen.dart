
import 'package:attendance_system/screens/loginScreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email;
  late String password;
  TextEditingController e = TextEditingController();
  TextEditingController p = TextEditingController();
  Color color = const Color.fromARGB(255, 43, 193, 178);
   final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromARGB(255, 43, 193, 178)));
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
        appBar: AppBar(
          
         elevation: 0,
        backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: const BoxDecoration(color:  Color.fromARGB(255, 205, 236, 241),),
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
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20.00,
                          color: color,
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
                    controller: e,
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: color,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: Icon(Icons.perm_identity, color: color),
                      hintText: 'Enter your Email',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2, color: color)),
                    ),
                  ),
                ),

                // Password Text Field
                Container(
                  padding: EdgeInsets.fromLTRB(
                      width / 20, 0, width / 20, width / 20),
                  child: TextField(
                    controller: p,
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
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2, color: color)),
                    ),
                  ),
                ),

                // Login Button
               // SizedBox(height: 2,),

                      Container(
                          padding: EdgeInsets.fromLTRB(
                      width / 20, height / 40, width / 40, height / 70),
                        child: const Row(
                                        children: [
                                          Text('Are You Admin?',style: TextStyle(color: Colors.black),),
                                          SizedBox(width: 4,),
                                          CheckboxExample(),
                                             ],
                               ),
                      ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      width / 20, height / 30, width / 20, height / 50),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color:  Color.fromARGB(255, 43, 193, 178),
                        borderRadius: BorderRadius.all(
                          Radius.circular(45.0),
                        )),
                    child: MaterialButton(
                        elevation: 10.00,
                        minWidth: width / 1.2,
                        height: height / 11.5,
                        onPressed: () async {
                          if (password.isNotEmpty && email.isNotEmpty) {
                            if (password.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Password must contain 6 letters')));
                            } else if (!EmailValidator.validate(email)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Email is not valid')));
                            } else {
                              final user =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              e.clear();
                              p.clear();
                              UserCredential? userCredential;



                              try {
                              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                       );
                                    } on FirebaseAuthException catch (e) {
                                     if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                    } else if (e.code == 'email-already-in-use') {
                                        print('The account already exists for that email.');
                                        }
                                     } catch (e) {
                                            print(e);
                                           }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Signing up was successful')));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  
                                      const Loading()
                                      ));
                            }
                          } else if (password.isEmpty || email.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Fill both the values')));
                          }
                          print('account created');
                        },
                        child: const Text(
                          'Sign Up',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.00),
                        )),
                  ),
                ),
               // const SizedBox(height: 79,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
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
                                  builder: (context) => const LoginScreen())
                              );
                        },
                        child: Text(
                          'Login',
                          textScaler: const TextScaler.linear(1),
                          style: TextStyle(fontSize: 17, color: color),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  callme() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    callme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(color:  Color.fromARGB(255, 43, 193, 178),),
        ),
      ),
    );
  }
}
class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

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
      },
    );
  }
}
