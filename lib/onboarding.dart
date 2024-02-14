import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class onboard extends StatefulWidget {
  const onboard({super.key});

  @override
  State<onboard> createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: _height * 0.3,
          ),
          Text(
            '''Welcome to the
GDSC's''',
            style:
                GoogleFonts.manrope(fontSize: 36, fontWeight: FontWeight.w800),
          ),
          Text(
            '''Speech 
enhancement ''',
            style:
                GoogleFonts.manrope(fontSize: 36, fontWeight: FontWeight.w800),
          ),
          //alignment: Alignment(1, 0),
        ],
      ),
    );
  }
}
