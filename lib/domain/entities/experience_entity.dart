import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final String company;
  final String role;
  final String duration;
  final List<String> points;

  const ExperienceEntity({
    required this.company,
    required this.role,
    required this.duration,
    required this.points,
  });

  @override
  List<Object?> get props => [company, role, duration, points];
}
