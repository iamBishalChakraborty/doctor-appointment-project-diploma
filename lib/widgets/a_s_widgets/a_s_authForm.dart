import 'package:doctor_duniya/Model/doctor.dart';
import 'package:doctor_duniya/Model/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_user_provider.dart';
import '../../providers/doctors_provider.dart';
import '../../providers/patient_profile_provider.dart';
import 'a_s_authOTPForm.dart';

class ASAuthForm extends StatefulWidget {
  @override
  _ASAuthFormState createState() => _ASAuthFormState();
}

class _ASAuthFormState extends State<ASAuthForm> {
  var _phoneNo = '';
  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    //for closing soft keyboard
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Sending OTP request..."),
          backgroundColor: Colors.purple,
        ),
      );
      _submitAuthForm(phoneNo: _phoneNo);
    }
  }

  Future<void> _submitAuthForm({String phoneNo}) async {
    print("------submit auth form running");
    try {
      final _auth = FirebaseAuth.instance;
      var _autoVerifiedFlag = false;

      // String _verificationId;
      await _auth.verifyPhoneNumber(
        phoneNumber: '\+91$phoneNo',
        timeout: Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // only call back when it automatically signs in user not manually
          // signing in user by credentials
          print("1");
          _autoVerifiedFlag = true;
          Navigator.of(context).pop();
          final authResult = await _auth.signInWithCredential(credential);

          //containes additionl user specific information
          User user = authResult.user;

          // Getting is user is doctor or Patient
          var isPatient =
              Provider.of<AuthUser>(context, listen: false).isPatient;
          print(isPatient);
          // * Creating Basic Structure of User
          if (isPatient) {
            await Provider.of<PatientProfileProvider>(context, listen: false)
                .createNewUser(
              Patient(
                id: authResult.user.uid,
                phone: int.tryParse(authResult.user.phoneNumber),
              ),
            );
          } else {
            await Provider.of<DoctorsProvider>(context, listen: false)
                .createNewUser(
              Doctor(
                id: authResult.user.uid,
                phone: int.tryParse(authResult.user.phoneNumber),
              ),
            );
          }

          print(
              "Signed in user automatically by otp sent no need to provide otp $user");
        },
        verificationFailed: (FirebaseAuthException e) {
          //if wrong no or wrong otp entered
          print("Reason due to varification failed: $e");
        },
        codeSent: (String verificationId, [int resendToken]) async {
          print("Code Sent run start");
          //  _verificationId = verificationId;

          await Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => ASOTPForm(),
          ))
              .then((otp) async {
            if (otp == null && !_autoVerifiedFlag) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Try loging in again.."),
                  backgroundColor: Theme.of(context).errorColor,
                ),
              );
              return;
            } else if (otp == null && _autoVerifiedFlag) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Logging you automatically..."),
                  backgroundColor: Colors.green,
                ),
              );
              return;
            }
            print("Done bro" + otp);
            final credential = PhoneAuthProvider.credential(
                verificationId: verificationId, smsCode: otp);
            try {
              // signing in user by credentials
              final authResult = await _auth.signInWithCredential(credential);
              //containes additionl user specific information
              //User user = authResult.user;

              // Getting is user is doctor or Patient
              var isPatient =
                  Provider.of<AuthUser>(context, listen: false).isPatient;
              print(isPatient);
              // * Creating Basic Structure of User
              if (isPatient) {
                await Provider.of<PatientProfileProvider>(context,
                        listen: false)
                    .createNewUser(Patient(
                  id: authResult.user.uid,
                  phone: int.tryParse(authResult.user.phoneNumber),
                ));
              } else {
                await Provider.of<DoctorsProvider>(context, listen: false)
                    .createNewUser(Doctor(
                  id: authResult.user.uid,
                  phone: int.tryParse(authResult.user.phoneNumber),
                ));
              }
              print("Logging in user by otp sent");
            } catch (error) {
              if (error == "invalid-verification-code") {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Invalid OTP entered"),
                    backgroundColor: Theme.of(context).errorColor,
                  ),
                );
              }
            }
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("code auto retrival running");
          // _verificationId = verificationId;
        },
      );
    } on PlatformException catch (error) {
      print("2");
      print("platform exception error handling" + error.code);
    } catch (error) {
      print("3");
      print("Errorr getting from: Authentication page" + error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: 'We will send you an ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                        text: 'One Time Password ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    TextSpan(
                      text: 'on this mobile number',
                      style: TextStyle(color: Colors.black),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone No",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "+91..",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.length < 10) {
                      return "Enter valid Mobile No";
                    } else if (value.length == 10) {
                      return null;
                    }
                    return "Check Credientials";
                  },
                  onSaved: (newValue) {
                    _phoneNo = newValue;
                  },
                ),
                SizedBox(
                  height: 18,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Next..",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: _trySubmit,
                  elevation: 10,
                  color: Colors.purpleAccent,
                )
              ],
            ),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
