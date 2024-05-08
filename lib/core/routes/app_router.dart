import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/presentation/features/category/add_category/bloc/add_category_cubit.dart';
import 'package:template/presentation/features/category/add_category/views/add_category_view.dart';
import 'package:template/presentation/features/category/update_category/bloc/update_category_cubit.dart';
import 'package:template/presentation/features/category/update_category/views/update_category_view.dart';
import 'package:template/presentation/features/comments/all_comments/bloc/add_update_comment/add_update_comment_cubit.dart';
import 'package:template/presentation/features/comments/all_comments/bloc/all_comment_cubit.dart';
import 'package:template/presentation/features/comments/all_comments/views/all_comments_view.dart';
import 'package:template/presentation/features/home/bloc/all_categories/category_cubit.dart';
import 'package:template/presentation/features/home/bloc/delete_category/delete_category_cubit.dart';
import 'package:template/presentation/features/home/views/home_view.dart';
import 'package:template/presentation/features/market_place/add_market_place_profile/bloc/add_market_place_profile_cubit.dart';
import 'package:template/presentation/features/market_place/add_market_place_profile/views/add_market_place_profile_view.dart';
import 'package:template/presentation/features/market_place/my_market_place_profiles/bloc/my_market_place_profiles_cubit.dart';
import 'package:template/presentation/features/market_place/update_market_place_profile/bloc/update_market_place_profile_cubit.dart';
import 'package:template/presentation/features/market_place/update_market_place_profile/views/update_market_place_profile_view.dart';
import 'package:template/presentation/features/product/add_product/views/add_product_view.dart';
import 'package:template/presentation/features/product/all_products/bloc/all_products/all_products_cubit.dart';
import 'package:template/presentation/features/product/all_products/bloc/delete_product/delete_product_cubit.dart';
import 'package:template/presentation/features/product/all_products/views/all_product_view.dart';
import 'package:template/presentation/features/product/update_product/bloc/update_product_cubit.dart';
import 'package:template/presentation/features/product/update_product/views/update_product_view.dart';

import '../../domain/entities/product.dart';
import '../../injection_container.dart';
import '../../presentation/features/market_place/my_market_place_profiles/views/my_market_place_profiles_view.dart';
import '../../presentation/features/product/add_product/bloc/add_product_cubit.dart';
import '../../presentation/features/splash/views/splash_view.dart';
import 'route_constants.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kRoot:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashView());

      case Routes.kHome:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<CategoryCubit>()..getCategories(),
                    ),
                    BlocProvider(
                      create: (context) => sl<DeleteCategoryCubit>(),
                    ),
                  ],
                  child: const HomeView(),
                ));

      case Routes.kAddCategory:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<AddCategoryCubit>(),
                  child: const AddCategoryView(),
                ));

      case Routes.kUpdateCategory:
        final category = settings.arguments as Category;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<UpdateCategoryCubit>(),
                  child: UpdateCategoryView(category: category),
                ));

      case Routes.kProductList:
        final category = settings.arguments as Category;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          sl<AllProductsCubit>()..getAllProducts(),
                    ),
                    BlocProvider(
                      create: (context) => sl<DeleteProductCubit>(),
                    ),
                  ],
                  child: AllProductView(category: category),
                ));

      case Routes.kAddProduct:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<AddProductCubit>(),
                  child: const AddProductView(),
                ));

      case Routes.kUpdateProduct:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<UpdateProductCubit>(),
                  child: UpdateProductView(product: product),
                ));

      case Routes.kMarketPlaceProfileList:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<MyMarketPlaceProfileCubit>()
                    ..getMyMarketPlaceProfiles(1),
                  child: const MyMarketPlaceProfilesView(),
                ));

      case Routes.kAddMarketPlaceProfile:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<AddMarketPlaceProfileCubit>(),
                  child: const AddMarketPlaceProfileView(),
                ));

      case Routes.kUpdateMarketPlaceProfile:
        final marketPlaceProfile = settings.arguments as MarketPlaceProfile;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<UpdateMarketPlaceProfileCubit>(),
                  child: UpdateMarketPlaceProfileView(
                      marketPlaceProfile: marketPlaceProfile),
                ));

      case Routes.kAllComments:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<AllCommentCubit>()
                        ..getCommentsByProductId(product.id),
                    ),
                    BlocProvider(
                      create: (context) => sl<AddUpdateCommentCubit>(),
                    ),
                  ],
                  child: AllCommentsView(product: product),
                ));

      default:
        return null;
    }
  }
}
