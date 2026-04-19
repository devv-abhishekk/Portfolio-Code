import '../entities/portfolio_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetPortfolioData {
  final PortfolioRepository repository;

  GetPortfolioData(this.repository);

  Future<PortfolioEntity> call() async {
    return await repository.getPortfolioData();
  }
}
