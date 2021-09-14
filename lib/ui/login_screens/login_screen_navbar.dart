import 'package:cool_shop/constants.dart';
import 'package:cool_shop/ui/widgets/social_card.dart';
import 'package:flutter/material.dart';

class LoginScreenNavBar extends StatelessWidget {
  const LoginScreenNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //! old value height: 200,
      height: 120,
      child: Column(
        children: [
          const Text(
            'Or sign up with social account',
            style: AllStyles.dark14w400,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              SocialCard(
                image: 'assets/icons/google.svg',
                onPress: () => print('Google'),
              ),
              const SizedBox(width: 16),
              SocialCard(
                image: 'assets/icons/facebook.svg',
                onPress: () => print('Facebook'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
