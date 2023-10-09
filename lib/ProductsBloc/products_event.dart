part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

// class UpdateProducts extends ProductsEvent {
//   final List<Product> newProducts;

//   UpdateProducts({required this.newProducts});
// }

class FetchAndLoadProducts extends ProductsEvent {
  
}