import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/responsive_scale/scalify_box.dart';

import '../../../core/constant/appColors.dart';
import '../../../shared/widget/customText.dart';
import '../cubit/hadithCubit.dart';
import '../cubit/hadithState.dart';
import '../widgets/card.dart';

class favouritesView extends StatelessWidget {
  const favouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<hadithCubit>().getFavourites();
    return ScalifyBox(
      referenceWidth: 360,
      referenceHeight: 820,
      builder: (context, ls) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Appcolors.hadithViewTeal,
            centerTitle: true,
            title: Customtext(
              text: 'المفضلة',
              textcolor: Appcolors.hadithViewGold,
              textsize: ls.fz(30),
              textweight: FontWeight.bold,
            ),
            // leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:
            // Icon(Icons.arrow_back)),
          ),
          backgroundColor: Appcolors.hadithViewTeal,
          body: BlocBuilder<hadithCubit, hadithState>(
            builder: (context, state) {
              final cubit = context.read<hadithCubit>();
              if (state is favouriteLoaded) {
                return ListView.builder(
                  itemCount: state.favouritesHadiths.length,
                  itemBuilder: (context, index) {
                    final item = state.favouritesHadiths[index];
                    return hadithCardView(
                      ls: ls,
                      item: item,
                      favouriteOnTap: () {
                        cubit.togleFavourites(item);
                      },
                      isFavourite: cubit.favourites.containsKey(item.hadithNumber),
                    );
                  },
                );
              } else if (state is hadithError) {
                return Center(child: Text('Error'));
              } else {
                return Center(child: Text(state.toString()),);
              }
            },
          ),
        );
      },
    );
  }
}
