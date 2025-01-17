import 'dart:ui'; // For the BackdropFilter

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../teams/domain/entity/teams_entity.dart';
import '../../../teams/presentation/view_model/teams_bloc.dart';
import '../../../teams/presentation/view_model/teams_state.dart';
import '../view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: '');
  final _lnameController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');
  final _usernameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  TeamsEntity? _dropDownValue;

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
            // Profile Image (Small and Circular)
            Positioned(
              top: 50, // Adjust the top value to position the profile image
              left: MediaQuery.of(context).size.width * 0.4, // Center the image
              child: CircleAvatar(
                radius: 40, // Adjust the size of the profile image
                backgroundImage: AssetImage(
                    'assets/images/profile.png'), // Replace with your profile image path
              ),
            ),
            // Register Form
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Brand Bold',
                            color: Colors.white,
                          ),
                        ),
                        _gap,
                        // First Name Field with Greyish background
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey
                                .withOpacity(0.7), // Lighter grey background
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                          child: TextFormField(
                            controller: _fnameController,
                            style: TextStyle(color: Colors.white), // White text
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.all(16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        _gap,
                        // Last Name Field with Greyish background
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey
                                .withOpacity(0.7), // Lighter grey background
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                          child: TextFormField(
                            controller: _lnameController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.all(16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter last name';
                              }
                              return null;
                            },
                          ),
                        ),
                        _gap,
                        // Phone No Field with Greyish background
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey
                                .withOpacity(0.7), // Lighter grey background
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _phoneController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Phone No',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.all(16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phoneNo';
                              }
                              return null;
                            },
                          ),
                        ),
                        _gap,
                        // Dropdown for Favourite Team
                        BlocBuilder<TeamsBloc, TeamsState>(
                            builder: (context, state) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButtonFormField<TeamsEntity>(
                              items: state.teams
                                  .map((e) => DropdownMenuItem<TeamsEntity>(
                                        value: e,
                                        child: Text(
                                          e.teamsName,
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 8, 88, 149)),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                _dropDownValue = value;
                              },
                              value: _dropDownValue,
                              decoration: const InputDecoration(
                                labelText: 'Select Favourite Team',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.all(16),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your favourite team';
                                }
                                return null;
                              },
                            ),
                          );
                        }),
                        _gap,
                        // Username Field with Greyish background
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _usernameController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.all(16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
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
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.all(16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ),
                        _gap,
                        // Register Button with Smaller Size
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                context.read<RegisterBloc>().add(
                                      RegisterUser(
                                        context: context,
                                        fName: _fnameController.text,
                                        lName: _lnameController.text,
                                        phone: _phoneController.text,
                                        teams: _dropDownValue!,
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 45), // Reduced width
                            ),
                            child: const Text('Register'),
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
