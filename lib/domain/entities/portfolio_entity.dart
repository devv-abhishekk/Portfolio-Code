import 'package:equatable/equatable.dart';
import 'personal_info_entity.dart';
import 'skill_entity.dart';
import 'experience_entity.dart';
import 'project_entity.dart';
import 'education_entity.dart';

class PortfolioEntity extends Equatable {
  final PersonalInfoEntity personalInfo;
  final List<SkillCategoryEntity> skills;
  final List<ExperienceEntity> experiences;
  final List<ProjectEntity> projects;
  final List<EducationEntity> education;

  const PortfolioEntity({
    required this.personalInfo,
    required this.skills,
    required this.experiences,
    required this.projects,
    required this.education,
  });

  @override
  List<Object?> get props => [personalInfo, skills, experiences, projects, education];
}
