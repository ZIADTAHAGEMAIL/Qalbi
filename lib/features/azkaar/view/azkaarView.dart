import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import 'package:islamicapp/features/azkaar/widget/azkaarContainer.dart';
import 'package:islamicapp/features/azkaar/widget/azkaarTimeContainer.dart';
import 'package:islamicapp/shared/widget/customIcons.dart';
import 'package:islamicapp/shared/widget/customText.dart';

import '../cubit/azkaarCubit.dart';
import '../cubit/azkkrState.dart';

class azkaarView extends StatefulWidget {
  const azkaarView({super.key});

  @override
  State<azkaarView> createState() => _azkaarViewState();
}

class _azkaarViewState extends State<azkaarView> {
  List<String >timing=[
    'الصباح والمساء',
    'قبل النوم',
    'بعد الصحيان'
  ];
  List<String >timingNameInJson=[
    "أذكار الصباح والمساء",
    "أذكار النوم",
    "أذكار الاستيقاظ من النوم",
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return ScalifyBox(
      referenceWidth: 360,
      referenceHeight: 820,
      builder: (context,ls){
        return   Scaffold(
          appBar: AppBar(
            leadingWidth: 60.s,
            toolbarHeight: 60.h.clamp(56.0, 90.0),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Customtext(
              text: "اذكار",
              textcolor: Appcolors.azkaarWhite,
              textsize: 24.fz,
              textweight: FontWeight.w700,
            ),

            centerTitle: true,
            flexibleSpace: Container(

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF184957),
                    Color(0xFF4d6357),
                    Color(0xFF646d56),
                    Color(0xFF2b5255),
                  ],
                ),
              ),
            ),
actionsPadding: ls.ph(10),
            actions: [
              BlocListener<azkaarCubit,Azkkrstate>(
                listener: (context,state){

                },
                child: PopupMenuButton<String>(
                  color: Appcolors.azkaarWhite,
                  icon: Icon(Icons.menu, color: Appcolors.azkaarWhite, size: ls.iz(30)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  popUpAnimationStyle: AnimationStyle(duration: Duration(milliseconds: 500)),


                  onSelected: (String value) {
                    BlocProvider.of<azkaarCubit>(context).selectFromMenuDone(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      _buildPopupItem("دعاء دخول الخلاء", Icons.mosque),
                      _buildPopupItem("دعاء الخروج من الخلاء", Icons.menu_book),
                      _buildPopupItem("دعاء الخروج من الخلاءالذكر بعد الفراغ من الوضوء", Icons.flight_takeoff),
                      _buildPopupItem("الذكر عند الخروج من المنزل", Icons.restaurant),

                      _buildPopupItem("الذكر عند دخول المنزل", Icons.mosque),
                      _buildPopupItem("دعاء الذهاب إلى المسجد", Icons.menu_book),
                      _buildPopupItem("دعاء دخول المسجد", Icons.flight_takeoff),
                      _buildPopupItem("دعاء الخروج من المسجد", Icons.restaurant),

                      _buildPopupItem("أذكار الآذان", Icons.mosque),
                      _buildPopupItem("دعاء ُلبْس الثوب", Icons.menu_book),
                      _buildPopupItem("دعاء ُلبْس الثوب الجديد", Icons.flight_takeoff),
                      _buildPopupItem("الدعاء لمن لبس ثوبا جديدا", Icons.restaurant),

                      _buildPopupItem("ما يقول إذا وضع ثوبه", Icons.mosque),
                      _buildPopupItem("دعاء الاستفتاح", Icons.menu_book),
                      _buildPopupItem("دعاء الركوع", Icons.flight_takeoff),
                      _buildPopupItem("دعاء الرفع من الركوع", Icons.restaurant),

                      _buildPopupItem("دعاء السجود", Icons.mosque),
                      _buildPopupItem("دعاء الجلسة بين السجدتين", Icons.menu_book),
                      _buildPopupItem("دعاء سجود التلاوة", Icons.flight_takeoff),
                      _buildPopupItem("التشهد", Icons.restaurant),






                      _buildPopupItem("الصلاة على النبي بعد التشهد", Icons.restaurant),
                      _buildPopupItem("الدعاء بعد التشهد الأخير قبل السلام", Icons.restaurant),
                      _buildPopupItem("الأذكار بعد السلام من الصلاة", Icons.restaurant),
                      _buildPopupItem("دعاء صلاة الاستخارة", Icons.restaurant),
                      _buildPopupItem("الدعاء إذا تقلب ليل", Icons.restaurant),
                      _buildPopupItem("دعاء الفزع في النوم و من بُلِيَ بالوحشة", Icons.restaurant),







                    ];
                  },
                ),
              ),
            ],
            leading: IconButton(
              color: Appcolors.azkaarWhite,

              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: 25.iz),
            ),
          ),


          body: Container(
            height: ls.h(double.infinity),
            width: ls.w(double.infinity),
            child: Stack(
              children: [
                Image.asset(
                  'assets/azkaar/azkaarBackground.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                BlocBuilder<azkaarCubit, Azkkrstate>(

                  builder: (context, state) {
                    final cubit=context
                        .read<azkaarCubit>()
                    ;
                    return Padding(
                      padding: ls.ph(20),
                      child: Column(
                        children: [
                          ls.sbh(30),
                          if(!cubit.selectedFromMenu)
                            Container(
                              height: ls.h(40).clamp(30, 100),
                              decoration: BoxDecoration(
                                color: Appcolors.azkaarViewGold,
                                borderRadius: ls.br(14),
                              ),
                              child: BlocListener<azkaarCubit, Azkkrstate>(

                                listener: (context, state) {
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children:List.generate(timing.length,(index){
                                    return
                                      Azkaartimecontainer(
                                        text: timing[index],
                                        isSelected:
                                        cubit
                                            .selected ==
                                            index+1,

                                        ontap: () {
                                          cubit
                                              .selected=index+1;
                                          cubit
                                              .getazkarByCateogory(
                                            timingNameInJson[index],
                                          );
                                        },
                                      );

                                  }
                                  ),
                                ),
                              ),
                            ),
                          ls.sbh(30),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                              cubit
                                  .azkaarUnderCategory
                                  ?.items
                                  .length ??
                                  0,
                              scrollDirection: Axis.vertical,

                              itemBuilder: (context, index) {
                                final item = cubit
                                    .azkaarUnderCategory!
                                    .items[index];
                                return Padding(
                                  padding: ls.pv(8),
                                  child: state is AzkaarLoading
                                      ? CircularProgressIndicator()
                                      : Azkaarcontainer(
                                    zikr: item.text.toString(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ls.sbh(100),
              ],
            ),
          ),
        );
      },

    );
  }
}

PopupMenuItem<String> _buildPopupItem(String title, IconData icon) {
  return PopupMenuItem<String>(
    value: title,
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Customtext(
            text: title,
            textsize: 14,
            textcolor: Colors.black,
            textweight: FontWeight.bold,
          ),
          const SizedBox(width: 10),
          Customicon(icon: icon, color: Appcolors.azkaarViewTeal, size: 22)
        ],
      ),
    ),
  );
}
