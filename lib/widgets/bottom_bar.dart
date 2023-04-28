

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:todo_bloc/screens/screens.dart';
import 'package:todo_bloc/theme/app_themes.dart';
import 'package:todo_bloc/widgets/my_drawer.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
 final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
       PendingTaskScreen(),
       CompleteTaskScreen(),
       FavouriteTaskScreen()
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon:  Icon(Icons.pending_rounded,color: Theme.of(context).primaryColor,),
          inactiveIcon:  Icon(Icons.pending_outlined,color: Theme.of(context).primaryColor,),
          title: "Pending",
          
        ),
        PersistentBottomNavBarItem(
          icon:  Icon(Icons.check_circle,color: Theme.of(context).primaryColor,),
          inactiveIcon: Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor,),
          title: "Complete",
         
        ),
        PersistentBottomNavBarItem(
          icon:  Icon(Icons.favorite,color: Theme.of(context).primaryColor,),
          inactiveIcon:  Icon(Icons.favorite_border,color: Theme.of(context).primaryColor,),
          title: "Favourite",
         
        ),
        
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        
        resizeToAvoidBottomInset: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        bottomScreenMargin: 0,
      
       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        hideNavigationBar: _hideNavBar,
        decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle:
            NavBarStyle.style12, // Choose the nav bar style with this property
      ),
     
      
    );
  }
}