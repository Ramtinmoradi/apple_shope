import 'dart:ui';

import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_peroperty.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/widgets/cached_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  Product product;
  ProductDetailScreen({required this.product, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(
      ProductInitializeEvent(widget.product.id, widget.product.categoryId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: CustomScrollView(
                slivers: [
                  if (state is ProductDetailLoadingState) ...{
                    const SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  },
                  if (state is ProductDetailResponseState) ...{
                    SliverToBoxAdapter(
                      child: Padding(
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
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/icon_apple_blue.png'),
                              const Spacer(),
                              state.productCategory.fold(
                                (exceptionMessage) {
                                  return const Text(
                                    'اطلاعات محصول',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 16,
                                      color: CustomColors.blue,
                                    ),
                                  );
                                },
                                (productCategory) {
                                  return Text(
                                    productCategory.title,
                                    style: const TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 16,
                                      color: CustomColors.blue,
                                    ),
                                  );
                                },
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset('images/icon_back.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  },
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 20),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (state is ProductDetailResponseState) ...{
                    state.productImage.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (productImageList) {
                        return GalleryWidget(
                          productImageList: productImageList,
                          defualtProductThumbnail: widget.product.thumbnail,
                        );
                      },
                    ),
                  },
                  if (state is ProductDetailResponseState) ...{
                    state.productVariant.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (productVariantList) {
                        return VariantContainerGenerator(
                          productVariantList: productVariantList,
                        );
                      },
                    ),
                  },
                  if (state is ProductDetailResponseState) ...{
                    state.productPeroperties.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (productPeroperties) {
                        return GetProductPeroperties(
                          productPeropertyList: productPeroperties,
                        );
                      },
                    ),
                  },
                  GetProductDescription(
                      productDescription: widget.product.description),
                  SliverPadding(
                    padding:
                        const EdgeInsets.only(right: 44, left: 44, top: 20),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: CustomColors.gery,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset('images/icon_left_categroy.png'),
                              const SizedBox(width: 10),
                              const Text(
                                'مشاهده',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: CustomColors.blue,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 26.0,
                                    width: 26.0,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15.0,
                                    child: Container(
                                      height: 26.0,
                                      width: 26.0,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    child: Container(
                                      height: 26.0,
                                      width: 26.0,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 45,
                                    child: Container(
                                      height: 26.0,
                                      width: 26.0,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 60,
                                    child: Container(
                                      height: 26.0,
                                      width: 26.0,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '+10',
                                          style: TextStyle(
                                            fontFamily: 'SB',
                                            fontSize: 11.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10.0),
                              const Text(
                                'نظرات کابران',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 14.0,
                                  color: CustomColors.gery,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 44, left: 44),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _getPriceContainer(),
                          _getAddToBasketBottom(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getAddToBasketBottom() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 53,
                width: 160,
                color: Colors.transparent,
                child: const Center(
                  child: Text(
                    'افزودن سبد خرید',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getPriceContainer() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 53,
                width: 160,
                color: Colors.transparent,
                child: Padding(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            '۴۹٬۸۰۰٬۰۰۰',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'SM',
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '۴۸٬۸۰۰٬۰۰۰',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GetProductPeroperties extends StatefulWidget {
  List<Peroperty> productPeropertyList;
  GetProductPeroperties({required this.productPeropertyList, super.key});

  @override
  State<GetProductPeroperties> createState() => _GetProductPeropertiesState();
}

class _GetProductPeropertiesState extends State<GetProductPeroperties> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        right: 44,
        left: 44,
        top: 5,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: CustomColors.gery,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Image.asset('images/icon_left_categroy.png'),
                      const SizedBox(width: 10),
                      const Text(
                        'مشاهده',
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 12,
                          color: CustomColors.blue,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'مشخصات فنی',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 14.0,
                          color: CustomColors.gery,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: CustomColors.gery,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.productPeropertyList.length,
                    itemBuilder: (context, index) {
                      var property = widget.productPeropertyList[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              '${property.title} : ${property.value}',
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'SM',
                                height: 2,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetProductDescription extends StatefulWidget {
  String productDescription;
  GetProductDescription({required this.productDescription, super.key});

  @override
  State<GetProductDescription> createState() => _GetProductDescriptionState();
}

class _GetProductDescriptionState extends State<GetProductDescription> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(right: 44, left: 44, top: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: CustomColors.gery,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Image.asset('images/icon_left_categroy.png'),
                      const SizedBox(width: 10),
                      const Text(
                        'مشاهده',
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 12,
                          color: CustomColors.blue,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'توضیحات محصول',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 14.0,
                          color: CustomColors.gery,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: CustomColors.gery,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.productDescription,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      height: 1.8,
                      fontFamily: 'SM',
                      fontSize: 16,
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
}

class VariantContainerGenerator extends StatelessWidget {
  List<ProductVariants> productVariantList;

  VariantContainerGenerator({required this.productVariantList, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        right: 44,
        left: 44,
        top: 20,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var productVariant in productVariantList) ...{
              if (productVariant.variantList.isNotEmpty) ...{
                VariantGeneratorChild(productvariant: productVariant),
              },
            },
          ],
        ),
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  ProductVariants productvariant;

  VariantGeneratorChild({required this.productvariant, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productvariant.variantType.title,
            style: const TextStyle(
              fontFamily: 'SM',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          if (productvariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(variantList: productvariant.variantList),
          },
          if (productvariant.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantList(storageVariant: productvariant.variantList),
          },
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  List<ProductImage> productImageList;
  String defualtProductThumbnail;

  int selectedItem = 0;

  GalleryWidget({
    required this.defualtProductThumbnail,
    required this.productImageList,
    super.key,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 284.0,
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
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/icon_star.png'),
                          const SizedBox(width: 2),
                          const Text(
                            '۴.۶',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: CachedImage(
                          imageUrl: (widget.productImageList.isEmpty)
                              ? widget.defualtProductThumbnail
                              : widget.productImageList[widget.selectedItem]
                                  .imageUrl,
                        ),
                      ),
                      const Spacer(),
                      Image.asset('images/icon_favorite_deactive.png'),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 70.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 44.0,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productImageList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedItem = index;
                            });
                          },
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            margin: const EdgeInsets.only(left: 20.0),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: CustomColors.gery,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: CachedImage(
                              imageUrl: widget.productImageList[index].imageUrl,
                              radius: 15,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              },
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;

  ColorVariantList({required this.variantList, super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selecetedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String categoryColor = 'ff${widget.variantList[index].value}';
            int hexColor = int.parse(categoryColor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selecetedIndex = index;
                });
              },
              child: Container(
                height: 30.0,
                width: 30.0,
                margin: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: (_selecetedIndex == index)
                      ? Border.all(
                          width: 2,
                          color: Color(hexColor),
                          strokeAlign: BorderSide.strokeAlignOutside,
                        )
                      : Border.all(
                          width: 2,
                          color: Colors.transparent,
                        ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: Container(
                  height: 26.0,
                  width: 26.0,
                  decoration: BoxDecoration(
                    color: Color(hexColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariant;
  StorageVariantList({required this.storageVariant, super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selecetedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageVariant.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selecetedIndex = index;
                });
              },
              child: Container(
                height: 26.0,
                margin: const EdgeInsets.only(left: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: (_selecetedIndex == index)
                      ? Border.all(
                          width: 3,
                          color: CustomColors.blue,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        )
                      : Border.all(
                          width: 0.5,
                          color: CustomColors.gery,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.storageVariant[index].value,
                    style: const TextStyle(
                      fontFamily: 'SB',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
