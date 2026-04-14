// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hrms_roster/core/widgets/search_bar.dart';
// import 'package:hrms_roster/core/widgets/stats_overview_card.dart';
// import 'package:hrms_roster/core/widgets/contact_card.dart';
// import '../bloc/home_bloc.dart';
// import '../bloc/home_event.dart';
// import '../bloc/home_state.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<HomeBloc>().add(LoadHomeData());
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           // Loading state
//           if (state.status == HomeStatus.loading) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text('Loading employees...'),
//                 ],
//               ),
//             );
//           }

//           // Error state
//           if (state.status == HomeStatus.error) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.error_outline,
//                     size: 64,
//                     color: Colors.red.shade300,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     state.errorMessage ?? 'Something went wrong',
//                     style: const TextStyle(fontSize: 16),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       context.read<HomeBloc>().add(RefreshHomeData());
//                     },
//                     icon: const Icon(Icons.refresh),
//                     label: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // Data available - show the list with Search Bar above Stats Overview
//           return RefreshIndicator(
//             onRefresh: () async {
//               context.read<HomeBloc>().add(RefreshHomeData());
//             },
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Search Bar (Above Stats Overview)
//                   // ReusableSearchBar(
//                   //   controller: _searchController,
//                   //   hintText: 'Search widgets...',
//                   //   onSearchChanged: (query) {
//                   //     context.read<HomeBloc>().add(SearchEmployees(query));
//                   //   },
//                   //   onClearTap: () {
//                   //     _searchController.clear();
//                   //     context.read<HomeBloc>().add(ClearSearch());
//                   //   },
//                   //   onFilterTap: () {
//                   //     // TODO: Implement filter functionality
//                   //     ScaffoldMessenger.of(context).showSnackBar(
//                   //       const SnackBar(content: Text('Filter coming soon!')),
//                   //     );
//                   //   },
//                   //   showFilterButton: true,
//                   // ),
//                   // const SizedBox(height: 16),

//                   // Stats Overview Section
//                   StatsOverviewCard(
//                     totalEmployees: state.totalEmployees,
//                     activeProjects: state.activeProjects,
//                     freePool: state.freePoolCount,
//                   ),
//                   const SizedBox(height: 24),

//                   // Employee Directory List
//                   if (state.displayContacts.isEmpty && state.searchQuery.isNotEmpty)
//                     Center(
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 40),
//                           Icon(
//                             Icons.search_off,
//                             size: 64,
//                             color: Colors.grey.shade400,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'No results found for "${state.searchQuery}"',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           TextButton.icon(
//                             onPressed: () {
//                               _searchController.clear();
//                               context.read<HomeBloc>().add(ClearSearch());
//                             },
//                             icon: const Icon(Icons.clear),
//                             label: const Text('Clear search'),
//                           ),
//                         ],
//                       ),
//                     )
//                   else if (state.displayContacts.isEmpty)
//                     Center(
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 40),
//                           Icon(
//                             Icons.people_outline,
//                             size: 64,
//                             color: Colors.grey.shade400,
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'No employees found',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   else
//                     ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: state.displayContacts.length,
//                       separatorBuilder: (_, __) => const SizedBox(height: 12),
//                       itemBuilder: (context, index) {
//                         return ContactCard(contact: state.displayContacts[index]);
//                       },
//                     ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hrms_roster/core/widgets/stats_overview_card.dart';
// import 'package:hrms_roster/core/widgets/contact_card.dart';
// import '../bloc/home_bloc.dart';
// import '../bloc/home_event.dart';
// import '../bloc/home_state.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   bool _showAllEmployees = false;

//   @override
//   void initState() {
//     super.initState();
//     context.read<HomeBloc>().add(LoadHomeData());
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           // Loading state
//           if (state.status == HomeStatus.loading) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text('Loading employees...'),
//                 ],
//               ),
//             );
//           }

