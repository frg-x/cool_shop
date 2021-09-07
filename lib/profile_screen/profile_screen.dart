// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/profile_screen/settings_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.appBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  const SizedBox(height: 55),
                  const Align(
                    child: Icon(Icons.search),
                    alignment: Alignment.bottomRight,
                  ),
                  const SizedBox(height: 34),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('My profile', style: AllStyles.headlineActive),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: Image.asset('assets/images/avatar.png'),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      const SizedBox(width: 19),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Matilda Brown',
                            style:
                                AllStyles.headlineActive.copyWith(fontSize: 18),
                          ),
                          const Text('matildabrown@mail.com',
                              style: AllStyles.gray14w400),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ProfileItem(
              title: 'My orders',
              subtitle: 'Already have 12 orders',
              onPress: () {
                print('My orders action');
              },
            ),
            const Divider(),
            ProfileItem(
              title: 'Shipping addresses',
              subtitle: '3 addresses',
              onPress: () {
                print('Shipping addresses action');
              },
            ),
            const Divider(),
            ProfileItem(
              title: 'Payment methods',
              subtitle: 'Visa **34',
              onPress: () {
                print('Payment methods action');
              },
            ),
            const Divider(),
            ProfileItem(
              title: 'Promocodes',
              subtitle: 'You have special promocodes',
              onPress: () {
                print('Promocodes action');
              },
            ),
            const Divider(),
            ProfileItem(
              title: 'My reviews',
              subtitle: 'Reviews for 4 items',
              onPress: () {
                print('My reviews action');
              },
            ),
            const Divider(),
            ProfileItem(
              title: 'Settings',
              subtitle: 'Notifications, password',
              onPress: () => Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
