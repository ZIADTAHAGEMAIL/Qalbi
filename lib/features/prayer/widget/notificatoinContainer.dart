import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:flutter_scalify/responsive_scale/responsive_extensions.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import 'package:islamicapp/shared/widget/customIcons.dart';
import 'package:islamicapp/shared/widget/customText.dart';

class Notificatoincontainer extends StatefulWidget {
  final bool prayerNotificationON;
  Notificatoincontainer({super.key, required this.prayerNotificationON});

  @override
  State<Notificatoincontainer> createState() => _NotificatoincontainerState();
}

class _NotificatoincontainerState extends State<Notificatoincontainer> {
  late bool isOne = widget.prayerNotificationON;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Container(
        padding: 12.p,
        margin: 20.ph,
        height: 50.s,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: 40.br,
        ),

        child: Row(
          children: [
            Spacer(),
            Customicon(
              ontap: () {},

              icon: Icons.notifications,
              color: Appcolors.prayerTimesTeal,
              size: 22.fz,
            ),
            Spacer(),

            Customtext(
              text: 'Prayer Notification',
              textcolor: Appcolors.prayerTimesTeal,
              textsize: 22.fz,
              textweight: FontWeight.w800,
            ),
            Spacer(),
            Transform.scale(
              scale: 0.9.iz,
              child: Switch(
                value: isOne,
                onChanged: (value) {
                  setState(() {
                    isOne = value;
                  });
                },

                activeColor: Colors.white,
                activeTrackColor: Colors.green,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
