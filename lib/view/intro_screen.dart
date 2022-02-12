import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tax_simplified/constants.dart';
import 'dart:ui' as ui;

import 'package:tax_simplified/view/main_screen.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();

    loadImage('assets/calc.png');
  }

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);

    setState(() => this.image = image);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: image == null
          ? CircularProgressIndicator()
          : CustomPaint(
              size: MediaQuery.of(context).size,
              painter: BackgroundPainter(image!),
              child: Container(
                width: screenWidth,
                height: screenHeight,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.1,
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Calculating your take home salary has never been easier. Tell us your salary and we handle the rest.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()),
                              )
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(orangeColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: orangeColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final ui.Image image;

  const BackgroundPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    //main background path
    Path background = Path();
    background.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = lightPurple;

    canvas.drawPath(background, paint);

    //create the curved line for top half of the screen
    paint.color = darkPurple;
    Path curve = Path();
    curve.lineTo(0, height * 0.33);
    curve.cubicTo(
      width * 0.2,
      height * 0.55,
      width,
      0.12,
      width + 20,
      height * 0.43,
    );

    curve.cubicTo(
      width,
      height * 0.99,
      width * 0.95,
      height,
      width + 50.0,
      height,
    );

    curve.cubicTo(0, height, 0, height, 0, height);
    canvas.drawPath(curve, paint);

    canvas.drawImage(image, Offset(width * 0.3, height * 0.3), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
