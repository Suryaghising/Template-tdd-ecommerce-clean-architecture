import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/routes/route_constants.dart';
import 'package:template/presentation/features/home/bloc/all_categories/category_cubit.dart';
import 'package:template/presentation/features/home/bloc/delete_category/delete_category_cubit.dart';
import 'package:template/presentation/widgets/custom_dialog.dart';
import 'package:template/presentation/widgets/responsive_text.dart';
import 'package:template/utils/util.dart';

import '../../../../domain/entities/category.dart';
import '../../../widgets/custom_pop_up_menu.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, Routes.kAddCategory).then((category) {
            if (category != null) {
              context.read<CategoryCubit>().getCategories();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const ResponsiveText(
          'Home',
          textColor: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              child: const Icon(Icons.shop),
              onTap: () {
                Navigator.pushNamed(context, Routes.kMarketPlaceProfileList);
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
            if(state.categoryList.isEmpty) {
              return const Center(child: ResponsiveText('No categories found.'),);
            }
            return BlocListener<DeleteCategoryCubit, DeleteCategoryState>(
              listener: (context, deleteCategoryState) {
                if (deleteCategoryState is DeleteCategorySuccess) {
                  context.read<CategoryCubit>().getCategories();
                } else if (deleteCategoryState is DeleteCategoryFailure) {
                  const snackbar = SnackBar(content: ResponsiveText('Failure'));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              child: GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: kHorizontalMargin / 2,
                    vertical: kVerticalMargin / 2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  final category = state.categoryList[index];
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.kProductList,
                              arguments: category);
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
                          alignment: Alignment.center,
                          child: ResponsiveText(
                            category.name,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CustomPopupMenuButton(
                          onSelected: (value) =>
                              onMenuItemClicked(context, value, category),
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
                itemCount: state.categoryList.length,
              ),
            );
          } else if (state is CategoryFailure) {
            return Text(state.failure.runtimeType.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void onMenuItemClicked(BuildContext context, int value, Category category) {
    switch (value) {
      case 0:
        Navigator.pushNamed(context, Routes.kUpdateCategory,
                arguments: category)
            .then((category) {
          if (category != null) {
            print('i am updated===');
            context.read<CategoryCubit>().getCategories();
          }
        });
        break;

      case 1:
        CustomDialog.showCustomActionDialog(context, onTap: () {
          context.read<DeleteCategoryCubit>().deleteCategory(category.id);
        },
            negativeText: 'No',
            positiveText: 'Delete',
            title: 'Do you want to delete the category?');
    }
  }
}
