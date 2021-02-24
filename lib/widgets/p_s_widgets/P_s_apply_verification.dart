import 'package:doctor_duniya/screens/verification/verify_document_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PSApplyVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      margin: EdgeInsets.symmetric(horizontal: 22),
      padding: EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 0.6.wp,
                    ),
                    child: Text(
                      "Document Verification",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Apply for document verification \nBe prepared with valid ID card",
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Icon(
                  FlutterIcons.verified_oct,
                  size: 30,
                  color: Colors.deepPurple,
                ),
              ),
              OutlineButton.icon(
                icon: Icon(Icons.add),
                label: Text("Add"),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(VerifyDocumentScreen.routeName);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
