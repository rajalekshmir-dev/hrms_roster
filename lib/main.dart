import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/search_info/data/models/search_info_model.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_bloc.dart';
import 'package:hrms_roster/features/search_info/presentation/widgets/SearchBarWidget.dart';

import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/HRMSAppBar.dart';
import 'core/widgets/common_drop_down.dart';
import 'core/widgets/multi_select_dropdown.dart' show MultiSelectDropdown;
import 'core/widgets/slider_menu_bar.dart';
import 'features/search_info/presentation/search_view.dart';
import 'features/search_info/presentation/widgets/EmployeeCard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      /// Apply your theme
      theme: AppTheme.lightTheme,

      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HRMSAppBar(),
      body: BlocProvider(
        create: (_) => sl<EmployeeSearchBloc>(),
        child: SearchAiQueryData(),
      ),
    );
  }
}
