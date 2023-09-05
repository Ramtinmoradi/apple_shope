import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/category/category_event.dart';
import 'package:apple_shop/bloc/category/category_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/widgets/cached_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _getAppBar(),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
              if (state is CategoryLoadingState) {
                return const SliverToBoxAdapter(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryResponseState) {
                return state.response.fold((l) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(l),
                    ),
                  );
                }, (r) {
                  return GetListOfCategory(list: r);
                });
              }
              return const SliverToBoxAdapter(
                child: Text('error'),
              );
            }),
          ],
        ),
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
          'دسته بندی',
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

class GetListOfCategory extends StatelessWidget {
  List<Category>? list;
  GetListOfCategory({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CachedImage(
              imageUrl: list?[index].thumbnail ?? 'test',
              radius: 15.0,
            );
          },
          childCount: list?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
