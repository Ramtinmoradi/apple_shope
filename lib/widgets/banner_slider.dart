import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/widgets/cached_images.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  List<BannerCampain> bannerList;
  BannerSlider({required this.bannerList, super.key});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);
    return SliverToBoxAdapter(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          _getBannerSliderItem(controller),
          _getSmoothPageIndicator(controller),
        ],
      ),
    );
  }

  Widget _getBannerSliderItem(PageController controller) {
    return SizedBox(
      height: 177,
      child: PageView.builder(
        controller: controller,
        itemCount: bannerList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            child: CachedImage(
              imageUrl: bannerList[index].thumbnail!,
              radius: 15,
            ),
          );
        },
      ),
    );
  }

  Widget _getSmoothPageIndicator(PageController controller) {
    return Positioned(
      bottom: 10,
      child: SmoothPageIndicator(
        effect: const ExpandingDotsEffect(
          expansionFactor: 4,
          dotHeight: 6,
          dotWidth: 6,
          dotColor: Colors.white,
          activeDotColor: CustomColors.blueIndicator,
        ),
        controller: controller,
        count: 3,
      ),
    );
  }
}
