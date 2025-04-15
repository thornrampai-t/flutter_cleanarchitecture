import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cleanarchitecture/core/comment/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_cleanarchitecture/core/theme/theme.dart';
import 'package:flutter_cleanarchitecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_cleanarchitecture/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_cleanarchitecture/init_dependencies.dart';
import 'package:flutter_cleanarchitecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_cleanarchitecture/features/auth/presentation/page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn; // ถ้ามีการ login จะไป builder
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
