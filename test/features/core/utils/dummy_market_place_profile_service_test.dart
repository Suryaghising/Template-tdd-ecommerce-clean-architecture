import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/services/dummy_market_place_profile_service.dart';

void main() {
  late DummyMarketPlaceProfileService dummyMarketPlaceProfileService;

  setUp(() {
    dummyMarketPlaceProfileService = DummyMarketPlaceProfileServiceImpl();
  });

  List<dynamic> expectedMarketPlaceProfiles = [
    {'id': 1, 'seller_id': 1, 'name': 'Name 1', 'description': 'Description 1', 'logo_url': 'Logo 1'},
    {'id': 2, 'seller_id': 2, 'name': 'Name 2', 'description': 'Description 2', 'logo_url': 'Logo 2'},
    {'id': 3, 'seller_id': 3, 'name': 'Name 3', 'description': 'Description 3', 'logo_url': 'Logo 3'},
  ];

  group('getMarketPlaceProfileById', () {
    int id = 1;
    test('should return marketPlaceProfile with matching id', () {
      // act
      final marketPlaceProfile = dummyMarketPlaceProfileService.getMyMarketPlaceProfile(id);
      // assert
      expect(marketPlaceProfile, isNotNull);
    });

    test('should throw NotFoundException for non-existent id', () {
      // assert
      expect(() => dummyMarketPlaceProfileService.getMyMarketPlaceProfile(8), throwsA(isA<NotFoundException>()));
    });
  });

  group('addMarketPlaceProfile', () {
    test('should add a new marketPlaceProfile to the list', () {
      // Arrange
      final newMarketPlaceProfile = {'id': 4, 'seller_id': 4, 'name': 'Name 4', 'description': 'Description 4', 'logo_url': 'Logo 4'};
      final initialMarketPlaceProfiles = dummyMarketPlaceProfileService.getAllMarketPlaceProfiles();

      // Act
      dummyMarketPlaceProfileService.addMyMarketPlaceProfile(newMarketPlaceProfile);
      final marketPlaceProfilesAfterAddition = dummyMarketPlaceProfileService.getAllMarketPlaceProfiles();
      final addedMarketPlaceProfile = marketPlaceProfilesAfterAddition.firstWhere((marketPlaceProfile) => marketPlaceProfile['id'] == 4);
      // Assert
      expect(addedMarketPlaceProfile, isNotNull);
      expect(marketPlaceProfilesAfterAddition.length, equals(initialMarketPlaceProfiles.length + 1));
    });

    test('should throw duplicate entry exception when marketPlaceProfile name already exists', () {
      // arrange
      final newMarketPlaceProfile = {'id': 3, 'seller_id': 3, 'name': 'Name 3', 'description': 'Description 3', 'logo_url': 'Logo 3'};

      // assert
      expect(() =>dummyMarketPlaceProfileService.addMyMarketPlaceProfile(newMarketPlaceProfile), throwsA(isA<DuplicateEntryException>()));
    });
  });

  group('updateMarketPlaceProfile', () {
    test('should update the marketPlaceProfile with matching id', () {
      // Arrange
      final updatedMarketPlaceProfile = {'id': 2, 'seller_id': 2, 'name': 'Updated name', 'description': 'Updated description', 'logo_url': 'Updated logo'};

      // Act
      dummyMarketPlaceProfileService.updateMarketPlaceProfile(updatedMarketPlaceProfile);
      final updatedMarketPlaceProfileFromService = dummyMarketPlaceProfileService.getMyMarketPlaceProfile(2);

      // Assert
      expect(updatedMarketPlaceProfileFromService, equals(updatedMarketPlaceProfile));
    });

    test('updateMarketPlaceProfile should throw NotFoundException for non-existent id', () {
      // Arrange
      final nonExistentMarketPlaceProfile = {'id': 4, 'seller_id': 4, 'name': 'Name 4', 'description': 'Description 4', 'logo_url': 'Logo 4'};

      // Act & Assert
      expect(() => dummyMarketPlaceProfileService.updateMarketPlaceProfile(nonExistentMarketPlaceProfile), throwsA(isA<NotFoundException>()));
    });
  });

}
