import 'package:apple_shop/bloc/categoryProduct/category_product_bloc.dart';
import 'package:apple_shop/bloc/categoryProduct/category_product_event.dart';
import 'package:apple_shop/bloc/categoryProduct/category_product_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  Category category;

  ProductListScreen({required this.category, super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context).add(
      CategoryProductInitializeEvent(widget.category.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CustomColors.backgroundScreenColor,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
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
                          const Image(
                            image: AssetImage('images/icon_apple_blue.png'),
                          ),
                          const Spacer(),
                          Text(
                            widget.category.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: CustomColors.blue,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is CategoryProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                },
                if (state is CategoryProductResponseSuccessState) ...{
                  state.productListByCategory.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    },
                    (productList) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ProductItem(
                                product: productList[index],
                              );
                            },
                            childCount: productList.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 2.8,
                            crossAxisCount: 2,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 20,
                          ),
                        ),
                      );
                    },
                  ),
                },
              ],
            ),
          ),
        );
      },
    );
  }
}
