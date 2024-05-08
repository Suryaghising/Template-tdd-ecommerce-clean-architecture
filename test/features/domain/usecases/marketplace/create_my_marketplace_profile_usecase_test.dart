import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/domain/repositories/my_market_place_profile_repository.dart';
import 'package:template/domain/usecases/marketplace/add_my_market_place_profile_usecase.dart';

class MockMyMarketPlaceProfileRepository extends Mock implements MyMarketPlaceProfileRepository {}

void main() {
  late MockMyMarketPlaceProfileRepository mockMyMarketPlaceProfileRepository;
  late AddMyMarketPlaceProfileUsecase addMyMarketPlaceProfileUsecase;

  setUp(() {
    mockMyMarketPlaceProfileRepository = MockMyMarketPlaceProfileRepository();
    addMyMarketPlaceProfileUsecase = AddMyMarketPlaceProfileUsecase(mockMyMarketPlaceProfileRepository);
  });

  final marketPlaceProfileRequest = MarketPlaceProfileRequestModel(sellerId: 1, name: 'My Marketplace 1', description: 'Test Description', logoUrl: 'Test Logo');
  const marketPlaceProfileResponse = MarketPlaceProfile(id: 1, sellerId: 1, name: 'My Marketplace 1', description: 'Test Description', logoUrl: 'Test Logo');


  test('should add and return marketPlaceProfile with id from mock api request', () async{
    // arrange
    when(() => mockMyMarketPlaceProfileRepository.addMyMarketPlaceProfile(marketPlaceProfileRequest))
        .thenAnswer((_) async => const Right(marketPlaceProfileResponse));
    // act
    final result = await addMyMarketPlaceProfileUsecase(Params(data: marketPlaceProfileRequest));
    //assert
    expect(result, const Right(marketPlaceProfileResponse));
    // verify
    verify(()=> mockMyMarketPlaceProfileRepository.addMyMarketPlaceProfile(marketPlaceProfileRequest)).called(1);
    verifyNoMoreInteractions(mockMyMarketPlaceProfileRepository);
  });
}