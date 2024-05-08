import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/presentation/features/product/update_product/bloc/update_product_cubit.dart';
import 'package:template/presentation/widgets/CustomButton.dart';
import 'package:template/presentation/widgets/responsive_text.dart';

import '../../../../widgets/custom_text_field.dart';

class UpdateProductView extends StatefulWidget {
  const UpdateProductView({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductView> createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<UpdateProductView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name;
    priceController.text = widget.product.price.toString();
    descriptionController.text = widget.product.description;
    imageController.text = widget.product.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ResponsiveText(
          'Add Product',
          textColor: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
          child: BlocListener<UpdateProductCubit, UpdateProductState>(
            listener: (context, state) {
              if (state is UpdateProductFailure) {
                String message = '';
                if (state.failure is ValidationFailure) {
                  message = (state.failure as ValidationFailure).message;
                } else if (state.failure is DuplicateEntryFailure) {
                  message = 'Product with same name already exist.';
                } else if (state.failure is ServerFailure) {
                  message = 'Server error.';
                } else {
                  message = 'Something went wrong.';
                }
                final snackbar = SnackBar(
                  content: ResponsiveText(
                    message,
                    textColor: Colors.white,
                  ),
                  backgroundColor: Colors.redAccent,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              } else if (state is UpdateProductSuccess) {
                Navigator.pop(context, state.product);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                      hintText: 'Enter name', controller: nameController),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'Enter price',
                    inputType: TextInputType.number,
                    controller: priceController,

                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'Enter description',
                    controller: descriptionController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'Enter image url',
                    controller: imageController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<UpdateProductCubit, UpdateProductState>(
                    builder: (context, addProductState) {
                      if (addProductState is UpdateProductLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                          onPressed: () {
                            context.read<UpdateProductCubit>().updateProduct(
                                nameController.text.trim(),
                                priceController.text.trim(),
                                descriptionController.text.trim(),
                                imageController.text.trim(), widget.product);
                          },
                          text: 'Update Product');
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
