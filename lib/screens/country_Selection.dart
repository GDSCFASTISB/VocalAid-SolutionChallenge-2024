import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class countrySelect extends StatefulWidget {
  const countrySelect({super.key});

  @override
  State<countrySelect> createState() => _countrySelectState();
}

class _countrySelectState extends State<countrySelect> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: _height * 0.15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Mobile Number',
              style: GoogleFonts.manrope(
                  fontSize: 30, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
