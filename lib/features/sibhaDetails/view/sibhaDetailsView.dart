import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:islamicapp/features/sibha/bloc/sibhaCubit.dart';
import 'package:islamicapp/features/sibha/bloc/sibhaState.dart';
import 'package:islamicapp/features/sibhaDetails/widget/dialoge.dart';

import '../../../core/constant/appColors.dart';
import '../../../shared/widget/customIcons.dart';
import '../../../shared/widget/customText.dart';

class Sibhadetailsview extends StatefulWidget {
  Sibhadetailsview({super.key});

  @override
  State<Sibhadetailsview> createState() => _SibhadetailsviewState();
}

class _SibhadetailsviewState extends State<Sibhadetailsview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SibhaCubit>().initial();
  }

  @override
  Widget build(BuildContext context) {
    return ScalifyBox(
      referenceWidth: 360,
      referenceHeight: 731,
      builder: (context, ls) {
        return Scaffold(
          backgroundColor: Appcolors.SibhaviewTeal,

          appBar: AppBar(
            toolbarHeight: ls.h(55),
            backgroundColor: Appcolors.SibhaviewTeal,
            elevation: 0,
            leadingWidth: 80,

            leading: Customicon(
              icon: Icons.arrow_back_ios,
              color: Appcolors.SibhaviewGold,
              size: ls.iz(26),
              ontap: () => Navigator.pop(context),
            ),

            title: Customtext(
              text: ' Tasabeeh',
              textcolor: Appcolors.SibhaviewGold,
              textsize: ls.fz(25),
              textweight: FontWeight.w700,
            ),

actionsPadding: ls.ph(12),
            actions: [
              InkWell(
                onTap: () {
                  context.read<SibhaCubit>().resetTasabeeh();
                },
                child: Customicon(
                  icon: Icons.autorenew_rounded,
                  color: Appcolors.SibhaviewGold,
                  size: ls.iz(35),
                ),
              ),
              Customicon(
                ontap: () {
                  final cubit = context.read<SibhaCubit>();
                  showDialog(
                    context: context,
                    builder: (context) => dialoge(
                      controller: cubit.controller,
                      onAdd: () {
                        if (cubit.controller.text.isNotEmpty) {
                          cubit.addToTassabeeh();

                          Navigator.pop(context);
                        }
                      },
                    ),
                  );
                },
                icon: Icons.add,
                color: Appcolors.SibhaviewGold,
                size: ls.iz(35),
              ),
            ],
            centerTitle: true,
          ),
          body: Column(
            children: [
              ls.sbh(20),
              Container(height: 4.s, color: Appcolors.SibhaviewGold),
              ls.sbh(20),

              Expanded(
                child: BlocBuilder<SibhaCubit, SibhaState>(
                  builder: (context, state) {
                    final cubit = context.read<SibhaCubit>();
                    return ListView.builder(
                      itemCount: cubit.Tasaabeeh.length,
                      itemBuilder: (context, index) {
                        final item = cubit.Tasaabeeh[index];
                        return Padding(
                          padding: [8, 6].p,
                          child: Dismissible(
                            key: UniqueKey(),

                            direction: DismissDirection.endToStart,
                            onDismissed: (DismissDirection) {
                              cubit.removeFromTassabeeh(index);
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                  context,
                                  cubit.Tasaabeeh[index].keys.first,
                                );
                              },
                              child: Container(
                                constraints: BoxConstraints(minHeight: 60),

                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Appcolors.SibhaviewGold,
                                  borderRadius: ls.br(15),
                                  border: BoxBorder.all(
                                    width: ls.w(4),
                                    color: Colors.lime,
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Customicon(
                                        icon:
                                            cubit.Tasaabeeh[index].values.first
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color: Colors.black,
                                        size: ls.iz(30),
                                      ),

                                      Expanded(
                                        child: Text(
                                          textAlign: .center,
                                          textDirection: TextDirection.rtl,

                                          item.keys.first,
                                          style: TextStyle(
                                            color: Appcolors.SibhaviewTeal,
                                            fontSize: ls.fz(28),
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
