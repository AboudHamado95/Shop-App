import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/models/model.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/marketing.png',
        title: 'On Board 1 title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/images/marketing.png',
        title: 'On Board 2 title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/images/marketing.png',
        title: 'On Board 3 title',
        body: 'On Board 3 body'),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => navigateAndFinish(context, LoginScreen()),
            child: Text('SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaulTColor,
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 4.0,
                      dotWidth: 10.0,
                      spacing: 10.0,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast)
                      navigateAndFinish(context, LoginScreen());
                    else {
                      boardController.nextPage(
                          duration: Duration(microseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(height: 30.0),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
        ],
      );
}
