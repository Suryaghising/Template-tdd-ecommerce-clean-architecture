import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/presentation/features/category/update_category/bloc/update_category_cubit.dart';
import 'package:template/presentation/widgets/custom_text_field.dart';
import 'package:template/presentation/widgets/responsive_text.dart';

class UpdateCategoryView extends StatefulWidget {

  final Category category;

  const UpdateCategoryView({super.key, required this.category});

  @override
  State<UpdateCategoryView> createState() => _UpdateCategoryViewState();
}

class _UpdateCategoryViewState extends State<UpdateCategoryView> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.category.name;
    descriptionController.text = widget.category.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ResponsiveText('Update Category',
            fontWeight: FontWeight.w600, fontSize: 20, textColor: Colors.white),
      ),
      body: BlocListener<UpdateCategoryCubit, UpdateCategoryState>(
        listener: (context, state) {
          if (state is UpdateCategoryFailure) {
            String message = '';
            if (state.failure is ValidationFailure) {
              message = (state.failure as ValidationFailure).message;
            } else if(state.failure is DuplicateEntryFailure) {
              message = 'Category with same name already exists.';
            }
            else {
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
          } else if (state is UpdateCategorySuccess) {
            Navigator.pop(context, state.category);
          }
        },
        child: SafeArea(
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
                  hintText: 'Enter description',
                  controller: descriptionController,
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<UpdateCategoryCubit, UpdateCategoryState>(
                  builder: (context, state) {
                    if(state is UpdateCategoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        context.read<UpdateCategoryCubit>().updateCategory(
                            nameController.text.trim(),
                            descriptionController.text.trim(), widget.category);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 12)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                      ),
                      child: const ResponsiveText(
                        'Update category',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
