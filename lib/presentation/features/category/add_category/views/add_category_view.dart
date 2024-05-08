import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/presentation/features/category/add_category/bloc/add_category_cubit.dart';
import 'package:template/presentation/widgets/CustomButton.dart';
import 'package:template/presentation/widgets/custom_text_field.dart';
import 'package:template/presentation/widgets/responsive_text.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ResponsiveText('Add Category',
            fontWeight: FontWeight.w600, fontSize: 20, textColor: Colors.white),
      ),
      body: BlocListener<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {
          if (state is AddCategoryFailure) {
            String message = '';
            if (state.failure is ValidationFailure) {
              message = (state.failure as ValidationFailure).message;
            } else if(state.failure is DuplicateEntryFailure) {
              message = 'Category with same name already exists';
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
          } else if (state is AddCategorySuccess) {
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
                BlocBuilder<AddCategoryCubit, AddCategoryState>(
                  builder: (context, state) {
                    if(state is AddCategoryLoading) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    return CustomButton(onPressed: () {
                      context.read<AddCategoryCubit>().addCategory(
                          nameController.text.trim(),
                          descriptionController.text.trim());}, text: 'Add Category');
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
