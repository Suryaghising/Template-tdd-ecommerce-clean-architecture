import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/presentation/features/product/add_product/bloc/add_product_cubit.dart';
import 'package:template/presentation/widgets/CustomButton.dart';
import 'package:template/presentation/widgets/responsive_text.dart';

import '../../../../widgets/custom_text_field.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

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
          child: BlocListener<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is AddProductFailure) {
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
          } else if (state is AddProductSuccess) {
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
              BlocBuilder<AddProductCubit, AddProductState>(
                builder: (context, addProductState) {
                  if (addProductState is AddProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CustomButton(
                      onPressed: () {
                        context.read<AddProductCubit>().addProduct(
                            nameController.text.trim(),
                            priceController.text.trim(),
                            descriptionController.text.trim(),
                            imageController.text.trim());
                      },
                      text: 'Add Product');
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
