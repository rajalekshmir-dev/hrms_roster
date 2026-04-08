import 'package:equatable/equatable.dart';

class ParsedQueryEntity extends Equatable {
  final List<String> skills;
  final List<String> context;
  final String? location;

  const ParsedQueryEntity({
    required this.skills,
    required this.context,
    this.location,
  });

  @override
  List<Object?> get props => [skills, context, location];
}
