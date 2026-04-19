import 'package:equatable/equatable.dart';

class EducationEntity extends Equatable {
  final String degree;
  final String institution;
  final String year;

  const EducationEntity({
    required this.degree,
    required this.institution,
    required this.year,
  });

  @override
  List<Object?> get props => [degree, institution, year];
}
