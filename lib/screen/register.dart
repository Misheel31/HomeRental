import 'package:animated_switch/animated_switch.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            image: AssetImage('assets/images/splashscreen.webp'),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.40),
                  Colors.black.withOpacity(0.15),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Center the column vertically
              children: [
                const Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between elements
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffD8D8DD),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffD8D8DD),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    obscureText: true, // For password input
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffD8D8DD),
                      suffixIcon: const Icon(Icons.visibility_off),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    obscureText: true, // For password input
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffD8D8DD),
                      suffixIcon: const Icon(Icons.visibility_off),
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 19, top: 8, right: 19),
                  child: Row(
                    children: [
                      AnimatedSwitch(
                        colorOff: Color(0xffA09F99),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Rememebe me',
                        style: TextStyle(color: Colors.white),
                      ),
                      // Icon(
                      //   Icons.question_mark,
                      // ),
                      Spacer(),
                      Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 60,
                  width: 350,
                  decoration: const BoxDecoration(color: Color(0xff0ACF83)),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 100,
                    top: 30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
