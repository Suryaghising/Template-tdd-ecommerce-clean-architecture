import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/presentation/features/market_place/update_market_place_profile/bloc/update_market_place_profile_cubit.dart';
import 'package:template/presentation/widgets/CustomButton.dart';
import 'package:template/presentation/widgets/responsive_text.dart';

import '../../../../widgets/custom_text_field.dart';

class UpdateMarketPlaceProfileView extends StatefulWidget {
  const UpdateMarketPlaceProfileView({super.key, required this.marketPlaceProfile});

  final MarketPlaceProfile marketPlaceProfile;

  @override
  State<UpdateMarketPlaceProfileView> createState() => _UpdateMarketPlaceProfileViewState();
}

class _UpdateMarketPlaceProfileViewState extends State<UpdateMarketPlaceProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController logoUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.marketPlaceProfile.name;
    sellerIdController.text = widget.marketPlaceProfile.sellerId.toString();
    descriptionController.text = widget.marketPlaceProfile.description;
    logoUrlController.text = widget.marketPlaceProfile.logoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ResponsiveText(
          'Update Marketplace Profile',
          textColor: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
          child: BlocListener<UpdateMarketPlaceProfileCubit, UpdateMarketPlaceProfileState>(
            listener: (context, state) {
              if (state is UpdateMarketPlaceProfileFailure) {
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
              } else if (state is UpdateMarketPlaceProfileSuccess) {
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
                  BlocBuilder<UpdateMarketPlaceProfileCubit, UpdateMarketPlaceProfileState>(
                    builder: (context, updateProductState) {
                      if (updateProductState is UpdateMarketPlaceProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                          onPressed: () {
                            context.read<UpdateMarketPlaceProfileCubit>().updateMarketPlaceProfile(
                                nameController.text.trim(),
                                sellerIdController.text.trim(),
                                descriptionController.text.trim(),
                                logoUrlController.text.trim(), widget.marketPlaceProfile);
                          },
                          text: 'Update Marketplace Profile');
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
