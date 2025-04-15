import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cleanarchitecture/core/comment/widgets/loader.dart';
import 'package:flutter_cleanarchitecture/core/theme/app_pallete.dart';
import 'package:flutter_cleanarchitecture/core/utils/show_snackbar.dart';
import 'package:flutter_cleanarchitecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_cleanarchitecture/features/auth/presentation/page/login_page.dart';
import 'package:flutter_cleanarchitecture/features/auth/presentation/widget/auth_field.dart';
import 'package:flutter_cleanarchitecture/features/auth/presentation/widget/auth_gradient_button.dart';
import 'package:flutter_cleanarchitecture/features/blog/presentation/pages/blog_page.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordlController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnakBar(context, state.message);
            }
            else if (state is AuthScucess){
              Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route)=> false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  AuthField(hintText: 'Name', controller: nameController),
                  SizedBox(height: 15),
                  AuthField(hintText: 'Email', controller: emailController),
                  SizedBox(height: 15),
                  AuthField(
                    hintText: 'Pasword',
                    controller: passwordlController,
                    isObscureText: true,
                  ),
                  SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: 'Sign up',
                    onPressed: () {
                      var textEmail = emailController.text.trim();
                      
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: textEmail,
                            password: passwordlController.text.trim(),
                            name: nameController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, LoginPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Auready have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
