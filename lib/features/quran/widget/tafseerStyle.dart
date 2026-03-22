import 'package:flutter/material.dart';
import 'package:quran_library/quran_library.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import 'package:islamicapp/shared/widget/customText.dart';

class QuranStylesProvider {
  static QuranTopBarStyle? _cachedTopBar;
  static TafsirStyle? _cachedTafsir;
  static AyahAudioStyle? _cachedAyah;
  static DisplayModeBarStyle? _displayModeBarStyle;
  static AyahDownloadManagerStyle? _ayahDownloadManagerStyle;
  static SurahAudioStyle? _surahAudioStyle;
  static AyahTafsirInlineStyle? _ayahTafsirInlineStyle;


  static void initAllStyles(BuildContext context) {
    _cachedTopBar = getTopBarStyle(context);
    _cachedTafsir = getTafsirStyle(context);
    _cachedAyah = getAyahAudioStyle(context);
    _displayModeBarStyle = getDisplayModeBarStyle(context);
    _ayahDownloadManagerStyle = getayahDownloadManagerStyle(context);
    _surahAudioStyle = getSurahAudioStyle(context);
    _ayahTafsirInlineStyle = getAyahTafsirInlineStyle(context);

    print(" Quran Styles Cached Successfully");
  }

  static QuranTopBarStyle getTopBarStyle(BuildContext context) =>
      _cachedTopBar ??=
          QuranTopBarStyle.defaults(isDark: false, context: context).copyWith(
            backgroundColor: Colors.white,
            textColor: Appcolors.quranListViewTeal,
            borderRadius: 14,
            height: 80,
            elevation: 2,
            showAudioButton: true,
            showBackButton: false,
            showMenuButton: true,
            showTajweedButton: false,

            iconColor: Appcolors.quranListViewTeal,
            handleColor: Appcolors.quranListViewTeal,
            accentColor: Appcolors.quranListViewTeal,
            fontsDialogNotes: 'Notes',
            fontsDialogDownloadingText: 'text',
            fontsDialogTitle: 'title',
            showFontsButton: false,

            quranTabText: 'القران الكريم ',
            tabIndexLabel: ' الفهرس',

            tabSurahsLabel: 'Tab surah Label',
            tabSearchLabel: 'Tap Search label',
            tabJozzLabel: 'Tap Jozz label',
            tabBookmarksLabel: 'tap BookMark Lable ',
          );

  static AyahAudioStyle getAyahAudioStyle(BuildContext context) =>
      _cachedAyah ??= AyahAudioStyle.defaults(isDark: false, context: context)
          .copyWith(
            backgroundColor: Appcolors.quranListViewTeal,
            textColor: Appcolors.quranListViewWhite,
            borderRadius: 14,
            readerNameInItemColor: Appcolors.quranListViewWhite,
            currentReaderColor: Appcolors.quranListViewWhite,

            dialogReaderTextColor: Appcolors.quranListViewTeal,
            dialogSelectedReaderColor: Appcolors.quranListViewTeal,
            dialogUnSelectedReaderColor: Appcolors.quranListViewTeal,

            ///reverse
            dialogBackgroundColor: Appcolors.quranListViewWhite,
            dialogHeaderTitleColor: Appcolors.quranListViewTeal,

            dialogCloseIconColor: Appcolors.quranListViewTeal,
            dialogBorderRadius: 14,
            downloadedSurahsTabText: 'الصور التي تم تحميلها',

            playIconColor: Appcolors.quranListViewWhite,
            tabIndicatorColor: Appcolors.quranListViewTeal,
            seekBarTimeContainerColor: Appcolors.quranListViewWhite.withOpacity(
              0.2,
            ),
            seekBarActiveTrackColor: Appcolors.quranListViewTeal,
            seekBarInactiveTrackColor: Appcolors.quranListViewWhite,
            seekBarThumbColor: Appcolors.quranListViewWhite.withOpacity(0.75),
            tabLabelColor: Appcolors.quranListViewTeal,
            tabUnselectedLabelColor: Appcolors.quranListViewTeal.withOpacity(
              0.3,
            ),
          );

