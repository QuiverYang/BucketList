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
  double width = 0;
  double height = 0;
  double pagePadding01 = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    pagePadding01 = width * 0.1;
  }

  @override
  Widget build(BuildContext context) {
    return DragoonScaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(pagePadding01),
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
