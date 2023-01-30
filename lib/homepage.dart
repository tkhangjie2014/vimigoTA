import 'package:flutter/material.dart';
import 'package:vimigota/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vimigota/add_user_attendance.dart';
import 'package:vimigota/update_user_attendance.dart';
import 'package:vimigota/user_attendance.dart';

class HomePage extends StatelessWidget {
  final CollectionReference _reference =
  FirebaseFirestore.instance.collection('userAttendance');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Attendance'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _reference.get(),
        builder: (context, snapshot) {
          //Check error
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          //if data received
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            List<Attendance> attendance = documents.map((e) =>
                Attendance(
                    user: e['user'],
                    phone: e['phone'],
                    checkIn: DateTime.parse(e['checkIn'])))
                .toList();
            return _getbody(attendance);
          }
          else {
            //Show Loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAttendance(),));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getbody(attendance) {
    return attendance.isEmpty ? const Center(
      child: Text(
        'No users have made attendance yet\nClick + to start adding',
        textAlign: TextAlign.center,
      ),
    ) : ListView.builder(
        itemCount: attendance.length,
        itemBuilder: (context, index) =>
            Card(
                child: ListTile(

                  title: Text(attendance[index].user),
                  subtitle:
                  Column(
                    children: [
                      const Align(alignment: Alignment.centerLeft),
                      Text('Phone No:${attendance[index].phone}'),
                      const Align(alignment: Alignment.centerLeft),
                      Text('Check-in:${attendance[index].checkIn}')
                    ],
                  ),
                  trailing: SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          InkWell(child: const Icon(
                              Icons.edit,
                              color: Colors.black),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateAttendance(
                                              attendance: attendance[index]),
                                    ));
                              }),
                          InkWell(child: const Icon(
                              Icons.delete,
                              color: Colors.red),
                            onTap: () {
                              _reference.doc(attendance[index].id).delete();
                              //refresh
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage(),));
                            },
                          ),
                        ],
                      )
                  ),
                )
            )
    );
  }
}