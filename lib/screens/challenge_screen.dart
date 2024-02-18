import 'package:flutter/material.dart';
import 'package:gdscapp/index.dart';
import 'package:gdscapp/widgets/days_Selector.dart';
import 'package:gdscapp/widgets/time_selector.dart';

class Challenge_screen extends StatefulWidget {
  const Challenge_screen({super.key});

  @override
  State<Challenge_screen> createState() => _Challenge_screenState();
}

class _Challenge_screenState extends State<Challenge_screen> {
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: CustomText(
                text: 'Challenge',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: _height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: CustomText(
                text: 'Choose a convenient time for your lessons',
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimeSelector(height: _height * 0.1, text: '8:00 AM - 10:00 AM'),
                TimeSelector(
                    height: _height * 0.1, text: '10:00 AM - 12:00 AM'),
                //TimeSelector(height: _height * 0.1, text: '12:00 PM - 2:00 PM'),
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimeSelector(
                    height: _height * 0.1, text: '12:00 PM - 02:00 PM'),
                TimeSelector(
                    height: _height * 0.1, text: '02:00 PM - 04:00 PM'),
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimeSelector(
                    height: _height * 0.1, text: '04:00 PM - 06:00 PM'),
                TimeSelector(
                    height: _height * 0.1, text: '06:00 PM - 08:00 PM'),
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimeSelector(
                    height: _height * 0.1, text: '08:00 PM - 10:00 PM'),
                TimeSelector(
                    height: _height * 0.1, text: '10:00 PM - 12:00 PM'),
              ],
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: CustomText(
                text: 'Choose convenient days for your lessons',
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DaysSelector(
                    height: _height * 0.038,
                    text: 'Monday',
                    width: _width * 0.25),
                DaysSelector(
                    height: _height * 0.038,
                    text: 'Tuesday',
                    width: _width * 0.25),
                DaysSelector(
                    height: _height * 0.038,
                    text: 'Wednesday',
                    width: _width * 0.25),
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DaysSelector(
                    height: _height * 0.038,
                    text: 'Thursday',
                    width: _width * 0.25),
                DaysSelector(
                    height: _height * 0.038,
                    text: 'Friday',
                    width: _width * 0.25),
                DaysSelector(
                    height: _height * 0.038,
                    text: 'Saturday',
                    width: _width * 0.25),
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: _width * 0.03,
                ),
                DaysSelector(
                    height: _height * 0.038,
                    text: 'Sunday',
                    width: _width * 0.25),
              ],
            ),
          ],
        ),
        bottomNavigationBar: ButtomNavBar(
          currentIndex: 2,
        ));
  }
}
