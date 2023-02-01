import 'package:flutter/material.dart';

class IntroPage4 extends StatelessWidget{
  const IntroPage4({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0,left: 15.0,right: 15.0),
      color: Colors.green[100],
      child: Center(
        child: Column(
          children: const <Widget> [
            Image(
              image: AssetImage('assets/add_button.PNG'),
              height: 80,
              width: 230,
            ),
            Text('By tapping/clicking on the + sign above, Add Attendance Page will be displayed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image(
              image: AssetImage('assets/add.PNG'),
              height: 200,
              width: 230,
            ),
            Text('Press ADD after finish filling up, press reset to clean the input',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


}