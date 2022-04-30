import 'package:equatable/equatable.dart';

const countries = [
  Country(id: "au", name: "Australia", image: 'assets/images/au.svg'),
  Country(id: "br", name: "Brazil", image: 'assets/images/br.svg'),
  Country(id: "co", name: "Colombia", image: 'assets/images/co.svg'),
  Country(id: "fr", name: "France", image: 'assets/images/fr.svg'),
  Country(id: "id", name: "Indonesia", image: 'assets/images/id.svg'),
  Country(id: "in", name: "India", image: 'assets/images/in.svg'),
  Country(id: "us", name: "United States", image: 'assets/images/us.svg'),
];

class Country extends Equatable {
  final String id;
  final String name;
  final String image;

  const Country({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];
}
