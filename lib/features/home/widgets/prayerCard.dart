import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:islamicapp/features/prayer/bloc/prayerBloc.dart';
import 'package:islamicapp/features/prayer/bloc/prayerState.dart';

import '../../../shared/widget/customText.dart';

class Prayercard extends StatelessWidget {
  final LocalScaler ls;
  const Prayercard({super.key, required this.ls});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ls.p(20),
      decoration: BoxDecoration(
        borderRadius: ls.br(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF32B38F), Color(0xFF1D8E74)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<PrayerBloc,PrayerState>(
            buildWhen: (previousState, currentState){
              return currentState is PrayerError;
            },
            builder: (context,state){
print('Home Builder');
              if (state is Prayerloaded){
                final cubit=context.read<PrayerBloc>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [

                  Customtext(
                    text: 'الصلاة القادمة: ${cubit.nextPrayerName}',
                    textcolor: Colors.white70,
                    textsize: ls.fz(16),
                    textweight: FontWeight.w700,
                  ),

                  ls.sbh(5),
                  BlocBuilder<PrayerBloc,PrayerState>
                    (builder: (context,state){
                    final prayerBloc = context.read<PrayerBloc>();
                    return  TimerCountdown(
                      format: CountDownTimerFormat.hoursMinutesSeconds,
                      endTime: prayerBloc.nextPrayerTime,

                      onEnd: () {
                        print("حان الآن موعد الصلاة!");
                        prayerBloc.onEnd();
                      },

                      timeTextStyle:  TextStyle(
                        color: Colors.white,
                        fontSize: ls.fz(26),
                        fontWeight: FontWeight.bold,
                      ),
                      descriptionTextStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: ls.fz(11),
                      ),
                    );
                  }),


                  ls.sbh(5),
                  Customtext(
                    text: cubit.nextPrayerTimeString,
                    textcolor: Colors.white,
                    textsize: ls.fz(16),
                    textweight: FontWeight.w700,
                  ),
                ],
              );}
              else if (state is PrayerLoading) {return CircularProgressIndicator();}
              else {
                return Text('error');
              }
            },
          ),
           Icon(Icons.mosque, size: ls.iz(80), color: Colors.white24),
        ],
      ),
    );
  }
}
