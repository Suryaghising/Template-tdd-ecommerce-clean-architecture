import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/domain/entities/market_place_profile.dart';

import '../error/exception.dart';

abstract class DummyMarketPlaceProfileService {
  Map<String, dynamic> getMyMarketPlaceProfile(int id);
  Map<String, dynamic> addMyMarketPlaceProfile(Map<String, dynamic> request);
  Map<String, dynamic> updateMarketPlaceProfile(Map<String, dynamic> request);
  List<dynamic> getAllMarketPlaceProfiles();
}

class DummyMarketPlaceProfileServiceImpl implements DummyMarketPlaceProfileService {

  List<dynamic> dummyMarketPlaceProfiles = [
    {'id': 1, 'seller_id': 1, 'name': 'Name 1', 'description': 'Description 1', 'logo_url': 'https://blog.hubspot.com/hubfs/image8-2.jpg'},
    {'id': 2, 'seller_id': 2, 'name': 'Name 2', 'description': 'Description 2', 'logo_url': 'https://dynamic.brandcrowd.com/asset/logo/937e0eec-eebf-4294-9029-41619d6c3786/logo-search-grid-1x?logoTemplateVersion=1&v=638369310055500000'},
    {'id': 3, 'seller_id': 3, 'name': 'Name 3', 'description': 'Description 3', 'logo_url': 'https://marketplace.canva.com/EAFYecj_1Sc/1/0/1600w/canva-cream-and-black-simple-elegant-catering-food-logo-2LPev1tJbrg.jpg'},
  ];

  @override
  Map<String, dynamic> addMyMarketPlaceProfile(Map<String, dynamic> request) {
    final existingIndex = dummyMarketPlaceProfiles.indexWhere((element) => element['seller_id'] == request['seller_id']);
    if(existingIndex >= 0) {
      throw DuplicateEntryException();
    }
    int newId = dummyMarketPlaceProfiles.isNotEmpty ? dummyMarketPlaceProfiles.last['id'] + 1 : 1;
    final newMarketPlaceProfile = {...request, 'id': newId};
    dummyMarketPlaceProfiles.add(newMarketPlaceProfile);
    return newMarketPlaceProfile;
  }

  @override
  Map<String, dynamic> getMyMarketPlaceProfile(int id) {
    final index = dummyMarketPlaceProfiles.indexWhere((element) => element['seller_id'] as int == id);
    if(index >= 0) {
      return dummyMarketPlaceProfiles[index];
    } else {
      throw NotFoundException();
    }
  }

  @override
  Map<String, dynamic> updateMarketPlaceProfile(Map<String, dynamic> request) {
    int index = dummyMarketPlaceProfiles
        .indexWhere((marketPlaceProfile) => marketPlaceProfile['id'] == request['id']);
    if (index != -1) {
      dummyMarketPlaceProfiles[index] = request;
      return request;
    } else {
      throw NotFoundException();
    }
  }

  @override
  List<dynamic> getAllMarketPlaceProfiles() {
    return List<Map<String, dynamic>>.from(dummyMarketPlaceProfiles);
  }

}