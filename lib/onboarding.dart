import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vimigota/homepage.dart';
import 'package:vimigota/intro_screen/intro_page_1.dart';
import 'package:vimigota/intro_screen/intro_page_2.dart';
import 'package:vimigota/intro_screen/intro_page_3.dart';
import 'package:vimigota/intro_screen/intro_page_4.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}
  
  class _OnBoardingScreenState extends State<OnBoardingScreen>{
  //Keep track of page
  final PageController _controller = PageController();

  //keep track of last page
  bool onLastpage = false;


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Stack(
       children: [
         PageView(
           controller: _controller,
           onPageChanged: (index){
             setState(() {
               onLastpage = (index == 3);
             });
           },
           children: const [
             IntroPage1(),
             IntroPage2(),
             IntroPage3(),
             IntroPage4(),
           ],
         ),
         Container(
           alignment: const Alignment(0,0.75),
             child : Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [

                 //skip
                 GestureDetector(
                  onTap:(){
                    _controller.jumpToPage(3);
                  },
                  child: const Text('Skip')
                 ),

                 //dot indicator
                 SmoothPageIndicator(controller: _controller, count: 4),

                 //next or done
                 onLastpage
                     ? GestureDetector(
                        onTap:() {
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context){
                             return const HomePage();
                           })
                         );
                       },
                        child: const Text('Done')
                     )
                     : GestureDetector(
                       onTap:(){
                         _controller.nextPage(
                             duration: const Duration(milliseconds: 500),
                             curve: Curves.easeIn
                         );
                       },
                       child: const Text('Next')
                     )
               ],
             )
         )
       ],
     )
   );
  }
}




