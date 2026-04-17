import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/core/constant/text_style.dart';
import 'package:hrms_roster/core/widgets/HRMSAppBar.dart';
import 'package:hrms_roster/core/widgets/common_avatar.dart';
import 'package:hrms_roster/core/widgets/common_error_state.dart';
import 'package:hrms_roster/core/widgets/common_info_row.dart';
import 'package:hrms_roster/core/widgets/common_loading_container.dart';
import 'package:hrms_roster/core/widgets/common_section_card.dart';
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
      appBar: HRMSAppBar(
        showBackButton: true,
        showMenuIcon: false,
        showThemeToggle: false,
        showNotificationBadge: false,
        title: 'Employee Details',
      ),
      body: FutureBuilder<DirectoryContact>(
        future: _employeeDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CommonLoadingContainer(
              isLoading: true,
              child: SizedBox(),
            );
          }

          if (snapshot.hasError) {
            return CommonErrorState(
              message: 'Failed to load employee details',
              onRetry: () {
                setState(() {
                  _employeeDetailsFuture = _fetchEmployeeDetails();
                });
              },
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
        _buildHeaderSection(employee),

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

  Widget _buildHeaderSection(DirectoryContact employee) {
    return Container(
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
      child: Row(
        children: [
          CommonAvatar(name: employee.name, radius: 35),
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
    );
  }

  Widget _buildDetailsTab(DirectoryContact employee) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CommonSectionCard(
            title: 'Basic Information',
            icon: Icons.person_outline,
            child: Column(
              children: [
                CommonInfoRow(
                  label: 'Employee ID',
                  value: employee.employeeId ?? '',
                ),
                const CustomDivider(),
                CommonInfoRow(label: 'Full Name', value: employee.name),
                const CustomDivider(),
                CommonInfoRow(
                  label: 'Department',
                  value: employee.department ?? '',
                ),
                const CustomDivider(),
                CommonInfoRow(label: 'Designation', value: employee.title),
                const CustomDivider(),
                CommonInfoRow(label: 'Location', value: employee.location),
                const CustomDivider(),
                CommonInfoRow(
                  label: 'Tech Group',
                  value: employee.techGroup ?? '',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          CommonSectionCard(
            title: 'Experience',
            icon: Icons.work_outline,
            child: Column(
              children: [
                CommonInfoRow(
                  label: 'Total Experience',
                  value: employee.totalExp ?? '',
                ),
                const CustomDivider(),
                CommonInfoRow(
                  label: 'VVDN Experience',
                  value: employee.vvdnExp ?? '',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (employee.skills != null && employee.skills!.isNotEmpty)
            CommonSectionCard(
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
          CommonSectionCard(
            title: 'Reporting Structure',
            icon: Icons.account_tree_outlined,
            child: Column(
              children: [
                CommonInfoRow(
                  label: 'Reporting Manager',
                  value: employee.rmName ?? 'N/A',
                  isClickable:
                      employee.rmId != null && employee.rmId!.isNotEmpty,
                  onTap: employee.rmId != null && employee.rmId!.isNotEmpty
                      ? () => _navigateToEmployeeDetails(employee.rmId!)
                      : null,
                  labelWidth: 140,
                ),
                const CustomDivider(),
                CommonInfoRow(
                  label: 'Reporting Manager ID',
                  value: employee.rmId ?? 'N/A',
                  labelWidth: 140,
                ),
                const CustomDivider(),
                CommonInfoRow(
                  label: 'Tech Group',
                  value: employee.techGroup ?? 'N/A',
                  labelWidth: 140,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (employee.currentProjects != null &&
              employee.currentProjects!.isNotEmpty)
            CommonSectionCard(
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
