import '../../data/models/search_info_model.dart';

abstract class EmployeeRepository {
  Future<EmployeeModel> searchEmployees(String query);
}
