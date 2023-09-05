import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/widgets/category_icon_item_chip.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _getMainBody(),
      ),
    );
  }

  Column _getMainBody() {
    return Column(
      children: [
        _getAppBar(),
        const Text(
          'رامتین مرادی',
          style: TextStyle(
            fontFamily: 'SB',
            fontSize: 16,
          ),
        ),
        const Text(
          '۰۹۰۲۱۷۲۲۲۷۲',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 30),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Wrap(
            spacing: 40,
            runSpacing: 20,
            children: const <Widget>[
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
            ],
          ),
        ),
        const Spacer(),
        const Text(
          'اپل شاپ',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 10,
            color: CustomColors.gery,
          ),
        ),
        const Text(
          'v-1.0.0',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 10,
            color: CustomColors.gery,
          ),
        ),
        const Text(
          'Instagram.com/ramtin.codes',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 10,
            color: CustomColors.gery,
          ),
        ),
      ],
    );
  }

  Widget _getAppBar() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 44,
        right: 44,
        bottom: 32,
        top: 10,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 46.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: _getItemOfAppBar(),
      ),
    );
  }

  Widget _getItemOfAppBar() {
    return Row(
      children: const <Widget>[
        Image(
          image: AssetImage('images/icon_apple_blue.png'),
        ),
        Spacer(),
        Text(
          'حساب کاربری',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'SB',
            fontSize: 16,
            color: CustomColors.blue,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
