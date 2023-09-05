import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/widgets/cached_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return _getProductItem(context);
  }

  Widget _getProductItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ProductBloc(),
              child: ProductDetailScreen(
                product: product,
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 216.0,
        width: 160.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: _getColumnItemOfProduct(),
      ),
    );
  }

  Widget _getColumnItemOfProduct() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 10),
        _getStackHeaderOfItemProduct(),
        const Spacer(),
        _getColumnFooterOfItemProduct(),
      ],
    );
  }

  Widget _getColumnFooterOfItemProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: Text(
            product.name,
            textAlign: TextAlign.start,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'SM',
              fontSize: 14.0,
            ),
          ),
        ),
        _getFooterOfProductItem(),
      ],
    );
  }

  Widget _getFooterOfProductItem() {
    return Container(
      height: 53.0,
      decoration: const BoxDecoration(
        color: CustomColors.blue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.blue,
            blurRadius: 25.0,
            spreadRadius: -12.0,
            offset: Offset(0.0, 15.0),
          ),
        ],
      ),
      child: _getFooterOfProductItemDetails(),
    );
  }

  Widget _getFooterOfProductItemDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          const Text(
            'تومان',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5.0),
          _getOrginalPriceAndOfferPriceOfProduct(),
          const Spacer(),
          const Image(
            width: 24.0,
            image: AssetImage('images/icon_right_arrow_cricle.png'),
          ),
        ],
      ),
    );
  }

  Widget _getOrginalPriceAndOfferPriceOfProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          product.price.toString(),
          style: const TextStyle(
            decoration: TextDecoration.lineThrough,
            fontFamily: 'SM',
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
        Text(
          product.offPrice.toString(),
          style: const TextStyle(
            fontFamily: 'SM',
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _getStackHeaderOfItemProduct() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        const SizedBox(width: double.infinity),
        SizedBox(
          width: 96,
          height: 96,
          child: CachedImage(imageUrl: product.thumbnail),
        ),
        _getActiveFavProductIcon(),
        _getOfferContainer(),
      ],
    );
  }

  Widget _getActiveFavProductIcon() {
    return const Positioned(
      top: 0.0,
      right: 10.0,
      child: Image(
        width: 24.0,
        height: 24.0,
        image: AssetImage('images/active_fav_product.png'),
      ),
    );
  }

  Widget _getOfferContainer() {
    return Positioned(
      bottom: 0.0,
      left: 5.0,
      child: Container(
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
        child: Text(
          '${product.persent!.round().toString()} ٪',
          style: const TextStyle(
            fontFamily: 'SB',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
