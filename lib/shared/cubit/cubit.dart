import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/shared/cubit/states.dart';
import 'package:store_app/shared/network/remote/dio_helper.dart';

class StoreCubit extends Cubit<StoreStates> {
  StoreCubit() : super(StoreInitialState());

  static StoreCubit get(context) => BlocProvider.of(context);

  List<ProductModel> products = [];
  ProductModel? productModel;

  void getAllProducts() {
    emit(StoreGetProductsLoadingState());
    DioHelper.getData(
      url: 'products',
    ).then((value) {
      List<dynamic> data = value.data;
      // productModel=ProductModel.fromJson(value.data);
      for (int i = 0; i < data.length; i++) {
        products.add(ProductModel.fromJson(data[i]));
      }
      // print(products[1].rating!.rate);
      emit(StoreGetProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StoreGetProductsErrorState());
    });
  }

  List<String> categories = [];

  void getAllCategories() {
    emit(StoreGetCategoriesLoadingState());
    DioHelper.getData(
      url: 'products/categories',
    ).then((value) {
      List<dynamic> data = value.data;
      for (int i = 0; i < data.length; i++) {
        categories.add(data[i]);
      }
      // print(categories);
      emit(StoreGetCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StoreGetCategoriesErrorState());
    });
  }

  List<ProductModel> categoryProducts = [];

  void getCategoryProducts({required String categoryName}) {
    emit(StoreGetProductsLoadingState());
    DioHelper.getData(
      url: 'products/category/$categoryName',
    ).then((value) {
      List<dynamic> data = value.data;
      for (int i = 0; i < data.length; i++) {
        categoryProducts.add(ProductModel.fromJson(data[i]));
      }
      print(categoryProducts[0].title);
      emit(StoreGetProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StoreGetProductsErrorState());
    });
  }

  // ProductModel? productModelAdded;
  void addProduct({
    required String title,
    required double price,
    required String description,
    required String image,
    required String category,
  }) {
    emit(StoreAddProductLoadingState());
    DioHelper.postData(url: 'products', data: {
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    }).then((value) {
      print(value.data);
      //  productModelAdded=ProductModel.fromJson(value.data);
      // print(productModelAdded?.title);
      emit(StoreAddProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StoreAddProductErrorState());
    });
  }

  void updateProduct({
    required int id,
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
  }) {
    emit(StoreUpdateProductLoadingState());
    DioHelper.putData(url: 'products/${id}', data: {
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    }).then((value) {
      print(value.data);
      //  productModelAdded=ProductModel.fromJson(value.data);
      // print(productModelAdded?.title);
      emit(StoreUpdateProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StoreUpdateProductErrorState());
    });
  }

  File? productImage;
  var productImagePicker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await productImagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      productImage = File(pickedFile.path);

      emit(StoreGetProductImageSuccessState());
    } else {
      print('no image selected');
      emit(StoreGetProductImageErrorState());
    }
  }

  void removeImage() {
    productImage = null;
    emit(StoreRemoveProductImageState());
  }
}
