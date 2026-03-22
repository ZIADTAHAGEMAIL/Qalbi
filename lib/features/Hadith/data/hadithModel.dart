class HadithModel {
  final int hadithId;

  final String hadithNumber;
  final String hadithArabic;
  final String headingArabic;

  final String chapterName;
  final int chapterId;

  final int bookId;
  final String bookName;

  HadithModel({
    required this.hadithId,
    required this.hadithNumber,
    required this.hadithArabic,

    required this.headingArabic,

    required this.bookId,
    required this.bookName,

    required this.chapterId,
    required this.chapterName,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      hadithId: json['id']??0,
      hadithNumber: json['hadithNumber']??"Null",
      hadithArabic: json['hadithArabic']??"Null",

      headingArabic: json['headingArabic']??"Null",
      bookId: json['book']['id']??0,
      bookName: json['book']['bookName']??"Null",
      chapterId: json['chapter']['id']??0,
      chapterName: json['chapter']['chapterArabic']??"Null",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': hadithId,
      'hadithNumber': hadithNumber,
      'hadithArabic': hadithArabic,
      'headingArabic': headingArabic,
      'book': {
        'id': bookId,
        'bookName': bookName,
      },
      'chapter': {
        'id': chapterId,
        'chapterArabic': chapterName,
      },
    };
  }
}
