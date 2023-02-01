import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vimigota/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vimigota/add_user_attendance.dart';
import 'package:vimigota/user_attendance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  final CollectionReference _reference =
  FirebaseFirestore.instance.collection('userAttendance');

  bool isSearchClicked = false;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchClicked?
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Search...'),
              onChanged: (value){
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
        ) : const Text('User Attendance'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                isSearchClicked = !isSearchClicked;
              });
            },
          icon: Icon(isSearchClicked ? Icons.close : Icons.search))
        ],

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
                    checkIn: e['checkIn']))
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
                builder: (context) => const AddAttendance(),));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getbody(List<Attendance> attendance) {

    attendance.sort((a, b) {
      var dtA = DateFormat('d-M-y H:m:s').parse((a.checkIn).toString()).millisecondsSinceEpoch;
      var dtB = DateFormat('d-M-y H:m:s').parse((b.checkIn).toString()).millisecondsSinceEpoch;
      return dtB.compareTo(dtA);
    });

    return attendance.isEmpty ? const Center(
      child: Text(
        'No users have made attendance yet\nClick + to start adding',
        textAlign: TextAlign.center,
      ),
    )
    : searchText.isEmpty
    ?ListView.builder(
        itemCount: attendance.length,
        itemBuilder: (context, index) {
          var attendanceItem = attendance[index];
          var initialTime = DateTime.now().millisecondsSinceEpoch;
          var attendanceTime = DateFormat('d-M-y H:m:s').parse((attendanceItem.checkIn).toString()).millisecondsSinceEpoch;
          var mins = (initialTime - attendanceTime)~/1000~/60;
          var hrs = (initialTime - attendanceTime)~/1000~/60~/60;

          if(mins < 1) {
            return Card(
                child: ListTile(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(attendance: attendance[index])),
                      );
                    }),
                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle:
                    Column(

                    ),
                    trailing: const Text('less than a min ago')
                )
            );
          }
          if(mins < 2) {
            return Card(
                child: ListTile(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(attendance: attendance[index])),
                      );
                    }),
                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('$mins min ago')
                )
            );
          }
          if(mins < 60) {
            return Card(
                child: ListTile(onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(attendance: attendance[index])),
                  );
                }),

                    title: Text(attendance[index].user,style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('$mins mins ago')
                )
            );
          }
          if(hrs < 120){
            return Card(
                child: ListTile(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(attendance: attendance[index])),
                      );
                    }),
                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('$hrs hour ago')
                )
            );
          }
          if(hrs >= 120){
            return Card(
                child: ListTile(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(attendance: attendance[index])),
                      );
                    }),
                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('$hrs hours ago')
                )
            );
          }

        }
    )
      :ListView.builder(
      itemCount: attendance.length,
      itemBuilder: (context, index) {
        if (attendance[index].user
            .toLowerCase()
            .startsWith(searchText.toLowerCase())) {
          var attendanceItem = attendance[index];
          var initialTime = DateTime.now().millisecondsSinceEpoch;
          var attendanceTime = DateFormat('d-M-y H:m:s').parse((attendanceItem.checkIn).toString()).millisecondsSinceEpoch;
          var mins = (initialTime - attendanceTime)~/1000~/60;
          var hrs = (initialTime - attendanceTime)~/1000~/60~/60;

          if(mins < 1) {
            return Card(
                child: ListTile(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(attendance: attendance[index])),
                      );
                    }),
                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('less than a min ago')
                )
            );
          }
          if(mins < 2) {
            return Card(
                child: ListTile(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(attendance: attendance[index])),
                      );
                    }),
                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('$mins min ago')
                )
            );
          }
          if(mins < 60) {
            return Card(
                child: ListTile(onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(attendance: attendance[index])),
                  );
                }),

                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('$mins mins ago')
                )
            );
          }
          if(hrs < 120){
            return Card(
                child: ListTile(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(attendance: attendance[index])),
                      );
                    }),
                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('$hrs hour ago')
                )
            );
          }
          if(hrs >= 120){
            return Card(
                child: ListTile(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(attendance: attendance[index])),
                      );
                    }),
                    title: Text(attendance[index].user, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle:
                    Column(

                    ),
                    trailing: Text('$hrs hours ago')
                )
            );
          }
        }
        return const SizedBox();
      }
    );
  }
}