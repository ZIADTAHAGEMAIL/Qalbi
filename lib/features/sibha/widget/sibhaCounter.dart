

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:islamicapp/features/sibha/bloc/sibhaCubit.dart';
import 'package:islamicapp/features/sibha/bloc/sibhaState.dart';
import 'package:islamicapp/shared/widget/customText.dart';
import '../../../core/constant/appColors.dart';

class sibhaCounter extends StatelessWidget {

   sibhaCounter({
    super.key,

  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SibhaCubit,SibhaState>(

      builder: (context,State) {
        final cubit= context.read<SibhaCubit>();
        return GestureDetector(
          onTap: () {

           cubit.increament();


            },
          child: Center(
            child: ScalifyBox(
              referenceWidth: 360,
              referenceHeight: 731,
              fit: ScalifyFit.contain,
              alignment: Alignment.center,
              builder: (context, ls) {
                final double size = ls.w(300);

                return SizedBox(
                  height: size,
                  width: size,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// الدائرة الخارجية
                      Container(
                        height: size,
                        width: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Appcolors.SibhaviewGold,
                          boxShadow: [
                            BoxShadow(
                              color: Appcolors.SibhaviewGold.withOpacity(
                                0.3,
                              ),
                              blurRadius: ls.w(20),
                              offset: Offset(ls.w(6), ls.w(6)),
                            ),
                          ],
                        ),
                      ),

                      /// الدائرة الثانية
                      Container(
                        height: size * 0.95,
                        width: size * 0.95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Appcolors.SibhaviewTeal,
                        ),
                      ),

                      /// المؤشر
                      SizedBox(
                        height: size * 0.85,
                        width: size * 0.85,
                        child: CircularProgressIndicator(
                          value: cubit.current/cubit.base,
                          strokeWidth: size * 0.025,
                          strokeCap: StrokeCap.round,
                          backgroundColor: Colors.teal.shade900,
                          valueColor: AlwaysStoppedAnimation(
                            Appcolors.SibhaviewGold,
                          ),
                        ),
                      ),

                      /// المحتوى الداخلي
                      FittedBox(
                        child: Container(
                          height: size * 0.75,
                          width: size * 0.75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.teal.shade800, Colors.teal.shade900],
                            ),
                            border: Border.all(
                              color: Appcolors.SibhaviewGold,
                              width: size * 0.01,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Gap(size * 0.06),

                              Customtext(
                                text: cubit.base.toString(),
                                textcolor: Appcolors.SibhaviewGold,
                                textsize: size * 0.09,
                                textweight: FontWeight.w600,
                              ),

                               SizedBox(
                                 height: size * 0.26,
                                 width: size * 0.6,
                                 child: Center(
                                   child: Text(
                                     textAlign: TextAlign.center,
                                     textDirection: TextDirection.rtl,
                                     cubit.item??'سبحان الله',
                                    maxLines: 2,

                                    overflow: TextOverflow.ellipsis,

                                    style: TextStyle(
                                      color: Appcolors.SibhaviewGold,
                                      fontSize: size * 0.08,
                                      fontWeight: FontWeight.w600,
                                    ),
                                                             ),
                                 ),
                               ),
                              Customtext(

                                text: cubit.current.toString(),
                                textcolor: Appcolors.SibhaviewGold,
                                textsize: size * 0.18,
                                textweight: FontWeight.bold,
                              ),

                              const Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
}
