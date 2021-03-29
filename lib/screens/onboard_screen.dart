import 'package:famdoc_user/constants.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

final _controller = PageController(
  initialPage: 0,
);

int _currentPage = 0;

List<Widget> _pages = [
  Column(
    children: [
      Expanded(child: Image.asset('images/splash_1.png')),
      Text(
        'Set Your Location',
        style: kPageViewTextStyle,
        textAlign: TextAlign.center,
      )
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/splash_2.png')),
      Text(
        'Find Best Match Nearest Doctors For You',
        style: kPageViewTextStyle,
        textAlign: TextAlign.center,
        
      ),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/splash_3.png')),
      Text(
        'Connect With Your Preffered Doctors Online',
        style: kPageViewTextStyle,
        
        textAlign: TextAlign.center,
      ),
    ],
  ),
];

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        DotsIndicator(
          dotsCount: _pages.length,
          position: _currentPage.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeColor: Color.fromRGBO(0, 179, 134, 1.0),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
