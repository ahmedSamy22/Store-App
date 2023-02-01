import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/shared/components.dart';
import 'package:store_app/shared/cubit/cubit.dart';
import 'package:store_app/shared/cubit/states.dart';

class UpdateProductScreen extends StatelessWidget {
  ProductModel productModel;
  UpdateProductScreen({required this.productModel});
  var productNameController = TextEditingController();
  var productDescribtionController = TextEditingController();
  var productPriceController = TextEditingController();
  var productImageController = TextEditingController();
  var productCategoryController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit, StoreStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Update product'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                        controller: productNameController,
                        keyboardTybe: TextInputType.text,
                        prefixIcon: FontAwesomeIcons.pen,
                        label: 'Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name can\'t be empty';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                        controller: productDescribtionController,
                        keyboardTybe: TextInputType.text,
                        prefixIcon: Icons.description,
                        label: 'Description',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description can\'t be empty';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                        controller: productPriceController,
                        keyboardTybe: TextInputType.number,
                        prefixIcon: Icons.monetization_on,
                        label: 'Price',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Price can\'t be empty';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                        onPressed: () {
                          StoreCubit.get(context).getImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Update Image'),
                          ],
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (StoreCubit.get(context).productImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 120.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                image: FileImage(
                                    StoreCubit.get(context).productImage!),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              StoreCubit.get(context).removeImage();
                            },
                            icon: CircleAvatar(
                              child: Icon(Icons.close, size: 20.0),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! StoreUpdateProductLoadingState,
                      builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              StoreCubit.get(context).updateProduct(
                                id: productModel.id!,
                                title: productNameController.text.trim(),
                                price: productPriceController.text.trim(),
                                description:
                                    productDescribtionController.text.trim(),
                                image: StoreCubit.get(context)
                                        .productImage
                                        ?.path ??
                                    productModel.image!,
                                category: productModel.category!,
                              );
                            }
                          },
                          width: double.infinity,
                          text: 'Update'),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
