import '../models/search_info_model.dart';

List<EmployeeModel> parseEmployees(Map<String, dynamic> response) {
  final List data = response["employee"];

  return data.map((e) => EmployeeModel.fromJson(e)).toList();
}
