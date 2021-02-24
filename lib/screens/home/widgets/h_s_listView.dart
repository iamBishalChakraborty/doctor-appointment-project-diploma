import 'package:doctor_duniya/screens/doctor_know_more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HSListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 8)],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 140.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset(
                          "assets/images/login.svg",
                          height: 140.h,
                          width: 90.w,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. Shashikant Chaturvedhi",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Psychiatrist',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: '  (MBBS,MD)',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ]),
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Knows',
                                style: TextStyle(color: Colors.blue),
                              ),
                              TextSpan(
                                text: '  Hindi, English, Marathi',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ]),
                          ),
                          Row(
                            children: [
                              Icon(
                                FlutterIcons.phone_faw,
                                size: 17,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '₹ 400',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' (Save 20%)',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                FlutterIcons.hospital_faw5,
                                size: 17,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '₹ 700',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' (Save 50%)',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                FlutterIcons.hospital_marker_mco,
                                size: 15,
                              ),
                              Text("  Nishank Hospital")
                            ],
                          ),
                          Row(
                            children: [
                              OutlineButton(
                                child: Container(
                                  width: 90,
                                  child: Center(
                                    child: Text(
                                      "Know More",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                color: Colors.purple.withOpacity(0.80),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(DoctorKnowMoreScreen.routName);
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              OutlineButton(
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "Consult Now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                                color: Colors.blueAccent.withOpacity(0.50),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(DoctorKnowMoreScreen.routName);
              },
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        );
      },
    );
  }
}
