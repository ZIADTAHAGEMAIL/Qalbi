import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:islamicapp/core/constant/appColors.dart';

class root extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const root({
    super.key,
    required this.navigationShell,
  });

  @override
  State<root> createState() => _rootState();
}

class _rootState extends State<root> {







  Widget _buildNavItem(IconData icon, int index, int currentPage) {
    bool isSelected = currentPage == index;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 20 : 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? Border.all(
          color: Colors.green.withOpacity(0.3),
          width: 1.5,
        )
            : null,
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.green : Colors.grey.shade700,
        size: isSelected ? 26: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int currentPage = widget.navigationShell.currentIndex;

    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.navigationShell,

      bottomNavigationBar: Container(
        margin:  const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            selectedItemColor: Appcolors.homeGreen,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            elevation: 2.5,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentPage,
            onTap: (index) {
              widget.navigationShell.goBranch(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: _buildNavItem(Icons.home, 0, currentPage),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildNavItem(FlutterIslamicIcons.solidQuran2,
                    1, currentPage),
                label: 'Quran',
              ),
              BottomNavigationBarItem(
                icon: _buildNavItem(Icons.access_time, 2, currentPage),
                label: 'prayer',
              ),
              BottomNavigationBarItem(
                icon: _buildNavItem(Icons.explore, 3, currentPage),
                label: 'Qibla',
              ),
              BottomNavigationBarItem(
                icon: _buildNavItem(Icons.person, 4, currentPage),
                label: 'Pofile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

