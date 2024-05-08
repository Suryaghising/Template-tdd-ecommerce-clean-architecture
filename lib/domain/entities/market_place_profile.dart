import 'package:equatable/equatable.dart';

class MarketPlaceProfile extends Equatable {
  final int id;
  final int sellerId;
  final String name;
  final String description;
  final String logoUrl;

  const MarketPlaceProfile({required this.id, required this.sellerId, required this.name, required this.description, required this.logoUrl});

  @override
  List<Object?> get props => [id, sellerId, name, description, logoUrl];
}