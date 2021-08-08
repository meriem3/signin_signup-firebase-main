import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signin_signout/customs/CustomTextField.dart';
import 'package:signin_signout/datafire/auth.dart';
import 'package:signin_signout/screens/HomeScreen.dart';
import 'package:signin_signout/screens/SignupScreen.dart';
import'screens.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth=Auth();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: globalKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Container(
                      height: size.height * .2,
                      width: size.width * .85,
                      child: SvgPicture.asset(
                          "images/undraw_portfolio_feedback_6r17.svg")),
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  CustomTextField(
                    controller: email,
                    text: "E-mail",
                    iconData: Icons.email,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  CustomTextField(
                    controller: password,
                    text: "Password",
                    iconData: Icons.lock,
                    icon: Icons.remove_red_eye,
                  ),
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyanAccent, // background
                        onPrimary: Colors.white, // foreground
                        elevation: 6,
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),

                      onPressed: ()async {
                        if (globalKey.currentState!.validate()) {
                          globalKey.currentState!.save();
                          try {
                            auth.Signin(email.text, password.text,);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(title:'Welcome')));
                          } catch (e)
                          {
                            // ignore: deprecated_member_use
                            Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("invalid!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)));
                          }
                        }
                      },
                      child: Text("Login", style: TextStyle(color: Colors.white,),
                      )),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don`t have an account?",
                        style: TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      GestureDetector(
                          onTap: ()  {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
