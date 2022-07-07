import 'package:ecommerce_app/views/shared_prefernces.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  static const String onboardRoute = 'onboard';
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  PageController pageController = PageController();

  bool isLastpage = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageView(
                controller: pageController,
                onPageChanged: (i) {
                  setState(() {
                    isLastpage = i == 2;
                  });
                },
                children: [
                  buildPage(
                      color: Colors.orange.shade100,
                      urlImage: 'images/page1.png',
                      title: 'SHOPPING',
                      subTitle:
                          'This application help people to buy any products any time'),
                  buildPage(
                      color: Colors.green.shade100,
                      urlImage: 'images/page2.png',
                      title: 'ONLINE',
                      subTitle:
                          'This application help people to buy any products online through computer or mobile'),
                  buildPage(
                      color: Colors.teal.shade100,
                      urlImage: 'images/page3.png',
                      title: 'PAY',
                      subTitle:
                          'This application help people to pay money also online through card')
                ])),
        bottomSheet: isLastpage
            ? Container(
                decoration: const BoxDecoration(),
                width: double.infinity,
                child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(26),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      backgroundColor: Colors.black,
                      primary: Colors.cyan.shade700,
                    ),
                    onPressed: () async {
                      SharedPref.instance
                          .setBool(key: SharedPref.keyOpened, value: true);
                      if (!mounted) return;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Container();
                      }));
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 24),
                    )),
              )
            : Container(
                decoration: const BoxDecoration(color: Colors.black),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          pageController.jumpToPage(2);
                        },
                        child: Text(
                          'SKIP',
                          style: TextStyle(color: Colors.cyan.shade700),
                        )),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.white,
                            activeDotColor: Colors.cyan.shade700),
                        onDotClicked: (i) {
                          pageController.animateToPage(i,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          'NEXT',
                          style: TextStyle(color: Colors.cyan.shade700),
                        ))
                  ],
                )),
      ),
    );
  }

  Widget buildPage(
      {required Color color,
      required String urlImage,
      required String title,
      required String subTitle}) {
    return Container(
      color: color,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          urlImage,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const SizedBox(
          height: 64,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.teal.shade700,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 70),
          child: Text(
            subTitle,
            style: const TextStyle(color: Colors.teal, fontSize: 15),
          ),
        )
      ]),
    );
  }
}
