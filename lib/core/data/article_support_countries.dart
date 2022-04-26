import 'package:equatable/equatable.dart';

const countries = [
  Country(id: "au", name: "Australia"),
  Country(id: "br", name: "Brazil"),
  Country(id: "co", name: "Colombia"),
  Country(id: "fr", name: "France"),
  Country(id: "ge", name: "Geramny"),
  Country(id: "id", name: "Indonesia"),
  Country(id: "us", name: "United States"),
];

class Country extends Equatable {
  final String id;
  final String name;

  const Country({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