//           // Error state
//           if (state.status == HomeStatus.error) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.error_outline,
//                     size: 64,
//                     color: Colors.red.shade300,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     state.errorMessage ?? 'Something went wrong',
//                     style: const TextStyle(fontSize: 16),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       context.read<HomeBloc>().add(RefreshHomeData());
//                     },
//                     icon: const Icon(Icons.refresh),
//                     label: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // Determine which employees to display
//           List<dynamic> displayList = state.displayContacts;
//           if (!_showAllEmployees && state.searchQuery.isEmpty) {
//             displayList = state.displayContacts.take(5).toList();
//           } else {
//             displayList = state.displayContacts;
//           }

//           // Data available - show the list with Search Bar above Stats Overview
//           return RefreshIndicator(
//             onRefresh: () async {
//               context.read<HomeBloc>().add(RefreshHomeData());
//             },
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 12),

//                   // Stats Overview Section
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: StatsOverviewCard(
//                       totalEmployees: state.totalEmployees,
//                       activeProjects: state.activeProjects,
//                       freePool: state.freePoolCount,
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   // Employee Directory Container
//                   if (state.displayContacts.isNotEmpty)
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: Colors.grey.shade200),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.05),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Header with Title and View All button
//                           Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Employee Directory',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey.shade800,
//                                   ),
//                                 ),
//                                 if (!_showAllEmployees && state.searchQuery.isEmpty)
//                                   TextButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         _showAllEmployees = true;
//                                       });
//                                     },
//                                     style: TextButton.styleFrom(
//                                       padding: EdgeInsets.zero,
//                                       minimumSize: Size.zero,
//                                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                     ),
//                                     child: Text(
//                                       'View All',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.blue.shade700,
//                                       ),
//                                     ),
//                                   ),
//                                 if (_showAllEmployees && state.searchQuery.isEmpty)
//                                   TextButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         _showAllEmployees = false;
//                                       });
//                                     },
//                                     style: TextButton.styleFrom(
//                                       padding: EdgeInsets.zero,
//                                       minimumSize: Size.zero,
//                                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                     ),
//                                     child: Text(
//                                       'Show Less',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.blue.shade700,
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),

//                           const Divider(height: 1, thickness: 1, color: Colors.grey),

//                           // Employee List
//                           if (displayList.isEmpty && state.searchQuery.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.all(32),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     Icon(
//                                       Icons.search_off,
//                                       size: 48,
//                                       color: Colors.grey.shade400,
//                                     ),
//                                     const SizedBox(height: 12),
//                                     Text(
//                                       'No results found for "${state.searchQuery}"',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     const SizedBox(height: 12),
//                                     TextButton.icon(
//                                       onPressed: () {
//                                         _searchController.clear();
//                                         context.read<HomeBloc>().add(ClearSearch());
//                                         setState(() {
//                                           _showAllEmployees = false;
//                                         });
//                                       },
//                                       icon: const Icon(Icons.clear, size: 18),
//                                       label: const Text('Clear search'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           else if (displayList.isEmpty)
//                             const Padding(
//                               padding: EdgeInsets.all(32),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     Icon(
//                                       Icons.people_outline,
//                                       size: 48,
//                                       color: Colors.grey,
//                                     ),
//                                     SizedBox(height: 12),
//                                     Text(
//                                       'No employees found',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           else
//                             ListView.separated(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               padding: const EdgeInsets.all(16),
//                               itemCount: displayList.length,
//                               separatorBuilder: (_, __) => const SizedBox(height: 12),
//                               itemBuilder: (context, index) {
//                                 return ContactCard(contact: displayList[index]);
//                               },
//                             ),

