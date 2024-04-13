import 'package:flutter/material.dart';
import 'package:search_your_profile/pages/home.dart';

class SplashScream extends StatefulWidget {
  const SplashScream({super.key});

  @override
  State<SplashScream> createState() => _SplashScreamState();
}

class _SplashScreamState extends State<SplashScream> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const Home(),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/GitHub_Invertocat_Logo.svg.png",
              fit: BoxFit.cover,
              width: 130,
              height: 130,
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 150,
              ),
              child: LinearProgressIndicator(
                backgroundColor: Colors.black,
                color: Color.fromARGB(255, 134, 134, 134),
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
