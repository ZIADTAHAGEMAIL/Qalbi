
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import 'package:islamicapp/features/sibha/bloc/sibhaCubit.dart';
import 'package:islamicapp/features/sibha/bloc/sibhaState.dart';
import 'package:islamicapp/features/sibhaDetails/view/sibhaDetailsView.dart';
import 'package:islamicapp/shared/widget/customIcons.dart';
import 'package:islamicapp/shared/widget/customText.dart';
import '../widget/sibhaCounter.dart';
import '../widget/sibhaContainer.dart';

class Sibhaview extends StatelessWidget {
  const Sibhaview({super.key});

  @override
  Widget build(BuildContext context) {
    return ScalifyBox(
      referenceWidth: 360,
      referenceHeight: 731,
      builder: (context, ls) {
        return Scaffold(
          backgroundColor: Appcolors.SibhaviewTeal,
          appBar: AppBar(
            toolbarHeight: ls.h(40),
            backgroundColor: Appcolors.SibhaviewTeal,
            elevation: 0,
            leadingWidth: 80,
            leading: Padding(
              padding: ls.p(12),
              child: Customicon(
                icon: Icons.arrow_back_ios,
                color: Appcolors.SibhaviewGold,
                size: ls.iz(26),
                ontap: () => Navigator.pop(context),
              ),
            ),

            title: Customtext(
              text: 'Digital Tasbeeh',
              textcolor: Appcolors.SibhaviewGold,
              textsize: ls.fz(25),
              textweight: FontWeight.w700,
            ),
            actionsPadding:ls.p(12) ,
            actions: [
              Customicon(
                ontap: () async {
                  final item = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => Sibhadetailsview()),
                  );
                  if (item != null) {
                    context.read<SibhaCubit>().selectZikr(item);
                  }
                },
                icon: Icons.list_sharp,
                color: Appcolors.SibhaviewGold,
                size: ls.iz(35),
              ),
            ],
            centerTitle: true,
          ),
          body: Column(
            children: [
              ls.sbh(20),
              Container(
                height: ls.h(4),
                color: Appcolors.SibhaviewGold,
              ),
              ls.sbh(60),
              sibhaCounter(),
              ls.sbh(60),
              BlocBuilder<SibhaCubit, SibhaState>(
                builder: (context, state) {
                  final cubit = context.read<SibhaCubit>();
                  return GestureDetector(
                    onTap: () {
                      cubit.resetCounter();
                    },
                    child: const Sibhacontainer(
                      text: 'Reset',
                      icon: Icons.restart_alt,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