//                           // Footer with employee count
//                           if (!_showAllEmployees && state.searchQuery.isEmpty && displayList.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.all(12),
//                               child: Center(
//                                 child: Text(
//                                   'Showing ${displayList.length} of ${state.displayContacts.length} employees',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey.shade500,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/widgets/reusable_search_bar.dart';
import 'package:hrms_roster/core/widgets/stats_overview_card.dart';
import 'package:hrms_roster/core/widgets/contact_card.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showAllEmployees = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeData());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // Loading state
          if (state.status == HomeStatus.loading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading employees...'),
                ],
              ),
            );
          }

          // Error state
          if (state.status == HomeStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage ?? 'Something went wrong',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<HomeBloc>().add(RefreshHomeData());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Determine which employees to display
          List<dynamic> displayList = state.displayContacts;
          if (!_showAllEmployees && state.searchQuery.isEmpty) {
            displayList = state.displayContacts.take(5).toList();
          } else {
            displayList = state.displayContacts;
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(RefreshHomeData());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Stats Overview Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: StatsOverviewCard(
                      totalEmployees: state.totalEmployees,
                      activeProjects: state.activeProjects,
                      freePool: state.freePoolCount,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Employee Directory Container
                  if (state.directoryContacts.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with Title and View All button
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Employee Directory',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                if (!_showAllEmployees &&
                                    state.searchQuery.isEmpty)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _showAllEmployees = true;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ),
                                if (_showAllEmployees &&
                                    state.searchQuery.isEmpty)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _showAllEmployees = false;
                                        _searchController.clear();
                                        context.read<HomeBloc>().add(
                                          ClearSearch(),
                                        );
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'Show Less',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Search Bar (Placed below the header, above the list)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: ReusableSearchBar(
                              controller: _searchController,
                              hintText: 'Search by name, title, or location...',
                              onSearchChanged: (query) {
                                // Filter by name (alphabets only)
                                if (query.isEmpty) {
                                  context.read<HomeBloc>().add(ClearSearch());
                                  setState(() {
                                    _showAllEmployees = false;
                                  });
                                } else {
                                  // Allow only alphabets, spaces, and basic punctuation for name search
                                  final filteredQuery = query.replaceAll(
                                    RegExp(r'[^a-zA-Z\s\-\.]'),
                                    '',
                                  );
                                  if (filteredQuery != query) {
                                    _searchController.value = TextEditingValue(
                                      text: filteredQuery,
                                      selection: TextSelection.collapsed(
                                        offset: filteredQuery.length,
                                      ),
                                    );
                                  }
                                  context.read<HomeBloc>().add(
                                    SearchEmployees(filteredQuery),
                                  );
                                  setState(() {
                                    _showAllEmployees =
                                        true; // Show all results when searching
                                  });
                                }
                              },
                              onClearTap: () {
                                _searchController.clear();
                                context.read<HomeBloc>().add(ClearSearch());
                                setState(() {
                                  _showAllEmployees = false;
                                });
                              },
                              onFilterTap: () {
                                // TODO: Implement filter dialog
                                _showFilterDialog(context);
                              },
                              showFilterButton: true,
                            ),
                          ),

                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),

                          // Employee List
                          if (displayList.isEmpty &&
                              state.searchQuery.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(32),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 48,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'No results found for "${state.searchQuery}"',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 12),
                                    TextButton.icon(
                                      onPressed: () {
                                        _searchController.clear();
                                        context.read<HomeBloc>().add(
                                          ClearSearch(),
                                        );
                                        setState(() {
                                          _showAllEmployees = false;
                                        });
                                      },
                                      icon: const Icon(Icons.clear, size: 18),
                                      label: const Text('Clear search'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (displayList.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(32),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.people_outline,
                                      size: 48,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'No employees found',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              itemCount: displayList.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                return ContactCard(contact: displayList[index]);
                              },
                            ),

                          // Footer with employee count
                          if (!_showAllEmployees &&
                              state.searchQuery.isEmpty &&
                              displayList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Center(
                                child: Text(
                                  'Showing ${displayList.length} of ${state.directoryContacts.length} employees',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Employees',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 16),
                // Add filter options here
                _buildFilterOption(context, 'Department'),
                _buildFilterOption(context, 'Location'),
                _buildFilterOption(context, 'Designation'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                        ),
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {},
            activeColor: Colors.blue.shade700,
          ),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
