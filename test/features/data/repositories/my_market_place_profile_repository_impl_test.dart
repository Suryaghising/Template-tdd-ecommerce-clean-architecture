import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/datasources/market_place_profile_remote_data_source.dart';
import 'package:template/data/models/market_place_profile_model.dart';
import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/data/repositories/my_market_place_profile_repository_impl.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/domain/repositories/my_market_place_profile_repository.dart';

class MockMarketPlaceProfileRemoteDataSource extends Mock implements MarketPlaceProfileRemoteDataSource {}

void main() {
  late MockMarketPlaceProfileRemoteDataSource mockMarketPlaceProfileRemoteDataSource;
  late MyMarketPlaceProfileRepository myMarketPlaceProfileRepository;

  setUp(() {
    mockMarketPlaceProfileRemoteDataSource = MockMarketPlaceProfileRemoteDataSource();
    myMarketPlaceProfileRepository = MyMarketPlaceProfileRepositoryImpl(mockMarketPlaceProfileRemoteDataSource);
  });

  group('getMyMarketPlaceProfile', () {

    const marketPlaceProfileModel = MarketPlaceProfileModel(id: 1, sellerId: 1, name: 'Test Name', description: 'Test Description', logoUrl: 'Test Logo');
    MarketPlaceProfile marketPlaceProfile = marketPlaceProfileModel;

    test('should return myMarketPlaceProfile when the call to remote data source is success', () async{
      // arrange
      when(() => mockMarketPlaceProfileRemoteDataSource.getMyMarketPlaceProfile(any()))
          .thenAnswer((_) async => marketPlaceProfileModel);
      // act
      final result = await myMarketPlaceProfileRepository.getMyMarketPlaceProfile(1);
      // assert
      expect(result, Right(marketPlaceProfile));
      verify(() => mockMarketPlaceProfileRemoteDataSource.getMyMarketPlaceProfile(any())).called(1);
      verifyNoMoreInteractions(mockMarketPlaceProfileRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockMarketPlaceProfileRemoteDataSource.getMyMarketPlaceProfile(any()))
          .thenThrow(ServerException());
      // act
      final result = await myMarketPlaceProfileRepository.getMyMarketPlaceProfile(1);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the marketPlaceProfile with given id is not found', () async{
      // arrange
      when(() => mockMarketPlaceProfileRemoteDataSource.getMyMarketPlaceProfile(any()))
          .thenThrow(NotFoundException());
      // act
      final result = await myMarketPlaceProfileRepository.getMyMarketPlaceProfile(1);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });

  group('addMyMarketPlaceProfile', () {


    final marketPlaceProfileRequest = MarketPlaceProfileRequestModel(sellerId: 1, name: 'Test Name', description: 'Test Description', logoUrl: 'Test Logo');
    const marketPlaceModel = MarketPlaceProfileModel(id: 1, sellerId: 1, name: 'Test Name', description: 'Test Description', logoUrl: 'Test Logo');
    MarketPlaceProfile marketPlaceProfile = marketPlaceModel;

    test('should add and return marketPlaceProfile with id when the call to remote data source is success', () async{
      // arrange
      when(() => mockMarketPlaceProfileRemoteDataSource.addMyMarketPlaceProfile(marketPlaceProfileRequest))
          .thenAnswer((_) async => marketPlaceModel);
      // act
      final result = await myMarketPlaceProfileRepository.addMyMarketPlaceProfile(marketPlaceProfileRequest);
      // assert
      expect(result, Right(marketPlaceProfile));
      verify(() => mockMarketPlaceProfileRemoteDataSource.addMyMarketPlaceProfile(marketPlaceProfileRequest)).called(1);
      verifyNoMoreInteractions(mockMarketPlaceProfileRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockMarketPlaceProfileRemoteDataSource.addMyMarketPlaceProfile(marketPlaceProfileRequest))
          .thenThrow(ServerException());
      // act
      final result = await myMarketPlaceProfileRepository.addMyMarketPlaceProfile(marketPlaceProfileRequest);
      // assert
      expect(result, const Left(ServerFailure()));
    });
  });

  group('updateMyMarketPlaceProfile', () {
    const marketPlaceProfileRequest = MarketPlaceProfile(id: 1, sellerId: 1, name: 'Test Name', description: 'Test Description', logoUrl: 'Test Logo');
    const marketPlaceProfileModel = MarketPlaceProfileModel(id: 1, sellerId: 1, name: 'Test Name', description: 'Updated Description', logoUrl: 'Updated Logo');
    MarketPlaceProfile marketPlaceProfileResponse = marketPlaceProfileModel;

    test('should update and return marketPlaceProfile when the call to remote data source is success', () async{
      // arrange
      when(() => mockMarketPlaceProfileRemoteDataSource.updateMarketPlaceProfile(marketPlaceProfileRequest))
          .thenAnswer((_) async => marketPlaceProfileModel);
      // act
      final result = await myMarketPlaceProfileRepository.updateMarketPlaceProfile(marketPlaceProfileRequest);
      // assert
      expect(result, Right(marketPlaceProfileResponse));
      verify(() => mockMarketPlaceProfileRemoteDataSource.updateMarketPlaceProfile(marketPlaceProfileRequest)).called(1);
      verifyNoMoreInteractions(mockMarketPlaceProfileRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockMarketPlaceProfileRemoteDataSource.updateMarketPlaceProfile(marketPlaceProfileRequest))
          .thenThrow(ServerException());
      // act
      final result = await myMarketPlaceProfileRepository.updateMarketPlaceProfile(marketPlaceProfileRequest);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the marketPlaceProfile with given id is not found', () async{
      // arrange
      when(() => mockMarketPlaceProfileRemoteDataSource.updateMarketPlaceProfile(marketPlaceProfileRequest))
          .thenThrow(NotFoundException());
      // act
      final result = await myMarketPlaceProfileRepository.updateMarketPlaceProfile(marketPlaceProfileRequest);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });
}