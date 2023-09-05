import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:apple_shop/widgets/category_icon_item_chip.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitializeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: _getMainBody(),
      ),
    );
  }

  Widget _getMainBody() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            if (state is HomeLoadingState) ...{
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const <Widget>[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            } else ...{
              const GetAppBar(),
              if (state is HomeRequestSuccessState) ...[
                state.bannerList.fold(
                  (exceptionMessage) {
                    return SliverToBoxAdapter(
                      child: Text(exceptionMessage),
                    );
                  },
                  (listBanners) {
                    return BannerSlider(
                      bannerList: listBanners,
                    );
                  },
                ),
              ],
              const GetCategoryListTitle(),
              if (state is HomeRequestSuccessState) ...[
                state.categoryList.fold(
                  (exceptionMessage) {
                    return SliverToBoxAdapter(child: Text(exceptionMessage));
                  },
                  (categoryList) {
                    return GetCategoryListItem(categoryList);
                  },
                ),
              ],
              const GetBestSellesTitle(),
              if (state is HomeRequestSuccessState) ...[
                state.bestSellerProductList.fold(
                  (exceptionMessage) {
                    return SliverToBoxAdapter(
                      child: Text(exceptionMessage),
                    );
                  },
                  (productList) {
                    return GetBestSellersItem(productList: productList);
                  },
                ),
              ],
              const GetHottestViewTitle(),
              if (state is HomeRequestSuccessState) ...[
                state.hottestProductList.fold(
                  (exceptionMessage) {
                    return SliverToBoxAdapter(
                      child: Text(exceptionMessage),
                    );
                  },
                  (productList) {
                    return GetHottestViewItem(productList: productList);
                  },
                )
              ],
            },
          ],
        );
      },
    );
  }
}

class GetAppBar extends StatelessWidget {
  const GetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _getAppBarView(),
    );
  }

  Widget _getAppBarView() {
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
          image: AssetImage('images/icon_search.png'),
        ),
        SizedBox(width: 10.0),
        Text(
          'جستجوی محصولات',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'SB',
            fontSize: 16,
            color: CustomColors.gery,
          ),
        ),
        Spacer(),
        Image(
          image: AssetImage('images/icon_apple_blue.png'),
        ),
      ],
    );
  }
}

class GetCategoryListItem extends StatelessWidget {
  List<Category> listCategories;

  GetCategoryListItem(this.listCategories, {Key? key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44, bottom: 20),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listCategories.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CategoryIconItemChip(
                  category: listCategories[index],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class GetCategoryListTitle extends StatelessWidget {
  const GetCategoryListTitle({Key? key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 20,
          top: 32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'دسته‌ بندی',
              style: TextStyle(
                fontFamily: 'sb',
                fontSize: 12,
                color: CustomColors.gery,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GetBestSellesTitle extends StatelessWidget {
  const GetBestSellesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 44,
          left: 44,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Text(
              'پرفروش ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12.0,
                color: CustomColors.gery,
              ),
            ),
            Spacer(),
            Text(
              'مشاهده همه',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12.0,
                color: CustomColors.blue,
              ),
            ),
            SizedBox(width: 10.0),
            Image(
              image: AssetImage('images/icon_left_categroy.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class GetBestSellersItem extends StatelessWidget {
  List<Product> productList;
  GetBestSellersItem({required this.productList, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 44.0),
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productList.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ProductItem(
                      product: productList[index],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GetHottestViewTitle extends StatelessWidget {
  const GetHottestViewTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        right: 44,
        left: 44,
        bottom: 20,
        top: 32,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              children: const <Widget>[
                Text(
                  'پر بازدید ترین ها',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 12.0,
                    color: CustomColors.gery,
                  ),
                ),
                Spacer(),
                Text(
                  'مشاهده همه',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 12.0,
                    color: CustomColors.blue,
                  ),
                ),
                SizedBox(width: 10.0),
                Image(
                  image: AssetImage('images/icon_left_categroy.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GetHottestViewItem extends StatelessWidget {
  List<Product> productList;
  GetHottestViewItem({required this.productList, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44.0),
        child: SizedBox(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ProductItem(product: productList[index]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
