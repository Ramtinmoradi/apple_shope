import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productDetailRepository = locator.get();

  ProductBloc() : super(ProductDetailInitState()) {
    on<ProductInitializeEvent>(
      (event, emit) async {
        emit(ProductDetailLoadingState());
        var productImage =
            await _productDetailRepository.getProductImage(event.productId);
        var productVariant =
            await _productDetailRepository.getProductVariants(event.productId);
        var productCategory =
            await _productDetailRepository.getProductCategory(event.categoryId);
        var productPeroperties = await _productDetailRepository
            .getProductPeroperties(event.productId);

        emit(
          ProductDetailResponseState(
            productImage,
            productVariant,
            productCategory,
            productPeroperties,
          ),
        );
      },
    );
  }
}
