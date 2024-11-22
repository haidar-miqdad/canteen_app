import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/dataresource/product_remote_datasource.dart';
import '../../../../data/model/response/product_response_model.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  List<Product> products = [];
  ProductBloc(this.productRemoteDatasource) : super(ProductInitial()) {
    on<ProductFetched>((event, emit) async {
      emit(ProductLoading());
      final response = await productRemoteDatasource.getProducts();
      response.fold(
        (l) => emit(ProductFailure(message: l)),
        (r) {
          products = r.product;
          emit(ProductSuccess(r.product),);
        }
      );
    });

    on<ProductCategoryFetched>((event, emit) async {
      emit(ProductLoading());
      final response = await productRemoteDatasource.getProducts();
      final filteredProducts = event.category == 'all' ? products : products
          .where((product) => product.category == event.category)
          .toList();

      response.fold(
        (l) => emit(ProductFailure(message: l)),
        (r) {
          emit(ProductSuccess(filteredProducts),);
        }
      );
    });

  }
}