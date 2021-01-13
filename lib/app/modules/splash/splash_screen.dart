import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handson/app/modules/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => HomeScreen()));
    });
  }



  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: sizes.height,
        width: sizes.width,
        color: Colors.red.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 0.2,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/apple.png'),
                  ),
                ),
              ),
            ),
            Text(
              'Hands On',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                shadows: <Shadow>[
                  BoxShadow(
                      offset: Offset(1.5, 1.5),
                      blurRadius: 2,
                      spreadRadius: 8,
                      color: Colors.white70)
                ],
              ),
            ),
            SizedBox(
              height: sizes.height * .1,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
