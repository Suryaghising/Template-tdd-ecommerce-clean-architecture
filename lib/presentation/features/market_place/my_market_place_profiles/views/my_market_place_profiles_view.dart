import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/routes/route_constants.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/presentation/features/market_place/my_market_place_profiles/bloc/my_market_place_profiles_cubit.dart';
import 'package:template/presentation/widgets/CustomButton.dart';
import 'package:template/presentation/widgets/custom_text_field.dart';
import 'package:template/presentation/widgets/responsive_text.dart';
import 'package:template/utils/util.dart';

class MyMarketPlaceProfilesView extends StatelessWidget {
  const MyMarketPlaceProfilesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ResponsiveText(
          'Market Places',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          textColor: Colors.white,
        ),
        actions: [
          Container(margin: const EdgeInsets.only(right: 16),child: GestureDetector(onTap: () {
            showSearchDialog(context, onTap: (input) {
              context.read<MyMarketPlaceProfileCubit>().getMyMarketPlaceProfiles(int.parse(input));
            });
          }, behavior: HitTestBehavior.translucent, child: const Icon(Icons.search),),)
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, Routes.kAddMarketPlaceProfile).then((value) {
          if(value != null) {
            context.read<MyMarketPlaceProfileCubit>().getMyMarketPlaceProfiles((value as MarketPlaceProfile).sellerId);
          }
        });
      }, child: const Icon(Icons.add),),
      body: SafeArea(
        child: BlocBuilder<MyMarketPlaceProfileCubit, MyMarketPlaceProfileState>(
          builder: (context, myMarketPlaceProfileState) {
            if(myMarketPlaceProfileState is MyMarketPlaceProfileLoaded) {
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(children: [
                    Image.network(
                      myMarketPlaceProfileState.marketPlaceProfile.logoUrl,
                      height: height * 0.2,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(top: 16, right: 16,child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.kUpdateMarketPlaceProfile, arguments: myMarketPlaceProfileState.marketPlaceProfile).then((value) {
                          if(value != null) {
                            context.read<MyMarketPlaceProfileCubit>().getMyMarketPlaceProfiles((value as MarketPlaceProfile).sellerId);
                          }
                        });
                      },
                      child: Container(child: Icon(Icons.edit), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1, blurRadius: 1)
                      ]), padding: EdgeInsets.all(12),),
                    ),),
                  ],),
                  const SizedBox(height: 16,),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveText(
                            myMarketPlaceProfileState.marketPlaceProfile.name,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          ResponsiveText(
                            myMarketPlaceProfileState.marketPlaceProfile.description,
                            maxLines: 5,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if(myMarketPlaceProfileState is MyMarketPlaceProfileFailure) {
              return Center(child: ResponsiveText(myMarketPlaceProfileState.failure is NotFoundFailure? 'Market place not found for the given seller id': 'Something went wrong.'),);
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),

    );
  }

  showSearchDialog(
      BuildContext context, {
        required Function(String input) onTap,
      }) {
    showDialog(
        context: context,
        builder: (ctx) {
          final TextEditingController inputController = TextEditingController();
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin:
                  EdgeInsets.symmetric(horizontal: kHorizontalMargin),
                  padding: EdgeInsets.symmetric(
                      vertical: kVerticalMargin,
                      horizontal: kHorizontalMargin),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(hintText: 'Enter seller id', controller: inputController, inputType: TextInputType.number),
                      SizedBox(
                        height: 16,
                      ),
                      CustomButton(onPressed: () {
                        Navigator.pop(ctx);
                        onTap(inputController.text.trim());
                      }, text: 'Search'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
