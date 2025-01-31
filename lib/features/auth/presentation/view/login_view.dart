import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/auth/presentation/view/register_view.dart';
import 'package:home_rental/features/auth/presentation/view_model/login/login_bloc.dart';

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
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo
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
                        // Email Input
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email,
                                  color: Colors.white70),
                              labelText: 'Email',
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Password Input
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.white70),
                              labelText: 'Password',
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Error Message
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // Forgot password logic here
                            },
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Login Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0ACF83),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    LoginUserEvent(
                                      context: context,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                              // if (_emailController.text == 'admin@gmail.com' &&
                              //     _passwordController.text == 'admin') {
                              //   context.read<LoginBloc>().add(
                              //         NavigateHomeScreenEvent(
                              //           destination: const HomeView(),
                              //           context: context,
                              //         ),
                              //       );}
                              // else {
                              //   setState(() {
                              //     _errorMessage =
                              //         'Invalid username or password';
                              //   });
                              //   showMySnackBar(
                              //     context: context,
                              //     message: 'Invalid username or password',
                              //     color: Colors.red,
                              //   );
                              // }
                            }
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Signup Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.white70),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<LoginBloc>().add(
                                      NavigateRegisterScreenEvent(
                                        destination: const RegisterView(),
                                        context: context,
                                      ),
                                    );
                              },
                              child: const Text(
                                " Signup",
                                style: TextStyle(
                                  color: Color(0xFF0ACF83),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
