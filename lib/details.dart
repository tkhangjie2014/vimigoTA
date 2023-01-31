import 'package:flutter/material.dart';
import 'package:vimigota/user_attendance.dart';

class Details extends StatelessWidget{
  const Details({super.key, required this.attendance});
  final Attendance attendance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.account_circle_rounded,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                attendance.user,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
              Text(
                attendance.phone,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
              Text(
                (attendance.checkIn).toString(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
            ],
          )
        )
      )
    );
  }
}