  static TafsirStyle getTafsirStyle(BuildContext context) => _cachedTafsir ??=
      TafsirStyle.defaults(isDark: false, context: context).copyWith(
        textColor: Appcolors.quranListViewTeal,
        dialogCloseIconColor: Appcolors.quranListViewTeal,

        dialogHeaderBackgroundGradient: LinearGradient(
          colors: [Appcolors.quranListViewTeal],
        ),

        dialogHeaderTitleColor: Appcolors.quranListViewWhite,
        dialogTypeTextStyle: TextStyle(color: Appcolors.quranListViewWhite),
        selectedTafsirColor: Appcolors.quranListViewTeal,
        unSelectedTafsirColor: Appcolors.quranListViewTeal.withOpacity(0.3),
        selectedTafsirTextColor: Appcolors.quranListViewWhite,
        tafsirBackgroundColor: Appcolors.quranListViewWhite,
        currentTafsirColor: Appcolors.quranListViewTeal,
        tafsirName: 'التفسير',
        tafsirNameWidget: Customtext(
          text: 'التفسير',
          textcolor: Appcolors.quranListViewWhite,
          textsize: 25,
          textweight: FontWeight.w700,
        ),
        selectedTafsirBorderColor: Appcolors.quranListViewTeal,
        backgroundColor: Appcolors.quranListViewWhite,
        backgroundTitleColor: Appcolors.quranListViewTeal,
        textTitleColor: Appcolors.quranListViewWhite,
        fontSizeInactiveTrackColor: Colors.red,
        unSelectedTafsirTextColor: Colors.black,
        dividerColor: Colors.red,
        fontSizeBackgroundColor: Appcolors.quranListViewTeal,
        fontSizeThumbColor: Appcolors.quranListViewWhite.withOpacity(0.2),
        fontSizeActiveTrackColor: Appcolors.quranListViewWhite,
      );

  static DisplayModeBarStyle getDisplayModeBarStyle(BuildContext context) =>
      _displayModeBarStyle ??=
          DisplayModeBarStyle.defaults(
            isDark: false,
            context: context,
          ).copyWith(
            backgroundColor: Appcolors.quranListViewWhite,
            borderRadius: 20,
            iconSize: 16,
            showTooltip: true,
            selectedBackgroundColor: Appcolors.quranListViewTeal,
          );

  static AyahDownloadManagerStyle getayahDownloadManagerStyle(
    BuildContext context,
  ) => _ayahDownloadManagerStyle ??=
      AyahDownloadManagerStyle.defaults(
        isDark: false,
        context: context,
      ).copyWith(
        surahNumberDecorationColor: Appcolors.quranListViewTeal,
        avatarDownloadedColor: Appcolors.quranListViewTeal,
        avatarUndownloadedColor: Appcolors.quranListViewTeal.withOpacity(0.2),
        downloadBackground: Appcolors.quranListViewTeal,
        downloadForeground: Appcolors.quranListViewWhite,

        stopButtonBackground: Appcolors.quranListViewWhite,
        stopButtonForeground: Appcolors.quranListViewTeal,
        titleTextStyle: TextStyle(color: Appcolors.quranListViewTeal),
        surahSubtitleStyle: TextStyle(color: Appcolors.quranListViewTeal),
        progressColor: Appcolors.quranListViewTeal,

        progressBackgroundColor: Appcolors.quranListViewTeal.withOpacity(0.2),
      );



  static SurahAudioStyle getSurahAudioStyle(
      BuildContext context,
      ) => _surahAudioStyle ??=
      SurahAudioStyle.defaults(isDark: false, context: context).copyWith(
        playIconColor: Appcolors.quranListViewWhite,
        backIconColor: Appcolors.quranListViewTeal,
        audioSliderBackgroundColor: Appcolors.quranListViewTeal,
        // backgroundColor: Appcolors.quranListViewTeal,// no
        surahNameColor: Colors.teal, //
        downloadProgressColor: Appcolors.quranListViewTeal,

        seekBarThumbColor: Appcolors.quranListViewWhite.withOpacity(0.6), //
        seekBarActiveTrackColor: Appcolors.quranListViewWhite, //
        readerNameTextStyle: TextStyle(color: Appcolors.quranListViewWhite), //
        timeContainerColor: Appcolors.quranListViewWhite, //
        // dialogHeaderTitleColor: Colors.red,
        selectedItemColor: Appcolors.quranListViewTeal,

        textColor: Appcolors.quranListViewTeal,
        primaryColor: Appcolors.quranListViewTeal,
        // backgroundColor: Appcolors.quranListViewWhite,
        secondaryTextColor: Appcolors.quranListViewTeal,
      );








  static AyahTafsirInlineStyle getAyahTafsirInlineStyle(
      BuildContext context,
      ) => _ayahTafsirInlineStyle ??=
      AyahTafsirInlineStyle.defaults(
        isDark: false,
        context: context,
      ).copyWith(
        copyIconColor: Appcolors.quranListViewWhite,
        backgroundColor: Appcolors.quranListViewWhite,
        tafsirBackgroundColor: Appcolors.quranListViewWhite,
        fontSizeIconColor: Appcolors.quranListViewTeal,
        readMoreTextStyle: TextStyle(
          fontSize: 16,
          color: Appcolors.quranListViewTeal,
        ),

        readMoreButtonColor: Appcolors.quranListViewWhite,
        playIconColor: Appcolors.quranListViewWhite,
        playAllIconColor: Appcolors.quranListViewWhite,
        ayahNumberBackgroundColor: Appcolors.quranListViewTeal,
      );





}
