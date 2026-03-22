import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import 'package:islamicapp/features/prayer/bloc/prayerBloc.dart';
import 'package:islamicapp/features/prayer/bloc/prayerState.dart';
import 'package:islamicapp/features/prayer/data/prayerTimesModel.dart';
import 'package:islamicapp/features/prayer/widget/notificatoinContainer.dart';
import 'package:islamicapp/shared/widget/customIcons.dart';
import 'package:islamicapp/shared/widget/customText.dart';
import 'package:shimmer/shimmer.dart';

class prayerTimesview extends StatefulWidget {
  const prayerTimesview({super.key});

  @override
  State<prayerTimesview> createState() => _prayerTimesviewState();
}

class _prayerTimesviewState extends State<prayerTimesview> {
  List<Prayertimesmodel> alldaysPrayer = PrayerBloc().allDaysPrayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<PrayerBloc>().startLogic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Appcolors.prayerTimesWhite,
      body: ScalifyBox(
        referenceWidth: 360,
        referenceHeight: 820,

        builder: (context, ls) {
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/prayer/prayerTimeBackground.png',
                    height: ls.h(205),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: ls.h(15),
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: ls.p(18),
                      child: Row(
                        children: [
                          if (Navigator.of(context).canPop())
                            Customicon(
                              ontap: () => Navigator.pop(context),
                              icon: Icons.arrow_back_ios,
                              color: Colors.white60,
                              size: ls.iz(30),
                            )
                          else
                            SizedBox(width: ls.iz(30)),

                          ls.sbh(15),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: ls.h(40),
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        BlocBuilder<PrayerBloc, PrayerState>(
                          builder: (context, state) {
                            final prayerBloc = context.read<PrayerBloc>();
                            final today = prayerBloc.today;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Spacer(),
                                // Spacer(),
                                // Spacer(),

                                today == null
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: 10,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Customtext(
                                        text: today.dayName ?? '---',
                                        textcolor: Colors.white,
                                        textsize: ls.fz(22),
                                        textweight: FontWeight.bold,
                                      ),

                                // Spacer(),

                                // today == null
                                //     ? Shimmer.fromColors(
                                //         baseColor: Colors.grey[300]!,
                                //         highlightColor: Colors.grey[100]!,
                                //         child: Container(
                                //           height: 10,
                                //           color: Colors.white,
                                //         ),
                                //       )
                                //     : Customtext(
                                //         text:
                                //             "${today.hegryDayNumber}"
                                //             " ${today.hegryMonthName} ",
                                //
                                //         textcolor: Colors.white.withOpacity(
                                //           0.8,
                                //         ),
                                //         textsize: ls.fz(14),
                                //         textweight: FontWeight.bold,
                                //       ),
                                // Spacer(),
                              ],
                            );
                          },
                        ),
                        ls.sbh(5),
                        BlocBuilder<PrayerBloc, PrayerState>(
                          builder: (context, state) {
                            final prayerBloc = context.read<PrayerBloc>();
                            final today = prayerBloc.today;
                            return today == null
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 10,
                                      color: Colors.white,
                                    ),
                                  )
                                : Customtext(
                                    text: today.tarrkhMelady,

                                    textcolor: Colors.white.withOpacity(
                                      0.8,
                                    ),
                                    textsize: ls.fz(14),
                                    textweight: FontWeight.bold,
                                  );
                          },
                        ),
                        Customtext(
                          text: 'Next Prayer In:',
                          textcolor: Appcolors.prayerTimesTeal.withOpacity(
                            0.8,
                          ),
                          textsize: ls.fz(26),
                          textweight: FontWeight.bold,
                        ),

                        BlocBuilder<PrayerBloc, PrayerState>(
                          builder: (context, state) {
                            final prayerBloc = context.read<PrayerBloc>();
                            return TimerCountdown(
                              format:
                                  CountDownTimerFormat.hoursMinutesSeconds,
                              endTime: prayerBloc.nextPrayerTime,

                              onEnd: () {
                                print("حان الآن موعد الصلاة!");
                                prayerBloc.onEnd();
                              },

                              timeTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: ls.fz(26),
                                fontWeight: FontWeight.bold,
                              ),
                              descriptionTextStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: ls.fz(11),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: ls.h(-25),
                    left: 0,
                    right: 0,
                    child: Notificatoincontainer(
                      prayerNotificationON: false,
                    ),
                  ),
                ],
              ),

              ls.sbh(30),

              BlocBuilder<PrayerBloc, PrayerState>(
                builder: (context, state) {
                  final prayerBloc = context.read<PrayerBloc>();
                  final today = prayerBloc.today;
                  return Container(
                    margin: ls.p(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: ls.br(45),
                    ),
                    child: today == null
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              children: List.generate(
                                5,
                                (index) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                  ),
                                  title: Container(
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            separatorBuilder: (context, index) =>
                                Divider(thickness: ls.h(1)),

                            itemBuilder: (context, index) {
                              String name = [
                                "الفجر",
                                "الظهر",
                                "العصر",
                                "المغرب",
                                "العشاء",
                              ][index];
                              String time = [
                                today.fajr,
                                today.dhohr,
                                today.asr,
                                today.magrib,
                                today.isha,
                              ][index].split(' ')[0];
                              IconData icon = [
                                Icons.wb_twilight,
                                Icons.wb_sunny,
                                Icons.wb_sunny_outlined,
                                Icons.wb_cloudy_outlined,
                                Icons.nightlight_round,
                              ][index];

                              return Container(
                                decoration: BoxDecoration(
                                  border: prayerBloc.nextPrayerName == name
                                      ? BoxBorder.all(
                                          color: Appcolors.prayerTimesGold,
                                          width: 3,
                                        )
                                      : null,
                                  borderRadius:
                                      BorderRadiusGeometry.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Customicon(
                                        icon: icon,
                                        color:
                                            icon == Icons.wb_sunny ||
                                                icon ==
                                                    Icons.wb_sunny_outlined
                                            ? Appcolors.prayerTimesGold
                                            : Appcolors.prayerTimesTeal,
                                        size: ls.iz(30),
                                      ),
                                      ls.sbw(20),
                                      Customtext(
                                        text: name,
                                        textcolor:
                                            Appcolors.prayerTimesTeal,
                                        textsize: ls.fz(20),
                                        textweight: FontWeight.bold,
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Customtext(
                                          text: time,
                                          textcolor:
                                              Appcolors.prayerTimesTeal,
                                          textsize: ls.fz(20),
                                          textweight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                },
              ),

              ls.sbh(20),
            ],
          );
        },
      ),
    );
  }
}
