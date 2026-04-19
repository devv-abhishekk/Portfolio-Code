import '../models/portfolio_models.dart';

abstract class PortfolioDataSource {
  PersonalInfoModel getPersonalInfo();
  List<SkillCategoryModel> getSkills();
  List<ExperienceModel> getExperiences();
  List<ProjectModel> getProjects();
  List<EducationModel> getEducation();
}
