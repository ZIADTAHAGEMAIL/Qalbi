import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:islamicapp/features/home/widgets/dailyAyaahCard.dart';
import 'package:islamicapp/features/home/widgets/gridItem.dart';
import 'package:islamicapp/features/home/widgets/prayerCard.dart';
import 'package:islamicapp/features/prayer/bloc/prayerBloc.dart';
import 'package:islamicapp/features/prayer/bloc/prayerState.dart';
import 'package:islamicapp/features/zakat/view/zakaatView.dart';
import 'package:islamicapp/shared/widget/customText.dart';
import 'package:quran/quran.dart' as quran;

import '../data/tafseerApi.dart';

class homeView extends StatefulWidget {

  const homeView({super.key});

  @override
  State<homeView> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }
  TafseerRepo _tafseerRepo = TafseerRepo();
  quran.RandomVerse ayah=quran.RandomVerse();
  late String randomAyah=ayah.verse;
late int suranumber=ayah.surahNumber;
late int verseNumber=ayah.verseNumber;


  Future<void> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ScalifyBox(
          referenceWidth: 360,
          referenceHeight: 731,
          builder: (context, ls) {
            return SingleChildScrollView(
              // assets/home/homeBackground.webp
              scrollDirection: Axis.vertical,

              padding: ls.ph(24),
              child: Column(
                spacing: ls.s(22),
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.end,

                   children: [

                   Customtext(
                     text: 'مرحبا',
                     textcolor: Colors.black,
                     textsize: ls.fz(28),
                     textweight: FontWeight.bold,
                   ),
                   Customtext(
                     text: 'زياد',
                     textcolor: Colors.black,
                     textsize: ls.fz(22),
                     textweight: FontWeight.w700,
                   ),
                 ],),

                  BlocBuilder<PrayerBloc,PrayerState>(

                    builder: (context,state){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Customtext(
                            text: '${context.read<PrayerBloc>().today?.hegry}  ••• '
                                ' ${context.read<PrayerBloc>().today?.tarrkhMelady}',
                            textcolor: Colors.grey,
                            textsize: ls.fz(14),
                            textweight: FontWeight.w700,
                          ),
                        ],
                      );
                    },

                  ),

                  Prayercard(ls: ls),

                  Dailyayaahcard(ls: ls, randomAyah: randomAyah,
                    surahNumber: suranumber, verseNumber: verseNumber,onTap: ()
                    async{

                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (context) => const Center(child: CircularProgressIndicator(color: Color(0xff0e4e58))),
                      // );


                      final tafseer = await _tafseerRepo.getTafsirFromApi(suranumber, verseNumber);

                      // Navigator.pop(context);

                        _showTafsirBottomSheet(context, tafseer);


                    },),

                  Column(
                    spacing: ls.s(15),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Griditem(
                            ls: ls,
                            ontap: () {
                              context.go('/Homeview/qiblaView');
                            },
                            title: 'القبلة',
                            icon: Icons.explore_outlined,
                          ),
                          Griditem(
                            ls: ls,
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => ZakatCalculatorView(),
                                ),
                              );
                            },
                            title: 'الذكاة',
                            icon: Icons.volunteer_activism_outlined,
                          ),
                          Griditem(
                            ls: ls,
                            ontap: () {
                              context.go('/Homeview/hadithView');
                            },
                            title: 'حديث',
                            icon: FlutterIslamicIcons.hadji,
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Griditem(
                            ls: ls,
                            ontap: () {
                              context.go('/Homeview/azkaarView');
                            },
                            icon: FlutterIslamicIcons.prayer,
                            title: ' اذكار',
                          ),
                          Griditem(
                            ls: ls,
                            ontap: () {
                              context.go('/Homeview/Sibhaview');
                            },
                            title: 'سبحة الكترونية',
                            icon: FlutterIslamicIcons.tasbihHand,
                          ),
                          Griditem(
                            ls: ls,
                            ontap: () {
                              context.go('/Homeview/prayerTimesview');
                            },
                            title: 'اوقات الصلاة',
                            icon: Icons.access_time,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  void _showTafsirBottomSheet(BuildContext context, String tafsirText) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("التفسير الميسر", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                tafsirText,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

}
