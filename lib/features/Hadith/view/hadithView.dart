import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:go_router/go_router.dart';
import 'package:islamicapp/features/Hadith/cubit/hadithCubit.dart';
import 'package:islamicapp/features/Hadith/cubit/hadithState.dart';
import 'package:islamicapp/features/Hadith/widgets/card.dart';
import 'package:islamicapp/shared/widget/customText.dart';

import '../../../core/constant/appColors.dart';

class hadithView extends StatefulWidget {
  const hadithView({super.key});

  @override
  State<hadithView> createState() => _hadithViewState();
}

class _hadithViewState extends State<hadithView> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<hadithCubit>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScalifyBox(
      referenceWidth: 360,
      referenceHeight: 820,
      builder: (context, ls) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Appcolors.hadithViewTeal,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Appcolors.hadithViewGold,
                size: ls.s(28),
              ),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/Homeview/hadithView');
                }
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  // context.read<hadithCubit>().getFavourites();
                  context.push('/Homeview/hadithView/favouritesView');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (c) => favouritesView()),
                  // );
                },
                child: Padding(
                  padding: [12, 16].p,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                       Icon(Icons.favorite, color: Colors.red,
                      size: ls.s(25),),
                      Positioned(
                        left: ls.w(-7.5),
                        top: ls.h(-1),
                        child: CircleAvatar(
                          radius: ls.w(8),
                          backgroundColor: Colors.red.shade900,
                          child: BlocBuilder<hadithCubit, hadithState>(
                            builder: (context, state) {
                              return Text(
                                context
                                    .watch<hadithCubit>()
                                    .favouriteshadith
                                    .length
                                    .toString(),
                                style:  TextStyle(
                                  fontSize: ls.s(12),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            centerTitle: true,
            title: Customtext(
              text: 'احاديث',
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
              if (state is hadithloaded || state is favouriteLoaded) {
                return ListView.builder(
                  itemCount: cubit.hadith.length,
                  itemBuilder: (context, index) {
                    final item = cubit.hadith[index];
                    return hadithCardView(
                      ls: ls,
                      item: item,
                      favouriteOnTap: () {
                        cubit.togleFavourites(item);
                      },
                      isFavourite: cubit.favourites.containsKey(
                        item.hadithNumber,
                      ),
                    );
                  },
                );
              } else if (state is hadithError) {
                return Center(child: Text('Error'));
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        );
      },
    );
  }
}
