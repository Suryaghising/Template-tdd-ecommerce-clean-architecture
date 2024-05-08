import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/routes/route_constants.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/presentation/features/product/all_products/bloc/all_products/all_products_cubit.dart';
import 'package:template/presentation/features/product/all_products/bloc/delete_product/delete_product_cubit.dart';

import '../../../../../utils/util.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/custom_pop_up_menu.dart';
import '../../../../widgets/responsive_text.dart';

class AllProductView extends StatelessWidget {
  const AllProductView({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          category.name,
          fontSize: 20,
          textColor: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, Routes.kAddProduct).then((value) {
          if(value != null) {
            context.read<AllProductsCubit>().getAllProducts();
          }
        });
      }, child: const Icon(Icons.add),),
      body: SafeArea(child: BlocBuilder<AllProductsCubit, AllProductsState>(
        builder: (context, allProductsState) {
          if (allProductsState is AllProductsLoaded) {
            if(allProductsState.productList.isEmpty) {
              return const Center(child: ResponsiveText('No products added.'),);
            }
            return BlocListener<DeleteProductCubit, DeleteProductState>(
              listener: (context, deleteProductState) {
                if(deleteProductState is DeleteProductSuccess) {
                  context.read<AllProductsCubit>().getAllProducts();
                } else if(deleteProductState is DeleteProductFailure) {
                  final snackbar = SnackBar(content: ResponsiveText(deleteProductState.failure is ServerFailure? 'Server error': 'Something went wrong.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              child: GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: kHorizontalMargin / 2,
                    vertical: kVerticalMargin / 2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2 / 3),
                itemBuilder: (context, index) {
                  final product = allProductsState.productList[index];
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.kAllComments, arguments: product);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                  child: Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveText(
                                      product.name,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    ResponsiveText("Rs. ${product.price}"),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CustomPopupMenuButton(
                          onSelected: (value) =>
                              onMenuItemClicked(context, value, product),
                          itemBuilder: (context) {
                            return [
                              const CustomPopupMenuItem(
                                value: 0,
                                child: ResponsiveText(
                                  'Update',
                                  textColor: Colors.black,
                                ),
                              ),
                              const CustomPopupMenuItem(
                                value: 1,
                                child: ResponsiveText(
                                  'Delete',
                                  textColor: Colors.black,
                                ),
                              )
                            ];
                          },
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.more_vert),
                          iconSize: height * 0.025,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: allProductsState.productList.length,
              ),
            );
          } else if (allProductsState is AllProductsFailure) {
            return ResponsiveText(allProductsState.failure is ServerFailure
                ? 'Server failure'
                : 'Something went wrong.');
          }
          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }

  void onMenuItemClicked(BuildContext context, int value, Product product) {
    switch (value) {
      case 0:
      Navigator.pushNamed(context, Routes.kUpdateProduct,
          arguments: product)
          .then((category) {
        if (category != null) {
          context.read<AllProductsCubit>().getAllProducts();
        }
      });
        break;

      case 1:
        CustomDialog.showCustomActionDialog(context, onTap: () {
          context.read<DeleteProductCubit>().deleteProduct(product.id);
        },
            negativeText: 'No',
            positiveText: 'Delete',
            title: 'Do you want to delete the product?');
    }
  }
}
