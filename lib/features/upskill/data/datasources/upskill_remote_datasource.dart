import 'dart:convert';
import 'package:hrms_roster/core/error/exceptions.dart';
import 'package:hrms_roster/core/network/authenticated_api_client.dart';
import 'package:hrms_roster/features/upskill/data/models/upskill_models.dart';


abstract class UpskillRemoteDataSource {
  Future<UpskillSuggestionResponseModel> getUpskillSuggestions();
}

class UpskillRemoteDataSourceImpl implements UpskillRemoteDataSource {
  final AuthenticatedApiClient authenticatedClient;

  UpskillRemoteDataSourceImpl({required this.authenticatedClient});

  @override
  Future<UpskillSuggestionResponseModel> getUpskillSuggestions() async {
    try {
      final response = await authenticatedClient.get('/freepool_suggestions');
      
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return UpskillSuggestionResponseModel.fromJson(jsonResponse);
      } else {
        throw ServerException('Failed to load upskill suggestions');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Error fetching upskill suggestions: ${e.toString()}');
    }
  }
}