import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/models/update_product.dart';
import 'package:store_app/shared/cubit/cubit.dart';
import 'package:store_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit, StoreStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(
              'New trends',
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.cartPlus,
                ),
              ),
            ],
          ),
          body: BlocConsumer<StoreCubit, StoreStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition: StoreCubit.get(context).products.isNotEmpty,
                builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: 1 / 1.37,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        StoreCubit.get(context).products.length,
                        (index) => buildGridProduct(
                            StoreCubit.get(context).products[index], context),
                      ),
                    ),
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildGridProduct(ProductModel? model, context) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProductScreen(
                  productModel: model!,
                ),
              ));
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage('${model?.image}'),
                  width: double.infinity,
                  height: 150,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${model?.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(children: [
                  Text(
                    '${model?.price} \$',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(
                      (Icons.favorite),
                      color: Colors.grey,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      );
}
