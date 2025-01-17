import 'dart:ui'; // For the BackdropFilter

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../home/presentation/view/home_view.dart';
import '../view_model/login/login_bloc.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'rabins');
  final _passwordController = TextEditingController(text: 'hello');

  final _gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image with Blur Effect
            Positioned.fill(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/uclimage.jpg', // Replace with your image path
                    fit: BoxFit.cover,
                    width: 2000,
                    height: 800,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5.0, sigmaY: 6.0), // Adjust the blur intensity
                    child: Container(
                      color:
                          Colors.black.withOpacity(0.6), // Adds a dark overlay
                    ),
                  ),
                ],
              ),
            ),
            // Login Form
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Brand Bold',
                                color: Colors
                                    .white, // Ensure text is visible on top of the background
                              ),
                            );
                          },
                        ),
                        _gap,
                        // Username Field with Greyish background
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey
                                .withOpacity(0.7), // Lighter grey background
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                          child: TextFormField(
                            key: const ValueKey('username'),
                            controller: _usernameController,
                            style: TextStyle(color: Colors.white), // White text
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  color: Colors.white), // White label text
                              contentPadding: EdgeInsets.all(16),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                          ),
                        ),
                        _gap,
                        // Password Field with Greyish background
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey
                                .withOpacity(0.7), // Lighter grey background
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                          child: TextFormField(
                            key: const ValueKey('password'),
                            controller: _passwordController,
                            obscureText: true,
                            style: TextStyle(color: Colors.white), // White text
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.white), // White label text
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.all(16),
                            ),
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            }),
                          ),
                        ),
                        _gap,
                        // Smaller Login Button (with reduced width)
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_usernameController.text == 'rabins' &&
                                  _passwordController.text == 'hello') {
                                context.read<LoginBloc>().add(
                                      NavigateHomeScreenEvent(
                                        destination: HomeView(),
                                        context: context,
                                      ),
                                    );
                              } else {
                                showMySnackBar(
                                  context: context,
                                  message: 'Invalid username or password',
                                  color: Colors.red,
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 45), // Reduced width
                          ),
                          child: const SizedBox(
                            height: 40, // Height remains the same
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16, // Smaller font size
                                  fontFamily: 'Brand Bold',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Smaller Register Button (with reduced width)
                        ElevatedButton(
                          key: const ValueKey('registerButton'),
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  NavigateRegisterScreenEvent(
                                    destination: RegisterView(),
                                    context: context,
                                  ),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 45), // Reduced width
                          ),
                          child: const SizedBox(
                            height: 40, // Height remains the same
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16, // Smaller font size
                                  fontFamily: 'Brand Bold',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
