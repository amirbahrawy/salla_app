import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/components/components.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'WELCOME TO Salla APP',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          SvgPicture.asset(
            'assets/icons/chat.svg',
            height: 320,
          ),
          const SizedBox(
            height: 15,
          ),
          RoundedButton(
              text: 'login',
              function: () {
                navigateTo(context, LoginScreen());
              }),
          const SizedBox(
            height: 15,
          ),
          RoundedButton(
            text: 'sign up',
            function: () {},
            color: primaryLightColor,
            textColor: Colors.black,
          )
        ],
      ),
    );
  }
}
