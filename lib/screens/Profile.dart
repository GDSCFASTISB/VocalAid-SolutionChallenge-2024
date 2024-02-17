import 'package:flutter/material.dart';
import 'package:gdscapp/index.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Homepage',
            style:
                GoogleFonts.manrope(fontSize: 33, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: SizedBox(
            height: 120,
            width: double.infinity,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    size: 50,
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Text('Welcome, ',
                              style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  color: Color(0xFF00856C),
                                  fontWeight: FontWeight.w600)),
                          Text('Kashan Ali',
                              style: GoogleFonts.manrope(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          size: 20,
                          Icons.flag,
                          color: Color(0xFF00856C),
                        ),
                        Text(
                          '  Denmark',
                          style: GoogleFonts.manrope(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          size: 20,
                          Icons.phone_callback,
                          color: Colors.black,
                        ),
                        Text(
                          '  9236373837001',
                          style: GoogleFonts.manrope(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          size: 20,
                          Icons.shopping_bag,
                          color: Colors.black,
                        ),
                        Text(
                          '  maherkashan7@gmail.com',
                          style: GoogleFonts.manrope(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          size: 20,
                          Icons.analytics,
                          color: Colors.black,
                        ),
                        Text(
                          '  3.10',
                          style: GoogleFonts.manrope(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Levels:',
            style: GoogleFonts.manrope(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Color(0xFF00856C),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      '1',
                      style: GoogleFonts.manrope(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      //color: Color(0xFF00856C),
                      border: Border.all(color: Color(0xFF00856C)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      '2',
                      style: GoogleFonts.manrope(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      //color: Color(0xFF00856C),
                      border: Border.all(color: Color(0xFF00856C)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      '3',
                      style: GoogleFonts.manrope(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      //color: Color(0xFF00856C),
                      border: Border.all(color: Color(0xFF00856C)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      '4',
                      style: GoogleFonts.manrope(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      //color: Color(0xFF00856C),
                      border: Border.all(color: Color(0xFF00856C)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      '6',
                      style: GoogleFonts.manrope(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      //color: Color(0xFF00856C),
                      border: Border.all(color: Color(0xFF00856C)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      '7',
                      style: GoogleFonts.manrope(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: 'Training Score',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    //fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF00856C),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: CustomText(
                          text: '3.10',
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CustomText(
                            text: '2280',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          CustomText(
                            text: 'Words',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00856C),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.black,
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Column(
                        children: [
                          CustomText(
                            text: '2389',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          CustomText(
                            text: 'Rank',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00856C),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.black,
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Column(
                        children: [
                          CustomText(
                            text: '889',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          CustomText(
                            text: 'Minutes',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00856C),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        //2nd card widget
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF00856C),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          CustomText(
                            text: 'Today\'s Challenge',
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            //fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          CustomText(
                            text: 'Strength Sprint',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            //fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: CustomText(
                      text:
                          '''From 'giving it your all' to 'crossing the finish line,' let your actions speak louder than words. Embrace the sportsmanship within you and and redefine with our clinically tested exercises and phrases.''',
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      //fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFF4BAB92),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: CustomText(
                            text: 'Sports',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Color(0xFF4BAB92),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: CustomText(
                            text: '5 new phrases',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF4BAB92),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: CustomText(
                            text: '2 hr',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ), // SizedBox(
      ]),
    );
  }
}
