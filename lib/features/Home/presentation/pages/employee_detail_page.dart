import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/core/constant/text_style.dart';
import 'package:hrms_roster/core/widgets/common_loading.dart';
import 'package:hrms_roster/core/widgets/custom_divider.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_employee_details_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:hrms_roster/features/Home/presentation/widgets/skill_chip.dart';

class EmployeeDetailPage extends StatefulWidget {
  final String employeeId;

  const EmployeeDetailPage({super.key, required this.employeeId});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<DirectoryContact> _employeeDetailsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _employeeDetailsFuture = _fetchEmployeeDetails();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<DirectoryContact> _fetchEmployeeDetails() async {
    final getEmployeeDetails = GetIt.instance<GetEmployeeDetails>();
    final result = await getEmployeeDetails(widget.employeeId);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (employee) => employee,
    );
  }

  void _navigateToEmployeeDetails(String employeeId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeDetailPage(employeeId: employeeId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kDashboardBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.kPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Employee Details',
          style: AppTextStyles.headline.copyWith(
            color: AppColors.kHeadingColor,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<DirectoryContact>(
        future: _employeeDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CommonLineLoading());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load employee details',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _employeeDetailsFuture = _fetchEmployeeDetails();
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          final employee = snapshot.data!;
          return _buildContent(employee);
        },
      ),
    );
  }

  Widget _buildContent(DirectoryContact employee) {
    return Column(
      children: [
        // Header Section
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.kPrimaryColor,
                AppColors.kPrimaryColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimaryColor.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        employee.name.isNotEmpty
                            ? employee.name[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee.name,
                          style: AppTextStyles.headline.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            employee.employeeId ?? '',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          employee.title,
                          style: AppTextStyles.subtitle.copyWith(
                            color: Colors.white.withOpacity(0.95),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Info Cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  title: 'Location',
                  value: employee.location,
                  icon: Icons.location_on,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  title: 'Department',
                  value: employee.department ?? 'N/A',
                  icon: Icons.business_center,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Created Date Card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.kSoftColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.access_time,
                  size: 20,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Member Since',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.kLightTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.createdDate != null
                          ? _formatDate(employee.createdDate!)
                          : 'N/A',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Tab Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.kPrimaryColor,
            unselectedLabelColor: AppColors.kLightTextColor,
            indicatorColor: AppColors.kPrimaryColor,
            indicatorWeight: 3,
            dividerColor: Colors.transparent,
            labelStyle: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: AppTextStyles.subtitle,
            tabs: const [
              Tab(text: 'Details'),
              Tab(text: 'Relationships'),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDetailsTab(employee),
              _buildRelationshipsTab(employee),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.kPrimaryColor, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.kHeadingColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.kLightTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab(DirectoryContact employee) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSectionCard(
            title: 'Basic Information',
            icon: Icons.person_outline,
            child: Column(
              children: [
                _buildInfoRow('Employee ID', employee.employeeId ?? ''),
                const CustomDivider(),
                _buildInfoRow('Full Name', employee.name),
                const CustomDivider(),
                _buildInfoRow('Department', employee.department ?? ''),
                const CustomDivider(),
                _buildInfoRow('Sub Department', employee.subDepartment ?? ''),
                const CustomDivider(),
                _buildInfoRow('Designation', employee.title),
                const CustomDivider(),
                _buildInfoRow('Location', employee.location),
                const CustomDivider(),
                _buildInfoRow('Employee Type', employee.employeeOuType ?? ''),
                const CustomDivider(),
                _buildInfoRow('Tech Group', employee.techGroup ?? ''),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildSectionCard(
            title: 'Experience',
            icon: Icons.work_outline,
            child: Column(
              children: [
                _buildInfoRow('Total Experience', employee.totalExp ?? ''),
                const CustomDivider(),
                _buildInfoRow('VVDN Experience', employee.vvdnExp ?? ''),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (employee.skills != null && employee.skills!.isNotEmpty)
            _buildSectionCard(
              title: 'Skills',
              icon: Icons.code,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: employee.skills!
                    .map((skill) => SkillChip(skill: skill))
                    .toList(),
              ),
            ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildRelationshipsTab(DirectoryContact employee) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSectionCard(
            title: 'Reporting Structure',
            icon: Icons.account_tree_outlined,
            child: Column(
              children: [
                _buildRelationshipRow(
                  'Reporting Manager',
                  employee.rmName ?? 'N/A',
                  isClickable:
                      employee.rmId != null && employee.rmId!.isNotEmpty,
                  onTap: employee.rmId != null && employee.rmId!.isNotEmpty
                      ? () => _navigateToEmployeeDetails(employee.rmId!)
                      : null,
                ),
                const CustomDivider(),
                _buildRelationshipRow(
                  'Reporting Manager ID',
                  employee.rmId ?? 'N/A',
                ),
                const CustomDivider(),
                _buildRelationshipRow(
                  'Tech Group',
                  employee.techGroup ?? 'N/A',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (employee.currentProjects != null &&
              employee.currentProjects!.isNotEmpty)
            _buildSectionCard(
              title: 'Current Projects',
              icon: Icons.folder_open,
              child: Column(
                children: employee.currentProjects!
                    .map((project) => _buildProjectCard(project))
                    .toList(),
              ),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _formatDate(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return dateTimeString;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.kPrimaryColor),
                const SizedBox(width: 8),
                Text(title, style: AppTextStyles.sectionTitle),
              ],
            ),
          ),
          const CustomDivider(thickness: 1),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.kLightTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.kHeadingColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelationshipRow(
    String label,
    String value, {
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.kLightTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: isClickable && onTap != null
                ? GestureDetector(
                    onTap: onTap,
                    child: Text(
                      value,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Container(
                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 12,
                    //   vertical: 8,
                    // ),
                    // decoration: BoxDecoration(
                    //   color: AppColors.kSoftColor,
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    child: Text(
                      value,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        // color: AppColors.kPrimaryColor,
                        color: AppColors.kAssistantTextPrimary,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(ProjectDetail project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kGreyColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kSoftColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  project.name,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.kPrimaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              if (project.status != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: project.status == 'Started'
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.kSoftColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    project.status!,
                    style: AppTextStyles.caption.copyWith(
                      color: project.status == 'Started'
                          ? AppColors.success
                          : AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          if (project.role != null && project.role!.isNotEmpty)
            _buildProjectDetailRow('Role', project.role!),

          if (project.projectManager != null &&
              project.projectManager!.isNotEmpty &&
              project.projectManager != 'N/A')
            _buildClickableProjectDetailRow(
              'Project Manager',
              project.projectManager!,
              onTap:
                  project.projectManagerId != null &&
                      project.projectManagerId!.isNotEmpty
                  ? () => _navigateToEmployeeDetails(project.projectManagerId!)
                  : null,
            ),

          if (project.customer != null && project.customer!.isNotEmpty)
            _buildProjectDetailRow('Customer', project.customer!),
        ],
      ),
    );
  }

  Widget _buildProjectDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.kLightTextColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.kHeadingColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableProjectDetailRow(
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.kLightTextColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: onTap != null
                ? GestureDetector(
                    onTap: onTap,
                    child: Text(
                      value,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.kHeadingColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
