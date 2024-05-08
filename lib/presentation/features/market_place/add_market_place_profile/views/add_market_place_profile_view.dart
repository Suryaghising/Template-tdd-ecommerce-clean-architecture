import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/presentation/features/market_place/add_market_place_profile/bloc/add_market_place_profile_cubit.dart';
import 'package:template/presentation/widgets/CustomButton.dart';
import 'package:template/presentation/widgets/responsive_text.dart';

import '../../../../widgets/custom_text_field.dart';

class AddMarketPlaceProfileView extends StatefulWidget {
  const AddMarketPlaceProfileView({super.key});

  @override
  State<AddMarketPlaceProfileView> createState() => _AddMarketPlaceProfileViewState();
}

class _AddMarketPlaceProfileViewState extends State<AddMarketPlaceProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController logoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ResponsiveText(
          'Add Marketplace Profile',
          textColor: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
          child: BlocListener<AddMarketPlaceProfileCubit, AddMarketPlaceProfileState>(
            listener: (context, state) {
              if (state is AddMarketPlaceProfileFailure) {
                String message = '';
                if (state.failure is ValidationFailure) {
                  message = (state.failure as ValidationFailure).message;
                } else if (state.failure is DuplicateEntryFailure) {
                  message = 'Seller with given id already has a marketplace profile.';
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
              } else if (state is AddMarketPlaceProfileSuccess) {
                Navigator.pop(context, state.marketPlaceProfile);
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
                    hintText: 'Enter seller id',
                    controller: sellerIdController,
                    inputType: TextInputType.number,
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
                    controller: logoUrlController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<AddMarketPlaceProfileCubit, AddMarketPlaceProfileState>(
                    builder: (context, addProductState) {
                      if (addProductState is AddMarketPlaceProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                          onPressed: () {
                            context.read<AddMarketPlaceProfileCubit>().addMarketPlaceProfile(
                                nameController.text.trim(),
                                sellerIdController.text.trim(),
                                descriptionController.text.trim(),
                                logoUrlController.text.trim());
                          },
                          text: 'Add Marketplace Profile');
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
