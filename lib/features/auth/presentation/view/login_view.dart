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
import 'package:home_rental/features/home/presentation/view/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Future.microtask(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  Future<void> _setLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const GradientBackground(),
        SafeArea(
            child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              _setLoginStatus();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } else if (state.isLoading) {
              setState(() {
                _errorMessage = 'Loading ...';
              });
            }
          },
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
                                      _isPasswordVisible = !_isPasswordVisible;
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
                                  context.read<LoginBloc>().add(LoginUserEvent(
                                      context: context,
                                      email: _emailController.text,
                                      password: _passwordController.text));
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
                      )))),
        ))
      ],
    ));
  }
}
