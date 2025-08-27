import 'package:flutter/material.dart';
import 'package:new_task/ui/controllers/auth_controller.dart';
import 'package:new_task/ui/screens/login_screen.dart';
import 'package:new_task/ui/screens/update_profile_screen.dart';

class TMAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool? fromProfileScreen;

  const TMAppbar({super.key, this.fromProfileScreen});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromProfileScreen ?? false) {
            return;
          }
          _onTapProfileSection(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 18, // ছোট radius
              backgroundImage: AssetImage("assets/images/gold.jpg"),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel?.fulName ?? 'Unknown',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    AuthController.userModel?.email ?? 'Unknown',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

            ),
            IconButton(
              onPressed: () => _onTapLogoutButton(context),
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapProfileSection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
    );
  }

  Future<void> _onTapLogoutButton(BuildContext context) async{
    await AuthController.clearUserInformation();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (predicate) => false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
