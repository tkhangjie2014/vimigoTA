import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vimigota/homepage.dart';
import 'package:vimigota/main.dart';
import 'package:vimigota/user_attendance.dart';

class AddAttendance extends StatefulWidget {

  @override
  State<AddAttendance> createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  //final TextEditingController checkInController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Add Attendance'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMyField(
                focusNode: focusNode,
                hintText: 'Name',
                textInputType: TextInputType.name,
                controller: userController),
            getMyField(
                hintText: 'Phone Number',
                textInputType: TextInputType.number,
                controller: phoneController),


                Row(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Attendance attendance = Attendance(
                            user: userController.text,
                            phone: num.parse(phoneController.text),
                            checkIn: DateTime.now(),
                        );
                        addAttendanceAndNavigateHome(attendance, context);

                      },
                      child: const Text('Add')),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: (){
                        userController.text = '';
                        phoneController.text = '';
                        focusNode.requestFocus();
                      },
                      child: const Text('Reset')),
                  ],
                )
          ],
        ),
      ),
    );
  }

  Widget getMyField(
      {required String hintText,
        TextInputType textInputType = TextInputType.name,
        required TextEditingController controller,
        FocusNode? focusNode} ){
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: 'Enter $hintText',
            labelText: hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
            )
          ),
        ),
      );
    }

  void addAttendanceAndNavigateHome(Attendance attendance, BuildContext context) {
    //Refer to Firebase
    final attendanceRef = FirebaseFirestore.instance.collection('userAttendance').doc();
    attendance.id = attendanceRef.id;
    final data = attendance.toJson();
    attendanceRef.set(data).whenComplete((){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()));


    });

  }


}