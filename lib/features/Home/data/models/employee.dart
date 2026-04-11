class Employee {
  final String displayName;
  final int totalOccupancyPercentage;
  final int totalExperienceMonths;

  Employee({
    required this.displayName,
    required this.totalOccupancyPercentage,
    required this.totalExperienceMonths,
  });
}

class DirectoryContact {
  final String name;
  final String title;
  final String location;

  DirectoryContact({
    required this.name,
    required this.title,
    required this.location,
  });
}