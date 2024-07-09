import 'package:attendance_system/screens/extra/attendance.dart';
import 'package:attendance_system/screens/loginScreen.dart';
import 'package:attendance_system/screens/studentPanel/routes.dart';
import 'package:flutter/material.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Center(child: Text('Welcome To Student Portal')),

      ),
      body:  Column(
        children: [
          const SizedBox(height: 10,),

          Image.asset('assests/images/attendence.gif',fit: BoxFit.cover,height: 100,width: 100),
           const SizedBox(height: 10,),
          Center(
            child: Container(
              height: 100,
              width: 350,
              padding: const EdgeInsets.all(12),
              child: DecoratedBox(
                
                decoration: const BoxDecoration(
                          
                          borderRadius: BorderRadius.all(
                            Radius.circular(45.0),
                          )),
                child: ElevatedButton(
                 style:ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 43, 193, 178),
                 ),
                  onPressed: (){
                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>   AttendanceMarkingScreen())
                                    );
                }, child: const Text('Mark Attendence',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.white),)),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Center(
            child: Container(
              height: 100,
              width: 350,
              padding: const EdgeInsets.all(12),
              child: DecoratedBox(
                
                decoration: const BoxDecoration(
                          
                          borderRadius: BorderRadius.all(
                            Radius.circular(45.0),
                          )),
                child: ElevatedButton(
                 style:ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 43, 193, 178),
                 ),
                  onPressed: (){
                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  const MyApplication())
                                    );
                }, child: const Text('leave submition',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.white),)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 100,
              width: 350,
              padding: const EdgeInsets.all(12),
              child: DecoratedBox(
                
                decoration: const BoxDecoration(
                          
                          borderRadius: BorderRadius.all(
                            Radius.circular(45.0),
                          )),
                child: ElevatedButton(
                 style:ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 43, 193, 178),
                 ),
                  onPressed: (){
                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  const LoginScreen())
                                    );
                }, child: const Text('Back to login',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.white),)),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}



// class BottomNavigationBarExample extends StatefulWidget {
//   const BottomNavigationBarExample({super.key});

//   @override
//   State<BottomNavigationBarExample> createState() =>
//       _BottomNavigationBarExampleState();
// }

// class _BottomNavigationBarExampleState
//     extends State<BottomNavigationBarExample> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static  List<Widget> _widgetOptions = <Widget>[
//    // UserPanel(),
//    // StudentPanel(),
      
//     Text(
//       'Index 2: School',
//       style: optionStyle,
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BottomNavigationBar Sample'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Business',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'School',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }