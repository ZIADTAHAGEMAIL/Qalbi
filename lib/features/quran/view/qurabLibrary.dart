import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import 'package:quran_library/quran_library.dart';

import '../widget/tafseerStyle.dart';

class Quranview extends StatefulWidget {
  const Quranview({super.key});

  @override
  State<Quranview> createState() => _QuranviewState();
}

class _QuranviewState extends State<Quranview> {
  int idx = 1;

  late QuranTopBarStyle _topStyle;
  late AyahAudioStyle _ayahStyle;
  late TafsirStyle _tafsirStyle;
  late DisplayModeBarStyle _displayModeBarStyle;
  late AyahDownloadManagerStyle _AyahDownloadManagerStyle;
  late SurahAudioStyle _SurahAudioStyle;
  late AyahTafsirInlineStyle _ayahTafsirInlineStyle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _topStyle = QuranStylesProvider.getTopBarStyle(context);//
    _ayahStyle = QuranStylesProvider.getAyahAudioStyle(context);//
    _tafsirStyle = QuranStylesProvider.getTafsirStyle(context);//
    _SurahAudioStyle = QuranStylesProvider.getSurahAudioStyle(context);//
    _displayModeBarStyle = QuranStylesProvider.getDisplayModeBarStyle(context);
    _AyahDownloadManagerStyle = QuranStylesProvider.getayahDownloadManagerStyle(
      context,
    );

    _ayahTafsirInlineStyle = QuranStylesProvider.getAyahTafsirInlineStyle(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: QuranLibraryScreen(
              parentContext: context,

              topBarStyle: _topStyle,
              ayahStyle: _ayahStyle,
              tafsirStyle: _tafsirStyle,

              snackBarStyle: SnackBarStyle.defaults(
                isDark: false,
                context: context,
              ),

              useDefaultAppBar: true,
              withPageView: true,
              isShowAudioSlider: true,
              enableWordSelection: true,
              showAyahBookmarkedIcon: true,

              surahInfoStyle:
                  SurahInfoStyle.defaults(
                    isDark: false,
                    context: context,
                  ).copyWith(
                    surahNumberColor: Appcolors.quranListViewTeal,
                    titleColor: Appcolors.quranListViewWhite,
                    indicatorColor: Appcolors.quranListViewTeal,

                    backgroundColor: Appcolors.quranListViewWhite,
                    textColor: Appcolors.quranListViewWhite,
                    surahNumberDecorationColor: Appcolors.quranListViewWhite,
                    primaryColor: Appcolors.quranListViewTeal,
                    surahNameColor: Appcolors.quranListViewTeal,
                  ),

              searchTabStyle: SearchTabStyle.defaults(
                isDark: false,
                context: context,
              ).copyWith(surahChipBgColor: Appcolors.quranListViewTeal),
              bannerStyle: BannerStyle.defaults(
                isDark: false,
              ).copyWith(svgBannerColor: Appcolors.quranListViewTeal),

              displayModeBarStyle: _displayModeBarStyle,

              indexTabStyle:
                  IndexTabStyle.defaults(
                    isDark: false,
                    context: context,
                  ).copyWith(
                    labelColor: Appcolors.quranListViewWhite,
                    accentColor: Appcolors.quranListViewTeal,

                    textColor: Appcolors.quranListViewTeal,
                    surahNumberDecorationColor: Appcolors.quranListViewWhite,
                  ),
              surahStyle: _SurahAudioStyle,

              ayahDownloadManagerStyle: _AyahDownloadManagerStyle,

              ayahTafsirInlineStyle:_ayahTafsirInlineStyle,


              onAyahLongPress: (details, model) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildMenuItem(
                          icon: Icons.menu_book,
                          label: "التفسير",
                          onTap: () {
                            Navigator.pop(context);
                            details.showTafsirOnTap(
                              context: context,
                              externalTafsirStyle: _tafsirStyle,
                              ayahNum: model.ayahUQNumber,
                              pageIndex: model.page - 1,
                              ayahUQNum: model.ayahUQNumber,
                              ayahNumber: model.ayahNumber,
                            );
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.copy,
                          label: "نسخ",
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: model.text ?? ""),
                            );
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("تم النسخ"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.play_circle_fill,
                          label: "تشغيل",
                          onTap: () async {
                            Navigator.pop(context);
                            // Play all words of an ayah sequentially
                            await QuranLibrary().playAyahWordsAudioByNumbers(
                              surahNumber: model.surahNumber!,
                              ayahNumber: model.ayahNumber,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Appcolors.quranListViewTeal, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Appcolors.quranListViewTeal,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
