import '../../app_export.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/usecases/get_portfolio_data.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}
class PortfolioLoading extends PortfolioState {}
class PortfolioLoaded extends PortfolioState {
  final PortfolioEntity portfolio;
  const PortfolioLoaded(this.portfolio);

  @override
  List<Object?> get props => [portfolio];
}
class PortfolioError extends PortfolioState {
  final String message;
  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}

class PortfolioCubit extends Cubit<PortfolioState> {
  final GetPortfolioData getPortfolioData;

  PortfolioCubit(this.getPortfolioData) : super(PortfolioInitial());

  Future<void> loadPortfolioData() async {
    emit(PortfolioLoading());
    try {
      final portfolio = await getPortfolioData();
      emit(PortfolioLoaded(portfolio));
    } catch (e) {
      emit(const PortfolioError('Failed to load portfolio data'));
    }
  }
}
