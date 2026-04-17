import '../../domain/entities/upskill_entities.dart';

class UpskillSuggestionResponseModel extends UpskillSuggestionResponse {
  const UpskillSuggestionResponseModel({
    required super.status,
    required super.response,
  });

  factory UpskillSuggestionResponseModel.fromJson(Map<String, dynamic> json) {
    return UpskillSuggestionResponseModel(
      status: json['status'] as int,
      response: (json['response'] as List)
          .map((e) => UpskillDataModel.fromJson(e))
          .toList(),
    );
  }
}

// Model for UpskillData
class UpskillDataModel extends UpskillData {
  const UpskillDataModel({
    required super.id,
    required super.freepoolCount,
    required super.techGroupsInFreepool,
    required super.projectSuggestions,
    required super.upskillSuggestions,
    required super.generatedAt,
  });

  factory UpskillDataModel.fromJson(Map<String, dynamic> json) {
    return UpskillDataModel(
      id: json['id'] as int,
      freepoolCount: json['freepool_count'] as int,
      techGroupsInFreepool: json['tech_groups_in_freepool'] as int,
      projectSuggestions: (json['project_suggestions'] as List)
          .map((e) => ProjectSuggestionModel.fromJson(e))
          .toList(),
      upskillSuggestions: (json['upskill_suggestions'] as List)
          .map((e) => UpskillSuggestionModel.fromJson(e))
          .toList(),
      generatedAt: DateTime.parse(json['generated_at']),
    );
  }
}

// Model for ProjectSuggestion
class ProjectSuggestionModel extends ProjectSuggestion {
  const ProjectSuggestionModel({
    required super.techStack,
    required super.description,
    required super.projectTitle,
    required super.businessValue,
    required super.requiredRoles,
    required super.teamAssignments,
    required super.estimatedDuration,
  });

  factory ProjectSuggestionModel.fromJson(Map<String, dynamic> json) {
    return ProjectSuggestionModel(
      techStack: List<String>.from(json['tech_stack']),
      description: json['description'] as String,
      projectTitle: json['project_title'] as String,
      businessValue: json['business_value'] as String,
      requiredRoles: List<String>.from(json['required_roles']),
      teamAssignments: (json['team_assignments'] as List)
          .map((e) => TeamAssignmentModel.fromJson(e))
          .toList(),
      estimatedDuration: json['estimated_duration'] as String,
    );
  }
}

// Model for TeamAssignment
class TeamAssignmentModel extends TeamAssignment {
  const TeamAssignmentModel({
    required super.domain,
    required super.reason,
    required super.seniority,
    required super.skillType,
    required super.techGroup,
    required super.designation,
    required super.employeeId,
    required super.displayName,
    required super.assignedRole,
    required super.primarySkills,
    required super.seniorityUsed,
    required super.secondarySkills,
  });

  factory TeamAssignmentModel.fromJson(Map<String, dynamic> json) {
    return TeamAssignmentModel(
      domain: json['domain'] as String,
      reason: json['reason'] as String,
      seniority: json['seniority'] as String,
      skillType: json['skill_type'] as String,
      techGroup: json['tech_group'] as String,
      designation: json['designation'] as String,
      employeeId: json['employee_id'] as String,
      displayName: json['display_name'] as String,
      assignedRole: json['assigned_role'] as String,
      primarySkills: List<String>.from(json['primary_skills']),
      seniorityUsed: json['seniority_used'] as String,
      secondarySkills: List<String>.from(json['secondary_skills']),
    );
  }
}

// Model for UpskillSuggestion
class UpskillSuggestionModel extends UpskillSuggestion {
  const UpskillSuggestionModel({
    required super.domain,
    required super.seniority,
    required super.techGroup,
    required super.designation,
    required super.employeeId,
    required super.displayName,
    required super.primarySkills,
    required super.secondarySkills,
    required super.upskillSuggestions,
  });

  factory UpskillSuggestionModel.fromJson(Map<String, dynamic> json) {
    return UpskillSuggestionModel(
      domain: json['domain'] as String,
      seniority: json['seniority'] as String,
      techGroup: json['tech_group'] as String,
      designation: json['designation'] as String,
      employeeId: json['employee_id'] as String,
      displayName: json['display_name'] as String,
      primarySkills: List<String>.from(json['primary_skills']),
      secondarySkills: List<String>.from(json['secondary_skills']),
      upskillSuggestions: (json['upskill_suggestions'] as List)
          .map((e) => UpskillDetailModel.fromJson(e))
          .toList(),
    );
  }
}

// Model for UpskillDetail
class UpskillDetailModel extends UpskillDetail {
  const UpskillDetailModel({
    required super.skill,
    required super.reason,
    required super.learningPath,
    required super.estimatedWeeks,
    required super.relevanceToCompany,
  });

  factory UpskillDetailModel.fromJson(Map<String, dynamic> json) {
    return UpskillDetailModel(
      skill: json['skill'] as String,
      reason: json['reason'] as String,
      learningPath: json['learning_path'] as String,
      estimatedWeeks: json['estimated_weeks'] as int,
      relevanceToCompany: json['relevance_to_company'] as String,
    );
  }
}