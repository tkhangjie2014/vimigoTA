import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget{
  const IntroPage3({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0,left: 15.0,right: 15.0),
      color: Colors.blue[100],
      child: Center(
        child: Column(
          children: const <Widget> [
            Image(
              image: AssetImage('assets/search_1.PNG'),
              height: 140,
              width: 230,
            ),
            Text('By tapping/clicking on the search button above, it will allow input for search like below',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image(
              image: AssetImage('assets/search_2.PNG'),
              height: 150,
              width: 230,
            ),
            Text('Type in the User name to search',
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