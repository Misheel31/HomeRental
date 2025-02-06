import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/auth/presentation/view/register_view.dart';
import 'package:home_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/email_input.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/error_message.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/forgot_password.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/gradient_background.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/login_button.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/password_input.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/signup_link.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const GradientBackground(),
        SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 50),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Apartment rent-amico.png',
                                  height: 200,
                                  width: 150,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Login to continue',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 40),

                                EmailInput(controller: _emailController),

                                const SizedBox(height: 20),

                                PasswordInputWidget(
                                    controller: _passwordController,
                                    isPasswordVisible: _isPasswordVisible,
                                    togglePasswordVisibility: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    }),

                                const SizedBox(height: 10),
                                // Error Message
                                ErrorMessage(message: _errorMessage),
                                ForgotPassword(onTap: () {}),

                                const SizedBox(height: 30),
                                // Login Button
                                LoginButton(onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                        LoginUserEvent(
                                            context: context,
                                            email: _emailController.text,
                                            password:
                                                _passwordController.text));
                                  }
                                }),
                                const SizedBox(height: 20),
                                // Signup Link
                                SignupLink(onTap: () {
                                  context.read<LoginBloc>().add(
                                      NavigateHomeScreenEvent(
                                          context: context,
                                          destination: const RegisterView()));
                                })
                              ]),
                        )))))
      ],
    ));
  }
}
