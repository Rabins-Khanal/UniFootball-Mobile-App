import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart'; // ✅ Import sensor package
import 'package:uni_football_app/core/common/snackbar/snackbar.dart';
import 'package:uni_football_app/features/home/presentation/view/profile_view.dart';
import 'package:uni_football_app/features/home/presentation/view/settings_view.dart';
import 'package:uni_football_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:uni_football_app/features/home/presentation/view_model/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}



  @override
  void dispose() {
    _accelerometerSubscription?.cancel(); // ✅ Stop listening to sensors
    _gyroscopeSubscription?.cancel();
    _inactivityTimer?.cancel();
    super.dispose();
  }

  // ✅ Shake Detection for Logout
  void _startShakeDetection() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      double acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

      if (acceleration > shakeThreshold && _canLogout) {
        _canLogout = false;
        _logoutUser();
        Future.delayed(const Duration(seconds: 2), () {
          _canLogout = true; // ✅ Re-enable shake detection after 2 seconds
        });
      }
    });
  }

  void _logoutUser() {
    showMySnackBar(
      context: context,
      message: 'Logging out...',
      color: Colors.red,
    );

    context.read<HomeCubit>().logout(context);
  }

  // ✅ Gyroscope Detection for Inactivity
  void _startGyroscopeDetection() {
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      double movement =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

      if (movement > 0.5) {
        // ✅ Small movement detected
        _resetInactivityTimer();
      }
    });

    _resetInactivityTimer(); // ✅ Start tracking inactivity
  }

  void _resetInactivityTimer() {
    _inactivityTimer?.cancel(); // ✅ Cancel any existing timer

    _inactivityTimer = Timer(const Duration(seconds: inactivityDuration), () {
      setState(() {
        _showMessage = true; // ✅ Show message after inactivity

        // Automatically hide the message after 3 seconds
        Timer(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _showMessage = false; // ✅ Hide message after 3 seconds
            });
          }
        });
      });
    });

    if (_showMessage) {
      setState(() {
        _showMessage = false; // ✅ Hide message if user moves phone
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              state.isDarkMode ? const Color(0xFF0A0A1A) : Colors.white,
          appBar: AppBar(
            title: const Text(
              'UniFootball',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 2,
            backgroundColor: const Color.fromARGB(255, 4, 19, 46),
            iconTheme: IconThemeData(
              color: state.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Drawer(
              backgroundColor:
                  state.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: state.isDarkMode
                          ? const Color.fromARGB(255, 2, 16, 36)
                          : Colors.blueAccent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'UniFootball',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        ListTile(
                          leading:
                              const Icon(Icons.home, color: Colors.blueAccent),
                          title: const Text("Home"),
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings,
                              color: Colors.blueAccent),
                          title: const Text("Settings"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsView()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.person,
                              color: Colors.blueAccent),
                          title: const Text("Profile"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileView(),
                              ),
                            );
                          },
                        ),
                        const Divider(
                            thickness: 1.2, indent: 16, endIndent: 16),
                        ListTile(
                          leading: const Icon(Icons.logout,
                              color: Colors.blueAccent),
                          title: const Text("Logout"),
                          onTap: () {
                            showMySnackBar(
                              context: context,
                              message: 'Logging out...',
                              color: Colors.red,
                            );
                            context.read<HomeCubit>().logout(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              state.views.elementAt(state.selectedIndex),

              // ✅ Enhanced Inactivity Message
              if (_showMessage)
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    opacity: _showMessage ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: state.isDarkMode
                            ? Colors.blueAccent.withOpacity(0.9)
                            : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Check out what's latest!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor:
                state.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor:
                state.isDarkMode ? Colors.grey[400] : Colors.grey,
            elevation: 8,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper), label: 'News'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star), label: 'Fixtures'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'My Team'),
            ],
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          ),
        );
      },
    );
  }
}
