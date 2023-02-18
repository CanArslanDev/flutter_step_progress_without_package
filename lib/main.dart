import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const StepProgress(),
    );
  }
}

class StepProgress extends StatefulWidget {
  const StepProgress({super.key});

  @override
  State<StepProgress> createState() => StepProgressState();
}

class StepProgressState extends State<StepProgress> {
  double percent = 50;
  double percentCalculatePixel = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (percentCalculatePixel == 0) percentAnimation();
    return Scaffold(
      backgroundColor: const Color(0xFF1D1E21),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topBar("Goals"),
              Stack(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: screenWidth / 30),
                      child: stepProgessBar(),
                    ),
                    height: screenHeight / 1.2,
                    width: screenWidth,
                  ),
                  Positioned(
                    left: 30,
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight / 70),
                      child: Column(
                        children: [
                          goals("Goal 1", "Goal description.", 1),
                          goals("Goal 2", "Goal description.", 2),
                          goals("Goal 3", "Goal description.", 3),
                          goals("Goal 4", "Goal description.", 4),
                          goals("Goal 5", "Goal description.", 5),
                          goals("Goal 6", "Goal description.", 6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //  stepProgessBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget goals(String title, String description, int count) {
    print(percent);
    return SizedBox(
      height: 115,
      child: Padding(
        padding: EdgeInsets.only(bottom: screenHeight / 80),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              height: screenWidth / 12,
              width: screenWidth / 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ((16 * count) >= percent || percentCalculatePixel == 0)
                    ? Color(0xFF282B30)
                    : Color(0xFF5662EC),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5)),
                ],
              ),
              duration: const Duration(seconds: 2),
            ),
            SizedBox(
              width: screenWidth / 20,
            ),
            Container(
              height: screenWidth / 4,
              width: screenWidth / 1.3,
              decoration: BoxDecoration(
                  color: const Color(0xFF282B30),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth / 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: screenWidth / 70, bottom: 2),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth / 17),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      width: screenWidth / 2,
                      color: Colors.white,
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.white, fontSize: screenWidth / 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stepProgessBar() {
    return Padding(
      padding: EdgeInsets.only(top: screenWidth / 40),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SizedBox(
              height: screenHeight,
              child: Column(
                children: [
                  Image.asset("assets/progress_particles.png"),
                ],
              )),
          Positioned(
            left: 19,
            child: Container(
              width: screenWidth / 14,
              height: screenHeight / 1.48,
              decoration: BoxDecoration(
                color: const Color(0xFF282B30),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            left: 19,
            child: AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF5662EC),
                        Color(0xFF7848FF),
                      ]),
                  borderRadius: BorderRadius.circular(20)),
              width: screenWidth / 14,
              height: percentCalculatePixel,
              duration: const Duration(seconds: 4),
            ),
          ),
          // Positioned(
          //   right: 0,
          //   top: 15,
          //   child: Container(
          //     width: 230,
          //     height: 230,
          //     color: Colors.deepPurpleAccent,
          //   ),
          // ),
        ],
      ),
    );
  }

  percentAnimation() {
    Future.delayed(Duration(seconds: 1), () {
      print("object");
      setState(() {
        percentCalculatePixel = (screenHeight / 1.48 * percent) / 100;
        print(percentCalculatePixel);
      });
    });
  }

  Widget topBar(String title) {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth / 16, top: screenWidth / 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/boost_icon.png",
            height: screenWidth / 10,
            fit: BoxFit.fill,
          ),
          Text(
            title,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth / 14),
          ),
        ],
      ),
    );
  }
}
