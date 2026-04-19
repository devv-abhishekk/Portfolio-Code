import '../../domain/entities/personal_info_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/education_entity.dart';
import '../../domain/entities/portfolio_entity.dart';

class PortfolioModel extends PortfolioEntity {
  const PortfolioModel({
    required PersonalInfoModel super.personalInfo,
    required List<SkillCategoryModel> super.skills,
    required List<ExperienceModel> super.experiences,
    required List<ProjectModel> super.projects,
    required List<EducationModel> super.education,
  });
}

class PersonalInfoModel extends PersonalInfoEntity {
  const PersonalInfoModel({
    required super.name,
    required super.title,
    required super.summary,
    required super.email,
    required super.phone,
    required super.githubUrl,
    required super.linkedInUrl,
    required super.resumeUrl,
  });
}

class SkillCategoryModel extends SkillCategoryEntity {
  const SkillCategoryModel({required super.category, required super.skills});
}

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.company,
    required super.role,
    required super.duration,
    required super.points,
  });
}

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.title,
    required super.description,
    required super.tags,
    super.playStoreUrl,
    super.appStoreUrl,
  });
}

class EducationModel extends EducationEntity {
  const EducationModel({
    required super.degree,
    required super.institution,
    required super.year,
  });
}
