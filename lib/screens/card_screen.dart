import 'package:apple_shop/constants/colors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _getAppBar(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 60),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _getCardItem(context);
                      },
                      childCount: 10,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 44,
                right: 44,
                bottom: 10,
              ),
              child: SizedBox(
                height: 53.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'ادامه فرایند خرید',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCardItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 44.0,
        left: 44.0,
        bottom: 20,
      ),
      height: 249.0,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('data'),
                          const Text('data'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 6,
                                ),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  color: Colors.red,
                                ),
                                child: const Text(
                                  '٪۳',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text('تومان'),
                              const Text('۴۹٬۱۲۳٬۱۲۳'),
                            ],
                          ),
                          Wrap(
                            children: [
                              _getOptionsChip(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset('images/iphone.png'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: DottedLine(
              lineThickness: 3,
              dashLength: 8,
              dashColor: CustomColors.gery.withOpacity(0.5),
              dashGapLength: 3,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('۵۹٬۰۰۰٬۰۰۰'),
                SizedBox(width: 5.0),
                Text('تومان'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getOptionsChip() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.gery,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/icon_options.png',
          ),
          SizedBox(width: 10.0),
          Text('111111'),
        ],
      ),
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
          'سبد خرید',
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
