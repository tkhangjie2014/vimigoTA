import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vimigota/homepage.dart';
import 'package:vimigota/user_attendance.dart';

class UpdateAttendance extends StatelessWidget {

  final Attendance attendance;
  final TextEditingController userController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  //final TextEditingController checkInController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  UpdateAttendance({super.key, required this.attendance});

  @override
  Widget build(BuildContext context){
    userController.text = attendance.user;
    phoneController.text = '${attendance.phone}';
    //checkInController.text = '${attendance.checkIn}';
    return Scaffold(
      appBar: AppBar(title: const Text('Update Attendance'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
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
                      Attendance updatedAttendance = Attendance(
                          user: userController.text,
                          phone: num.parse(phoneController.text));

                      final collectionReference =
                        FirebaseFirestore.instance.collection('userAttendance');
                      collectionReference
                          .doc(updatedAttendance.id)
                          .update(updatedAttendance.toJson())
                          .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                            ));
                      });
                    },
                    child: const Text('Update')),

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
}