import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:islamicapp/features/Hadith/data/hadithModel.dart';

import '../../../core/constant/appColors.dart';
import '../../../shared/widget/customText.dart';
import '../cubit/hadithCubit.dart';

class hadithCardView extends StatelessWidget {
  final LocalScaler ls;
  final HadithModel item;
  final VoidCallback favouriteOnTap;
  final bool isFavourite;
  const hadithCardView({
    super.key,
    required this.ls,
    required this.item,
    required this.favouriteOnTap,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<hadithCubit>();
    print('UI is looking at Cubit ID: ${cubit.hashCode}');
    return Padding(
      padding: ls.p(8),
      child: GestureDetector(
        onTap: (){
          cubit.togleFavourites(item);

        },
        child: Card(
          elevation: 5,
          shadowColor: Appcolors.hadithWhite,
          child: Container(
            padding: ls.p(20),
            decoration: BoxDecoration(
              borderRadius: ls.br(20),
              color: Appcolors.hadithWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: ls.br(15),
                    color: Appcolors.hadithViewGold,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: favouriteOnTap,
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      Spacer(),
                      Customtext(
                        text: item.hadithNumber,
                        textcolor: Appcolors.hadithViewTeal.withOpacity(0.5),
                        textsize: ls.fz(16),
                        textweight: FontWeight.w600,
                      ),
                      Customtext(
                        text: 'رقم الحديث: ',
                        textcolor: Appcolors.hadithViewTeal,
                        textsize: ls.fz(16),
                        textweight: FontWeight.w600,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Customtext(
                  text: 'صحيح بخاري',
                  textcolor: Appcolors.hadithViewTeal.withOpacity(0.5),
                  textsize: ls.fz(14),
                  textweight: FontWeight.w600,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Customtext(
                      text: 'صحيح',
                      textcolor: Appcolors.hadithViewTeal.withOpacity(0.5),
                      textsize: ls.fz(16),
                      textweight: FontWeight.w600,
                    ),
                    Customtext(
                      text: 'نوع الحديث : ',
                      textcolor: Appcolors.hadithViewTeal,
                      textsize: ls.fz(16),
                      textweight: FontWeight.w600,
                    ),
                  ],
                ),

                Text(
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                  maxLines: 3,
                  item.headingArabic,
                  style: TextStyle(
                    color: Appcolors.hadithViewTeal.withOpacity(0.5),
                    fontSize: ls.fz(18),
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Container(
                  width: double.infinity,
                  child: Customtext(
                    text: item.hadithArabic,
                    textcolor: Appcolors.hadithViewTeal,
                    textsize: ls.fz(22),
                    textweight: FontWeight.w900,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Customtext(
                      text: item.chapterName,
                      textcolor: Appcolors.hadithViewTeal.withOpacity(0.3),
                      textsize: ls.fz(14),
                      textweight: FontWeight.w900,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
