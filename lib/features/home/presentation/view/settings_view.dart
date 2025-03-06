import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart'; // ✅ Import sensor package
import 'package:uni_football_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:uni_football_app/features/home/presentation/view_model/home_state.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  StreamSubscription? _gyroscopeSubscription;
  static const double tiltThreshold = 1.5; // ✅ Sensitivity adjusted
  bool _canSwitch = true; // ✅ Prevents multiple rapid switches

  @override
  void initState() {
    super.initState();
    _startGyroscopeDetection(); // ✅ Start listening for tilts
  }

  @override
  void dispose() {
    _gyroscopeSubscription
        ?.cancel(); // ✅ Stop listening when widget is disposed
    super.dispose();
  }

  void _startGyroscopeDetection() {
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      double tilt = event.x; // ✅ Use X-axis for left-right tilt detection

      print("Gyroscope Tilt X: $tilt"); // ✅ Debug log

      if (_canSwitch) {
        if (tilt > tiltThreshold) {
          _canSwitch = false;
          _toggleTheme(false); // ✅ Tilt Right → Light Mode
        } else if (tilt < -tiltThreshold) {
          _canSwitch = false;
          _toggleTheme(true); // ✅ Tilt Left → Dark Mode
        }

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _canSwitch = true; // ✅ Re-enable switching after delay
          });
        });
      }
    });
  }

  void _toggleTheme(bool enableDarkMode) {
    print(enableDarkMode ? "Switched to Dark Mode" : "Switched to Light Mode");

    if (mounted) {
      context.read<HomeCubit>().toggleTheme(enableDarkMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool isDarkMode = state.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 4, 19, 46),
            iconTheme: IconThemeData(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "App Settings",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Card(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SwitchListTile(
                      title: Text(
                        "Enable Dark Mode",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      value: isDarkMode,
                      onChanged: (value) {
                        context.read<HomeCubit>().toggleTheme(value);
                      },
                      activeColor: Colors.blueAccent,
                      activeTrackColor: Colors.blueAccent.withOpacity(0.5),
                      inactiveTrackColor: Colors.grey[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
