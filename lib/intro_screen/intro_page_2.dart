import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget{
  const IntroPage2({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0,left: 15.0,right: 15.0 ),
      color: Colors.yellow[100],
      child: Center(
        child: Column(
          children: const [
            Image(
              image: AssetImage('assets/details.PNG'),
              height: 230,
              width: 250,
            ),
            Text('Tap/Click on any user will direct you to this Detailed User Page',
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