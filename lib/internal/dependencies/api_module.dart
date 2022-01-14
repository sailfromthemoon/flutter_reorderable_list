import '../../data/api/api_util.dart';
import '../../data/api/service/training_service.dart';

class ApiModule {
  static final ApiUtil _apiUtil = ApiUtil(TrainingService());

  static ApiUtil apiUtil() {
    return _apiUtil;
  }
}
