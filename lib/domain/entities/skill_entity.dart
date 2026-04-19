import 'package:equatable/equatable.dart';

class SkillCategoryEntity extends Equatable {
  final String category;
  final List<String> skills;

  const SkillCategoryEntity({required this.category, required this.skills});

  @override
  List<Object?> get props => [category, skills];
}
