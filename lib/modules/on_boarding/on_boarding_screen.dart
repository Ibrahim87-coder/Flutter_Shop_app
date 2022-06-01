import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/styles/colors.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({required this.title, required this.image, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'Order Your Favourites',
        image: 'assets/images/Online_Shoping_1.jpg',
        body: 'When you order Eat Street, we\'ll hook you up with exclusive coupons and special rewards.'),
    BoardingModel(
        title: 'Fast Delivery',
        image: 'assets/images/Online_Shoping_2.jpg',
        body: 'We provide the fatest delivery system. We will reach food in your home within 30 minutes.'),
    BoardingModel(
        title: 'Easy Payment',
        image: 'assets/images/Online_Shoping_3.jpg',
        body: 'Food is any substance consumed to provide nutritional support for an organism. Food is usually of plant animal'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          defaultTextButton(
              function: ()
              {
                navigateAndFinish(context, ShopLoginScreen());
              },
              text: 'skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
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
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      activeDotColor: defaultColor,
                      expansionFactor: 4.0,
                      dotWidth: 10.0,
                      spacing: 5.0),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(context, ShopLoginScreen());
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 24.0,

            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            '${model.body}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.grey
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
