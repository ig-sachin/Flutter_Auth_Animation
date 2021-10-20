import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auth_animation/constants.dart';
import 'package:flutter_auth_animation/widgets/login_form.dart';
import 'package:flutter_auth_animation/widgets/sign_up_form.dart';
import 'package:flutter_auth_animation/widgets/socal_buttons.dart';
import 'package:flutter_svg/svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;
  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;

      _isShowSignUp
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    // It provides the screen height and width
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, snapshot) {
            return Stack(
              children: [
                // Login
                AnimatedPositioned(
                  // we will use 88% of login screen
                  width: _size.width * 0.88, // 88%
                  height: _size.height,
                  // left: _isShowSignUp ? -_size.width * 0.76 : 0, //76%
                  duration: defaultDuration,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  ),
                ),

                AnimatedPositioned(
                  height: _size.height,
                  width: _size.width * 0.88,
                  left: _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                  duration: defaultDuration,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
                  ),
                ),
                // Creating Logo
                Positioned(
                  left: 0,
                  right:
                      _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                  top: _size.height * 0.1, // 10%
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: _isShowSignUp
                        ? SvgPicture.asset(
                            "assets/animation_logo.svg",
                            color: signup_bg,
                          )
                        : SvgPicture.asset(
                            "assets/animation_logo.svg",
                            color: login_bg,
                          ),
                  ),
                ),
                //Social Icons
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  bottom: _size.height * 0.1,
                  right:
                      _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                  child: SocalButtns(),
                ),

                // Login text
                AnimatedPositioned(
                  duration: defaultDuration,
                  // when our sign up shows we want our login text to left center
                  bottom:
                      _isShowSignUp ? _size.height / 3.45 : _size.height * 0.3,
                  left: _isShowSignUp ? 0 : _size.width * 0.44 - 80,
                  // 0.88/2=0.44 (width of our login is 88%)
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _isShowSignUp ? 20 : 32,
                      fontWeight: FontWeight.bold,
                      color: _isShowSignUp ? Colors.white : Colors.white70,
                    ),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          updateView();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75),
                          // color: Colors.red,
                          width: 160,
                          child: Text(
                            "Log In".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //Sign Up
                AnimatedPositioned(
                  duration: defaultDuration,
                  // when our sign up shows we want our login text to left center
                  bottom:
                      !_isShowSignUp ? _size.height / 2.16 : _size.height * 0.3,
                  right: _isShowSignUp
                      ? _size.width * 0.44 - 80
                      : -_size.width / 3.2,
                  // 0.88/2=0.44 (width of our login is 88%)
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: !_isShowSignUp ? 20 : 32,
                      fontWeight: FontWeight.bold,
                      color: _isShowSignUp ? Colors.white : Colors.white70,
                    ),
                    child: Transform.rotate(
                      angle: (90 - _animationTextRotate.value) * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          updateView();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75),
                          // color: Colors.red,
                          width: 160,
                          child: Text(
                            "Sign Up".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
