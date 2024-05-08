import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/services/dummy_market_place_profile_service.dart';
import 'package:template/data/datasources/market_place_profile_remote_data_source.dart';
import 'package:template/data/models/market_place_profile_model.dart';
import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/domain/entities/market_place_profile.dart';

import '../../../fixtures/fixture_reader.dart';

class MockDummyMarketPlaceProfileService extends Mock implements DummyMarketPlaceProfileService {}

void main() {
  late MarketPlaceProfileRemoteDataSource marketPlaceProfileRemoteDataSource;
  late MockDummyMarketPlaceProfileService mockDummyMarketPlaceProfileService;

  setUp(() {
    mockDummyMarketPlaceProfileService = MockDummyMarketPlaceProfileService();
    marketPlaceProfileRemoteDataSource = MarketPlaceProfileRemoteDataSourceImpl(mockDummyMarketPlaceProfileService);
  });

  group('fetchMyMarketPlace', () {

    MarketPlaceProfileModel marketPlaceProfileModel = MarketPlaceProfileModel.fromJson(jsonDecode(fixture('my_market_place_profile.json')));

    test('should return myMarketPlaceProfile with matching id from dummy data', () async{
      // arrange
      when(() => mockDummyMarketPlaceProfileService.getMyMarketPlaceProfile(any()))
          .thenAnswer((_) => jsonDecode(fixture('my_market_place_profile.json')));
      // act
      final result = await marketPlaceProfileRemoteDataSource.getMyMarketPlaceProfile(1);
      // assert
      expect(result, marketPlaceProfileModel);
    });

    test('should throw not found exception when myMarketPlaceProfile with matching id is not found', () async {
      // arrange
      when(() => mockDummyMarketPlaceProfileService.getMyMarketPlaceProfile(any()))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await marketPlaceProfileRemoteDataSource.getMyMarketPlaceProfile(1), throwsA(isA<NotFoundException>()));
    });
  });

  group('addMarketPlaceProfile', () {

    Map<String, dynamic> response = jsonDecode(fixture('my_market_place_profile.json'));
    final marketPlaceProfileRequest = MarketPlaceProfileRequestModel(sellerId: 1, name: 'Test Name', description: 'Test Description', logoUrl: 'Test Logo');
    MarketPlaceProfileModel marketPlaceProfileModel = MarketPlaceProfileModel.fromJson(jsonDecode(fixture('my_market_place_profile.json')));

    test('should return marketPlaceProfile with id after adding data into dummy data', () async{
      // arrange
      when(() => mockDummyMarketPlaceProfileService.addMyMarketPlaceProfile(MarketPlaceProfileRequestModel.toJson(marketPlaceProfileRequest)))
          .thenAnswer((_) => response);
      // act
      final result = await marketPlaceProfileRemoteDataSource.addMyMarketPlaceProfile(marketPlaceProfileRequest);
      // assert
      expect(result, marketPlaceProfileModel);
    });

    test('should throw duplicate entry exception when marketPlaceProfile name already exists', () async {
      // arrange
      when(() => mockDummyMarketPlaceProfileService.addMyMarketPlaceProfile(MarketPlaceProfileRequestModel.toJson(marketPlaceProfileRequest)))
          .thenThrow(DuplicateEntryException());
      // act & assert
      expect(() async => await marketPlaceProfileRemoteDataSource.addMyMarketPlaceProfile(marketPlaceProfileRequest), throwsA(isA<DuplicateEntryException>()));
    });
  });

  group('updateMyMarketPlaceProfile', () {
    Map<String, dynamic> response = jsonDecode(fixture('my_market_place_profile.json'));
    const marketPlaceProfileRequest = MarketPlaceProfile(id: 1, sellerId: 1, name: 'Test Name', description: 'Updated Description', logoUrl: 'Updated Logo');
    final marketPlaceProfileModelRequest = MarketPlaceProfileModel(id: marketPlaceProfileRequest.id, sellerId: marketPlaceProfileRequest.sellerId, name: marketPlaceProfileRequest.name, description: marketPlaceProfileRequest.description, logoUrl: marketPlaceProfileRequest.logoUrl);
    MarketPlaceProfileModel marketPlaceProfileModel = MarketPlaceProfileModel.fromJson(jsonDecode(fixture('my_market_place_profile.json')));

    test('should update and return marketPlaceProfile after updating data into dummy data', () async{
      // arrange
      when(() => mockDummyMarketPlaceProfileService.updateMarketPlaceProfile(MarketPlaceProfileModel.toJson(marketPlaceProfileModelRequest)))
          .thenAnswer((_) => response);
      // act
      final result = await marketPlaceProfileRemoteDataSource.updateMarketPlaceProfile(marketPlaceProfileRequest);
      // assert
      expect(result, marketPlaceProfileModel);
    });

    test('should throw not found exception when marketPlaceProfile with matching id is not found', () async {
      // arrange
      when(() => mockDummyMarketPlaceProfileService.updateMarketPlaceProfile(MarketPlaceProfileModel.toJson(marketPlaceProfileModelRequest)))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await marketPlaceProfileRemoteDataSource.updateMarketPlaceProfile(marketPlaceProfileRequest), throwsA(isA<NotFoundException>()));
    });
  });
}