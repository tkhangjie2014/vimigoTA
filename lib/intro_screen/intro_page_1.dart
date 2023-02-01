import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget{
  const IntroPage1({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 50.0,left: 15.0,right: 15.0),
        color: Colors.pink[100],
        child: Center(
          child: Column(
            children: const [
              Image(
                  image: AssetImage('assets/home.PNG'),
                  height: 500,
                  width: 250,
              ),
              Text('This is the Home Page',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                ),
              ),
              Text('\nWelcome!',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
    );
  }


}