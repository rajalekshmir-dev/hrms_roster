import 'package:equatable/equatable.dart';

class EmployeeModel extends Equatable {
  EmployeeModel({
    required this.action,
    required this.ranking,
    required this.response,
    required this.data,
    required this.totalResults,
    required this.parsedQuery,
    required this.processingTime,
    required this.employeeSearch,
  });

  final String? action;
  final bool? ranking;
  final String? response;
  final List<Datum> data;
  final int? totalResults;
  final ParsedQuery? parsedQuery;
  final double? processingTime;
  final bool? employeeSearch;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      action: json["action"],
      ranking: json["ranking"],
      response: json["response"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      totalResults: json["total_results"],
      parsedQuery: json["parsed_query"] == null
          ? null
          : ParsedQuery.fromJson(json["parsed_query"]),
      processingTime: json["processing_time"],
      employeeSearch: json["employee_search"],
    );
  }

  @override
  List<Object?> get props => [
    action,
    ranking,
    response,
    data,
    totalResults,
    parsedQuery,
    processingTime,
    employeeSearch,
  ];
}

class Datum extends Equatable {
  Datum({
    required this.employeeId,
    required this.displayName,
    required this.employeeDepartment,
    required this.totalExp,
    required this.skillSet,
    required this.empLocation,
    required this.designation,
    required this.techGroup,
    required this.vvdnExp,
    required this.projects,
    required this.rankedBy,
    required this.aiScore,
    required this.aiReason,
    required this.aiTier,
    required this.aiCriteria,
  });

  final String? employeeId;
  final String? displayName;
  final String? employeeDepartment;
  final String? totalExp;
  final String? skillSet;
  final String? empLocation;
  final String? designation;
  final String? techGroup;
  final String? vvdnExp;
  final List<Project> projects;
  final String? rankedBy;
  final int? aiScore;
  final String? aiReason;
  final int? aiTier;
  final AiCriteria? aiCriteria;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      employeeId: json["employee_id"],
      displayName: json["display_name"],
      employeeDepartment: json["employee_department"],
      totalExp: json["total_exp"],
      skillSet: json["skill_set"],
      empLocation: json["emp_location"],
      designation: json["designation"],
      techGroup: json["tech_group"],
      vvdnExp: json["vvdn_exp"],
      projects: json["projects"] == null
          ? []
          : List<Project>.from(
              json["projects"]!.map((x) => Project.fromJson(x)),
            ),
      rankedBy: json["ranked_by"],
      aiScore: json["ai_score"],
      aiReason: json["ai_reason"],
      aiTier: json["ai_tier"],
      aiCriteria: json["ai_criteria"] == null
          ? null
          : AiCriteria.fromJson(json["ai_criteria"]),
    );
  }

  @override
  List<Object?> get props => [
    employeeId,
    displayName,
    employeeDepartment,
    totalExp,
    skillSet,
    empLocation,
    designation,
    techGroup,
    vvdnExp,
    projects,
    rankedBy,
    aiScore,
    aiReason,
    aiTier,
    aiCriteria,
  ];
}

class AiCriteria extends Equatable {
  AiCriteria({
    required this.skill,
    required this.availability,
    required this.experience,
  });

  final int? skill;
  final int? availability;
  final int? experience;

  factory AiCriteria.fromJson(Map<String, dynamic> json) {
    return AiCriteria(
      skill: json["Skill"],
      availability: json["Availability"],
      experience: json["Experience"],
    );
  }

  @override
  List<Object?> get props => [skill, availability, experience];
}

class Project extends Equatable {
  Project({
    required this.projectName,
    required this.customer,
    required this.role,
    required this.deployment,
    required this.occupancy,
    required this.projectIndustry,
    required this.projectStatus,
    required this.projectJoinedDate,
  });

  final String? projectName;
  final String? customer;
  final String? role;
  final String? deployment;
  final int? occupancy;
  final String? projectIndustry;
  final String? projectStatus;
  final DateTime? projectJoinedDate;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectName: json["project_name"],
      customer: json["customer"],
      role: json["role"],
      deployment: json["deployment"],
      occupancy: json["occupancy"],
      projectIndustry: json["project_industry"],
      projectStatus: json["project_status"],
      projectJoinedDate: DateTime.tryParse(json["project_joined_date"] ?? ""),
    );
  }

  @override
  List<Object?> get props => [
    projectName,
    customer,
    role,
    deployment,
    occupancy,
    projectIndustry,
    projectStatus,
    projectJoinedDate,
  ];
}

class ParsedQuery extends Equatable {
  ParsedQuery({
    required this.skills,
    required this.context,
    required this.skillContextMode,
    required this.location,
    required this.ranking,
    required this.semanticSkills,
  });

  final List<String> skills;
  final List<String> context;
  final String? skillContextMode;
  final String? location;
  final bool? ranking;
  final List<String> semanticSkills;

  factory ParsedQuery.fromJson(Map<String, dynamic> json) {
    return ParsedQuery(
      skills: json["skills"] == null
          ? []
          : List<String>.from(json["skills"]!.map((x) => x)),
      context: json["context"] == null
          ? []
          : List<String>.from(json["context"]!.map((x) => x)),
      skillContextMode: json["skill_context_mode"],
      location: json["location"],
      ranking: json["ranking"],
      semanticSkills: json["semantic_skills"] == null
          ? []
          : List<String>.from(json["semantic_skills"]!.map((x) => x)),
    );
  }

  @override
  List<Object?> get props => [
    skills,
    context,
    skillContextMode,
    location,
    ranking,
    semanticSkills,
  ];
}
