import 'dart:ui';

import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/screens/card_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavgation extends StatefulWidget {
  const BottomNavgation({super.key});

  @override
  State<BottomNavgation> createState() => _BottomNavgationState();
}

class _BottomNavgationState extends State<BottomNavgation> {
  int _selectedBottomNavigationIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedBottomNavigationIndex,
        children: getScreens(),
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
        child: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _selectedBottomNavigationIndex = index;
            });
          },
          currentIndex: _selectedBottomNavigationIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'SB',
            fontSize: 10.0,
            color: Colors.black,
          ),
          selectedLabelStyle: const TextStyle(
            fontFamily: 'SB',
            fontSize: 10.0,
            color: CustomColors.blue,
          ),
          items: [
            _getProfileBottomNavigatonBarItem(),
            _getBasketBottomNavigationBarItem(),
            _getCategoryBottomNavigationBarItem(),
            _getHomeBottomNavigationBarItem(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _getHomeBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blue,
              blurRadius: 20.0,
              spreadRadius: -7.0,
              offset: Offset(0.0, 13.0),
            ),
          ],
        ),
        child: Image.asset('images/icon_home.png'),
      ),
      activeIcon: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blue,
              blurRadius: 20.0,
              spreadRadius: -7.0,
              offset: Offset(0.0, 13.0),
            ),
          ],
        ),
        child: Image.asset('images/icon_home_active.png'),
      ),
      label: 'خانه',
    );
  }

  BottomNavigationBarItem _getCategoryBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blue,
              blurRadius: 20.0,
              spreadRadius: -7.0,
              offset: Offset(0.0, 13.0),
            ),
          ],
        ),
        child: Image.asset('images/icon_category.png'),
      ),
      activeIcon: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blue,
              blurRadius: 20.0,
              spreadRadius: -7.0,
              offset: Offset(0.0, 13.0),
            ),
          ],
        ),
        child: Image.asset('images/icon_category_active.png'),
      ),
      label: 'دسته بندی',
    );
  }

  BottomNavigationBarItem _getBasketBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blue,
              blurRadius: 20.0,
              spreadRadius: -7.0,
              offset: Offset(0.0, 13.0),
            ),
          ],
        ),
        child: Image.asset('images/icon_basket.png'),
      ),
      activeIcon: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blue,
              blurRadius: 20.0,
              spreadRadius: -7.0,
              offset: Offset(0.0, 13.0),
            ),
          ],
        ),
        child: Image.asset('images/icon_basket_active.png'),
      ),
      label: 'سبد خرید',
    );
  }

  BottomNavigationBarItem _getProfileBottomNavigatonBarItem() {
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blue,
              blurRadius: 20.0,
              spreadRadius: -7.0,
              offset: Offset(0.0, 13.0),
            ),
          ],
        ),
        child: Image.asset('images/icon_profile.png'),
      ),
      activeIcon: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blue,
              blurRadius: 20.0,
              spreadRadius: -7.0,
              offset: Offset(0.0, 13.0),
            ),
          ],
        ),
        child: Image.asset('images/icon_profile_active.png'),
      ),
      label: 'حساب کاربری',
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      const ProfileScreen(),
      const CardScreen(),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryScreen(),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => HomeBloc(),
          child: const HomeScreen(),
        ),
      ),
    ];
  }
}
