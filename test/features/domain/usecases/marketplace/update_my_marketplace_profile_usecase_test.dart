import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/domain/repositories/my_market_place_profile_repository.dart';
import 'package:template/domain/usecases/marketplace/update_my_market_place_profile_usecase.dart';

class MockMyMarketPlaceProfileRepository extends Mock implements MyMarketPlaceProfileRepository {}

void main() {
  late MockMyMarketPlaceProfileRepository mockMyMarketPlaceProfileRepository;
  late UpdateMyMarketPlaceProfileUsecase updateMyMarketPlaceProfileUsecase;

  setUp(() {
    mockMyMarketPlaceProfileRepository = MockMyMarketPlaceProfileRepository();
    updateMyMarketPlaceProfileUsecase = UpdateMyMarketPlaceProfileUsecase(mockMyMarketPlaceProfileRepository);
  });

  const marketPlaceProfileRequest = MarketPlaceProfile(id: 1, sellerId: 1, name: 'My Marketplace 1', description: 'Test Description', logoUrl: 'Test Logo');
  const updatedMarketPlaceProfile = MarketPlaceProfile(id: 1, sellerId: 1, name: 'My Marketplace 1', description: 'Updated Description', logoUrl: 'Updated Logo');

  test('should update myMarketPlaceProfile and return updated myMarketPlaceProfile from mock repository', () async {
    // Arrange
    when(() => mockMyMarketPlaceProfileRepository.updateMarketPlaceProfile(marketPlaceProfileRequest))
        .thenAnswer((_) async => const Right(updatedMarketPlaceProfile));

    // Act
    final result = await updateMyMarketPlaceProfileUsecase(const Params(data: marketPlaceProfileRequest));

    // Assert
    expect(result, const Right(updatedMarketPlaceProfile));

    // Verify
    verify(() => mockMyMarketPlaceProfileRepository.updateMarketPlaceProfile(marketPlaceProfileRequest)).called(1);
    verifyNoMoreInteractions(mockMyMarketPlaceProfileRepository);
  });
}