import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const categories = [
  // Category(id: "general", name: "General", iconData: Icons.abc),
  Category(id: "business", name: "Bisnis", iconData: Icons.abc),
  Category(id: "entertainment", name: "Entertaimen", iconData: Icons.abc),
  Category(id: "health", name: "Kesehatan", iconData: Icons.abc),
  Category(id: "science", name: "Ilmu Pengetahuan", iconData: Icons.abc),
  Category(id: "sports", name: "Olahraga", iconData: Icons.abc),
  Category(id: "technology", name: "Teknologi", iconData: Icons.abc),
];

class Category extends Equatable {
  final String id;
  final String name;
  final IconData iconData;

  const Category({
    required this.id,
    required this.name,
    required this.iconData,
  });

  @override
  List<Object?> get props => [id, name, iconData];
}
