import 'package:equatable/equatable.dart';

const categories = [
  Category(id: "business", name: "Bisnis", image: "assets/images/bisnis.jpg"),
  Category(id: "entertainment", name: "Entertaimen", image: "assets/images/entertaimen.jpg"),
  Category(id: "health", name: "Kesehatan", image: "assets/images/kesehatan.jpg"),
  Category(id: "science", name: "Ilmu Pengetahuan", image: "assets/images/sains.jpg"),
  Category(id: "sports", name: "Olahraga", image: "assets/images/sport.jpg"),
  Category(id: "technology", name: "Teknologi", image: "assets/images/tech.jpg"),
];

class Category extends Equatable {
  final String id;
  final String name;
  final String image;

  const Category({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];
}
