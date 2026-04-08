import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/presentation/bloc/auth_state.dart';
import 'package:hrms_roster/presentation/pages/login_page.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/HRMSAppBar.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',

//       /// Apply your theme
//       theme: AppTheme.lightTheme,
//        home: BlocProvider(
//         create: (context) => AuthBloc(),
//         child: const LoginPage(),
//       ),

//       // home: const HomePage(),
//     );
//   }
// }



import 'core/di/injection.dart' as di;
import 'presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
      ],
      child: MaterialApp(
        title: 'HRMS.AI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
           '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const HomePage();
        } else if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
              ),
            ),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HRMSAppBar(),
      body: const Center(child: Text("Background color applied from AppTheme")),
    );
  }
}
