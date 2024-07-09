
//import 'user_screen.dart';
import 'package:attendance_system/models/userModel.dart';
import 'package:attendance_system/screens/studentPanel/homeScreen.dart';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

late User loggedinUser;

class _WelcomeScreenState extends State<WelcomeScreen> {
 

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  
  }

  

  TextEditingController name = TextEditingController();
  TextEditingController rollnumber = TextEditingController();
  // TextEditingController friendName = TextEditingController();
  // TextEditingController friendContact = TextEditingController();
  // TextEditingController friendPhone = TextEditingController();
  // TextEditingController specialist = TextEditingController();
  // TextEditingController specialistContact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill Your Basic Information'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [ Color.fromARGB(255, 40, 143, 134), Color.fromARGB(255, 43, 193, 178),])),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height / 20),
              Image(
                image: const AssetImage('assests/images/nVehicle_logo.png'),
                height: height / 4,
                width: 0.75 * width,
              ),
              TextFieldComponent(
                width: width,
                controller: name,
                hintText: "Enter your name",
                FieldName: "Name",
                type: TextInputType.text,
                necessaryField: true,
              ),
              TextFieldComponent(
                width: width,
                controller: rollnumber,
                hintText: "Enter your roll number",
                FieldName: "Roll number",
                type: TextInputType.number,
                necessaryField: true,
              ),
             
              
              SizedBox(height: height / 20),
              
              
             
              Container(
                padding: EdgeInsets.fromLTRB(
                    width / 15, height / 30, width / 15, height / 20),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 40, 143, 134),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: MaterialButton(
                      elevation: 10.00,
                      minWidth: width / 1.2,
                      height: height / 11.5,
                      onPressed: () async {
                        if (name.text.isEmpty ||
                            rollnumber.text.isEmpty 
                           ) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content:
                                  Text("Fill all the * necessary fields")));
                        }  else {
                          db
                              .collection("Users")
                              .doc("${userInfo.email}")
                              .set(
                            {
                              'name': name.text,
                              'rollnumber': rollnumber.text,
                              // 'friend': friendName.text,
                              // 'friendContact': friendContact.text,
                              // 'friendPhone': friendPhone.text,
                              // 'specialist': specialist.text.isEmpty
                              //     ? "null"
                              //     : specialist.text,
                              // 'specialistContact':
                              //     specialistContact.text.isEmpty
                              //         ? "null"
                              //         : specialistContact.text
                            },
                          );

                          userInfo.name = name.text;
                          userInfo.rollnumber = rollnumber.text;
                          // patientInfo.friendContact = friendContact.text;
                          // patientInfo.specialistName = specialist.text;
                          // patientInfo.specialistContact =
                          //     specialistContact.text;
                          // patientInfo.phoneNo = friendPhone.text;

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Data submitted")));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Homescreen()));
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20.00),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {super.key,
      required this.width,
      required this.controller,
      required this.hintText,
      required this.FieldName,
      required this.type,
      required this.necessaryField});

  final double width;
  final TextEditingController controller;
  final String hintText;
  final String FieldName;
  final TextInputType type;
  final bool necessaryField;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  FieldName,
                  style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 43, 193, 178) ),
                ),
                const SizedBox(width: 5),
                necessaryField
                    ? const Text('*',
                        style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 46, 203, 151)))
                    : const SizedBox()
              ],
            ),
            TextField(
              keyboardType: type,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 43, 193, 178),
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color:Color.fromARGB(255, 40, 143, 134),
                    width: 2.0,
                  ),
                ),
              ),
              autofocus: true,
              style: const TextStyle(fontSize: 15, color: Colors.black),
              cursorColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}