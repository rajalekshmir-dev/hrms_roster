import 'package:equatable/equatable.dart';

class UpskillSuggestionResponse extends Equatable {
  final int status;
  final List<UpskillData> response;

  const UpskillSuggestionResponse({
    required this.status,
    required this.response,
  });

  @override
  List<Object?> get props => [status, response];
}

// Main data wrapper
class UpskillData extends Equatable {
  final int id;
  final int freepoolCount;
  final int techGroupsInFreepool;
  final List<ProjectSuggestion> projectSuggestions;
  final List<UpskillSuggestion> upskillSuggestions;
  final DateTime generatedAt;

  const UpskillData({
    required this.id,
    required this.freepoolCount,
    required this.techGroupsInFreepool,
    required this.projectSuggestions,
    required this.upskillSuggestions,
    required this.generatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        freepoolCount,
        techGroupsInFreepool,
        projectSuggestions,
        upskillSuggestions,
        generatedAt,
      ];
}

// Project Suggestion Entity
class ProjectSuggestion extends Equatable {
  final List<String> techStack;
  final String description;
  final String projectTitle;
  final String businessValue;
  final List<String> requiredRoles;
  final List<TeamAssignment> teamAssignments;
  final String estimatedDuration;

  const ProjectSuggestion({
    required this.techStack,
    required this.description,
    required this.projectTitle,
    required this.businessValue,
    required this.requiredRoles,
    required this.teamAssignments,
    required this.estimatedDuration,
  });

  @override
  List<Object?> get props => [
        techStack,
        description,
        projectTitle,
        businessValue,
        requiredRoles,
        teamAssignments,
        estimatedDuration,
      ];
}

// Team Assignment Entity
class TeamAssignment extends Equatable {
  final String domain;
  final String reason;
  final String seniority;
  final String skillType;
  final String techGroup;
  final String designation;
  final String employeeId;
  final String displayName;
  final String assignedRole;
  final List<String> primarySkills;
  final String seniorityUsed;
  final List<String> secondarySkills;

  const TeamAssignment({
    required this.domain,
    required this.reason,
    required this.seniority,
    required this.skillType,
    required this.techGroup,
    required this.designation,
    required this.employeeId,
    required this.displayName,
    required this.assignedRole,
    required this.primarySkills,
    required this.seniorityUsed,
    required this.secondarySkills,
  });

  @override
  List<Object?> get props => [
        domain,
        reason,
        seniority,
        skillType,
        techGroup,
        designation,
        employeeId,
        displayName,
        assignedRole,
        primarySkills,
        seniorityUsed,
        secondarySkills,
      ];
}

// Upskill Suggestion Entity
class UpskillSuggestion extends Equatable {
  final String domain;
  final String seniority;
  final String techGroup;
  final String designation;
  final String employeeId;
  final String displayName;
  final List<String> primarySkills;
  final List<String> secondarySkills;
  final List<UpskillDetail> upskillSuggestions;

  const UpskillSuggestion({
    required this.domain,
    required this.seniority,
    required this.techGroup,
    required this.designation,
    required this.employeeId,
    required this.displayName,
    required this.primarySkills,
    required this.secondarySkills,
    required this.upskillSuggestions,
  });

  @override
  List<Object?> get props => [
        domain,
        seniority,
        techGroup,
        designation,
        employeeId,
        displayName,
        primarySkills,
        secondarySkills,
        upskillSuggestions,
      ];
}

// Upskill Detail Entity
class UpskillDetail extends Equatable {
  final String skill;
  final String reason;
  final String learningPath;
  final int estimatedWeeks;
  final String relevanceToCompany;

  const UpskillDetail({
    required this.skill,
    required this.reason,
    required this.learningPath,
    required this.estimatedWeeks,
    required this.relevanceToCompany,
  });

  @override
  List<Object?> get props => [
        skill,
        reason,
        learningPath,
        estimatedWeeks,
        relevanceToCompany,
      ];
}