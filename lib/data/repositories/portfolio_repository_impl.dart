import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../models/portfolio_models.dart';
import '../datasource/portfolio_datasource.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioDataSource dataSource;

  PortfolioRepositoryImpl(this.dataSource);

  @override
  Future<PortfolioEntity> getPortfolioData() async {
    // Current dataSource returns models, which are also entities.
    // In a real app, we might map them here if they were different types.
    // Simulate network delay if needed, or just return from datasource.
    final personalInfo = dataSource.getPersonalInfo();
    final skills = dataSource.getSkills();
    final experiences = dataSource.getExperiences();
    final projects = dataSource.getProjects();
    final education = dataSource.getEducation();

    return PortfolioModel(
      personalInfo: personalInfo,
      skills: skills,
      experiences: experiences,
      projects: projects,
      education: education,
    );
  }
}
