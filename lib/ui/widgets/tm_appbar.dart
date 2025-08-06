import 'package:flutter/material.dart';

class TMAppbar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
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
                  "Mehedy Hasan Miraz",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "mirazmehedi065@gmail.com",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}