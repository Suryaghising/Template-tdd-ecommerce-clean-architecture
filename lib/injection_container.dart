import 'package:get_it/get_it.dart';
import 'package:template/data/datasources/category_remote_data_source.dart';
import 'package:template/data/datasources/comment_remote_data_source.dart';
import 'package:template/data/datasources/market_place_profile_remote_data_source.dart';
import 'package:template/data/datasources/product_remote_data_source.dart';
import 'package:template/data/repositories/category_repository_impl.dart';
import 'package:template/data/repositories/comment_repository_impl.dart';
import 'package:template/data/repositories/my_market_place_profile_repository_impl.dart';
import 'package:template/data/repositories/product_repository_impl.dart';
import 'package:template/domain/repositories/category_repository.dart';
import 'package:template/domain/repositories/comment_repository.dart';
import 'package:template/domain/repositories/my_market_place_profile_repository.dart';
import 'package:template/domain/repositories/product_repository.dart';
import 'package:template/domain/usecases/categories/add_category_usecase.dart';
import 'package:template/domain/usecases/categories/delete_category_usecase.dart';
import 'package:template/domain/usecases/categories/fetch_category_usecase.dart';
import 'package:template/domain/usecases/categories/update_category_usecase.dart';
import 'package:template/domain/usecases/comments/create_comment_usecase.dart';
import 'package:template/domain/usecases/comments/delete_comment_usecase.dart';
import 'package:template/domain/usecases/comments/find_comments_by_product_id_usecase.dart';
import 'package:template/domain/usecases/comments/report_comment_usecase.dart';
import 'package:template/domain/usecases/comments/update_comment_usecase.dart';
import 'package:template/domain/usecases/marketplace/add_my_market_place_profile_usecase.dart';
import 'package:template/domain/usecases/marketplace/find_my_market_place_profile_usecase.dart';
import 'package:template/domain/usecases/marketplace/update_my_market_place_profile_usecase.dart';
import 'package:template/domain/usecases/products/add_product_usecase.dart';
import 'package:template/domain/usecases/products/delete_product_usecase.dart';
import 'package:template/domain/usecases/products/fetch_all_products_usecase.dart';
import 'package:template/domain/usecases/products/update_product_usecase.dart';
import 'package:template/presentation/features/comments/all_comments/bloc/add_update_comment/add_update_comment_cubit.dart';
import 'package:template/presentation/features/comments/all_comments/bloc/all_comment_cubit.dart';
import 'package:template/presentation/features/home/bloc/all_categories/category_cubit.dart';
import 'package:template/presentation/features/home/bloc/delete_category/delete_category_cubit.dart';
import 'package:template/presentation/features/market_place/add_market_place_profile/bloc/add_market_place_profile_cubit.dart';
import 'package:template/presentation/features/market_place/my_market_place_profiles/bloc/my_market_place_profiles_cubit.dart';
import 'package:template/presentation/features/market_place/update_market_place_profile/bloc/update_market_place_profile_cubit.dart';
import 'package:template/presentation/features/product/add_product/bloc/add_product_cubit.dart';
import 'package:template/presentation/features/product/all_products/bloc/all_products/all_products_cubit.dart';
import 'package:template/presentation/features/product/all_products/bloc/delete_product/delete_product_cubit.dart';
import 'package:template/presentation/features/product/update_product/bloc/update_product_cubit.dart';

import './core/routes/app_router.dart';
import 'core/services/dummy_category_service.dart';
import 'core/services/dummy_comment_service.dart';
import 'core/services/dummy_market_place_profile_service.dart';
import 'core/services/dummy_product_service.dart';
import 'presentation/features/category/add_category/bloc/add_category_cubit.dart';
import 'presentation/features/category/update_category/bloc/update_category_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // app router
  sl.registerLazySingleton(() => AppRouter());

  // bloc
  sl.registerFactory(() => CategoryCubit(sl()));
  sl.registerFactory(() => AddCategoryCubit(sl()));
  sl.registerFactory(() => UpdateCategoryCubit(sl()));
  sl.registerFactory(() => DeleteCategoryCubit(sl()));

  sl.registerFactory(() => AllProductsCubit(sl()));
  sl.registerFactory(() => DeleteProductCubit(sl()));
  sl.registerFactory(() => AddProductCubit(sl()));
  sl.registerFactory(() => UpdateProductCubit(sl()));

  sl.registerFactory(() => MyMarketPlaceProfileCubit(sl()));
  sl.registerFactory(() => AddMarketPlaceProfileCubit(sl()));
  sl.registerFactory(() => UpdateMarketPlaceProfileCubit(sl()));

  sl.registerFactory(() => AllCommentCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AddUpdateCommentCubit(sl(), sl()));

  // usecases
  sl.registerLazySingleton(() => FetchCategoryUsecase(sl()));
  sl.registerLazySingleton(() => AddCategoryUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUsecase(sl()));

  sl.registerLazySingleton(() => FetchAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));

  sl.registerLazySingleton(() => FindMyMarketPlaceProfileUsecase(sl()));
  sl.registerLazySingleton(() => AddMyMarketPlaceProfileUsecase(sl()));
  sl.registerLazySingleton(() => UpdateMyMarketPlaceProfileUsecase(sl()));

  sl.registerLazySingleton(() => FindCommentsByProductIdUsecase(sl()));
  sl.registerLazySingleton(() => CreateCommentUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCommentUsecase(sl()));
  sl.registerLazySingleton(() => ReportCommentUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCommentUsecase(sl()));

  // repositories
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));

  sl.registerLazySingleton<MyMarketPlaceProfileRepository>(
      () => MyMarketPlaceProfileRepositoryImpl(sl()));

  sl.registerLazySingleton<CommentRepository>(() => CommentRepositoryImpl(sl()));

  // datasources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<MarketPlaceProfileRemoteDataSource>(
      () => MarketPlaceProfileRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<CommentRemoteDataSource>(() => CommentRemoteDataSourceImpl(sl()));

  // core
  sl.registerLazySingleton<DummyCategoryService>(
      () => DummyCategoryServiceImpl());

  sl.registerLazySingleton<DummyProductService>(
      () => DummyProductServiceImpl());

  sl.registerLazySingleton<DummyMarketPlaceProfileService>(
      () => DummyMarketPlaceProfileServiceImpl());

  sl.registerLazySingleton<DummyCommentService>(() => DummyCommentServiceImpl());
}
