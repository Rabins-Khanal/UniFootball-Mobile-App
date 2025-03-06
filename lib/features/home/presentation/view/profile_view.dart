import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_football_app/features/home/presentation/view_model/home_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.select((HomeCubit cubit) => cubit.state.isDarkMode);
    final isTablet = MediaQuery.of(context).size.width >=
        600; // Detect tablet based on screen width

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF0A0A1A)
          : Colors.white, // Darker background color
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor:
            isDarkMode ? const Color.fromARGB(255, 4, 19, 46) : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.all(isTablet ? 24.0 : 16.0), // Adjust padding for tablet
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Image (Replace with a local image or URL)
            Center(
              child: CircleAvatar(
                radius: isTablet ? 80 : 60, // Larger avatar for tablets
                backgroundImage: const AssetImage(
                    'assets/images/IMG-1741203188863.jpg'), // Replace with actual image
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),

            // User Full Name
            Text(
              'Full Name',
              style: TextStyle(
                  fontSize: isTablet ? 26 : 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'demo', // Replace with actual data
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 20),

            // User Email
            Text(
              'Email Address',
              style: TextStyle(
                  fontSize: isTablet ? 26 : 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'rabinskhanal47@gmail.com', // Replace with actual data
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 20),

            // User Username
            Text(
              'Username',
              style: TextStyle(
                  fontSize: isTablet ? 26 : 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'demo123', // Replace with actual data
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 40),

            // Update Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle update action (Navigate to a form or edit profile page)
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 40 : 32, vertical: 12),
                  minimumSize: Size(double.infinity,
                      isTablet ? 60 : 50), // Same size for both buttons
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Log Out Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Show SnackBar and then log out
                  showMySnackBar(
                    context: context,
                    message: 'Logging out...',
                    color: Colors.red,
                  );
                  context.read<HomeCubit>().logout(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 40 : 32, vertical: 12),
                  minimumSize: Size(double.infinity,
                      isTablet ? 60 : 50), // Same size for both buttons
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Red color for logout button
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SnackBar Function
  void showMySnackBar({
    required BuildContext context,
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
