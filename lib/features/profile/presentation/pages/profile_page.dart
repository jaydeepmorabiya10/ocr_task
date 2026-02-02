import 'package:flutter/material.dart';
import 'package:ocr_task/core/widgets/custom_appbar.dart';
import 'package:ocr_task/core/widgets/datetime_extension.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/provider/auth_provider.dart';
import '../../../../core/navigation/custom_navigator.dart';
import '../../../../core/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _profileImage;
  String? _createdAt;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authProvider = context.read<AuthProvider>();
    _firstName = await authProvider.userFirstName;
    _lastName = await authProvider.userLastName;
    _email = await authProvider.userEmail;
    _mobile = await authProvider.userMobile;
    _profileImage = await authProvider.userProfileImage;
    _createdAt = await authProvider.userCreatedAt;
    setState(() {});
  }

  String get _memberSince {
    if (_createdAt == null || _createdAt!.isEmpty) {
      return 'Not available';
    }
    try {
      final date = DateTime.parse(_createdAt!);
      final formattedDate = date.toDDMMYYYY();
      final relativeTime = date.toRelativeTime();
      return '$formattedDate ($relativeTime)';
    } catch (e) {
      return _createdAt!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: 'Profile',
      //   backgroundColor: Theme.of(context).primaryColor,
      //   elevation: 0,
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: .1),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Avatar
              CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).primaryColor,
                backgroundImage:
                    _profileImage != null && _profileImage!.isNotEmpty
                    ? NetworkImage(_profileImage!)
                    : null,
                child: _profileImage == null || _profileImage!.isEmpty
                    ? const Icon(Icons.person, size: 60, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 20),
              // User Info Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        '${_firstName ?? ''} ${_lastName ?? ''}'
                                .trim()
                                .isNotEmpty
                            ? '${_firstName ?? ''} ${_lastName ?? ''}'.trim()
                            : 'User Profile',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(_email ?? 'user@example.com'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text('Phone'),
                        subtitle: Text(_mobile ?? 'Not available'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: const Text('Member Since'),
                        subtitle: Text(_memberSince),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Logout Button
              CustomButton(
                text: 'Logout',
                backgroundColor: Colors.red,
                radius: 10,
                onPressed: () {
                  context.read<AuthProvider>().logout();
                  CustomNavigator.pushNamedAndRemoveUntil(
                    CustomNavigator.loginRoute,
                    predicate: (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
