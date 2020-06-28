import '../screen/bucket_list_screen.dart';
import '../screen/component/util_widget.dart';
import '../screen/signup_screen.dart';
import '../utilities/constant.dart';
import '../utilities/page_route.dart';
import 'package:flutter/material.dart';

import 'component/login_main_image.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DragoonScaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                kAppName,
                style: TextStyle(color: kThemeColor, fontSize: 40),
              ),
              SizedBox(height: height * 0.12),
              Stack(
                children: [
                  Container(
                    width: width * 0.8,
                    height: width * 0.8,
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                      colors: [Colors.white, Colors.red, Colors.transparent],
                    )),
                  ),
                  _mainAnim(),
                ],
              ),
              SizedBox(height: height * 0.06),
              MainButtonFilled(
                text: kSignup,
                onPressed: () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      routeName: kRouteSignupPage,
                      page: SignUpScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 5),
              MainButtonStroked(
                text: kLogin,
                onPressed: () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      routeName: kRouteBucketListPage,
                      page: BucketListScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: Text(
                  kForgotAccount,
                  style: TextStyle(color: kThemeColor),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _mainAnim() {
    return LoginMainImage();
  }
}
