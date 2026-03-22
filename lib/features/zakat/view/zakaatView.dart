import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:islamicapp/core/constant/appColors.dart';
import 'package:islamicapp/features/zakat/widget/snackBar.dart';
import 'package:islamicapp/shared/widget/customIcons.dart';
import 'package:islamicapp/shared/widget/customText.dart';

import '../widget/zakkatInputCard.dart';

class ZakatCalculatorView extends StatefulWidget {
  const ZakatCalculatorView({super.key});

  @override
  State<ZakatCalculatorView> createState() => _ZakatCalculatorViewState();
}

class _ZakatCalculatorViewState extends State<ZakatCalculatorView> {
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _goldWeightController = TextEditingController();
  final TextEditingController _goldPriceController = TextEditingController(

  );

  double _zakatResult = 0.0;
  bool _isEligible = false;

  @override
  void initState() {
    super.initState();
    _cashController.addListener(() => setState(() {}));
    _goldWeightController.addListener(() => setState(() {}));
    _goldPriceController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _cashController.dispose();
    _goldWeightController.dispose();
    _goldPriceController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double inputCash = double.tryParse(_cashController.text) ?? 0.0;
    double inputGoldWeight = double.tryParse(_goldWeightController.text) ?? 0.0;
    double inputGoldPrice = double.tryParse(_goldPriceController.text) ?? 0.0;

    double currentTotal = inputCash + (inputGoldWeight * inputGoldPrice);
    double currentNisab = inputGoldPrice * 85;
    bool isActuallyEligible = currentTotal >= currentNisab && currentNisab > 0;

    return Scaffold(
      backgroundColor: Appcolors.prayerTimesWhite,
      body: SafeArea(
        top: false,
        child: ScalifyBox(
          referenceWidth: 360,
          referenceHeight: 820,
          builder: (context, ls) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                     Image.asset(
                        'assets/prayer/prayerTimeBackground.png',
                        height: ls.h(200),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: ls.h(40),
                        left: ls.w(20),
                        child: Customicon(
                          ontap: () => Navigator.pop(context),
                          icon: Icons.arrow_back_ios,
                          color: Colors.white,
                          size: ls.iz(25),
                        ),
                      ),
                      Positioned(
                        top: ls.h(70),
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Customtext(
                              text: "حاسبة الزكاة",
                              textcolor: Colors.white,
                              textsize: ls.fz(28),
                              textweight: FontWeight.bold,
                            ),
                            ls.sbh(2),
                            Customtext(
                              text: inputGoldPrice > 0
                                  ? "النصاب بناءً على سعرك: ${currentNisab.toStringAsFixed(0)} ج.م"
                                  : "برجاء إدخال سعر الذهب",
                              textcolor: Colors.black,
                              textsize: ls.fz(14),
                              textweight: FontWeight.bold,
                            ),

                          ],
                        ),
                      ),
                      Positioned(
                        bottom: ls.h(-70),
                        left: ls.w(20),
                        right: ls.w(20),
                        child: Container(
                          padding: ls.p(20),
                          decoration: BoxDecoration(
                            color: Appcolors.SibhaviewGold,
                            borderRadius: ls.br(20),
                            boxShadow: const [
                                BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset:  Offset(0, 10),
                              ),


                               BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset:  Offset(10, 0),
                              ),


                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset:  Offset(-10, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Customtext(
                                text: "الزكاة المستحقة",
                                textcolor: Colors.brown[900]!,
                                textsize: ls.fz(16),
                                textweight: FontWeight.bold,
                              ),
                              ls.sbh(5),
                              Customtext(
                                text: "${_zakatResult.toStringAsFixed(2)} ج.م",
                                textcolor: Colors.brown[900]!,
                                textsize: ls.fz(30),
                                textweight: FontWeight.w900,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ls.sbh(80),
                  Padding(
                    padding: ls.p(20),
                    child: Column(
                      children: [

                        ZakatInputCard(
                          ls:ls,
                          title: "سعر جرام الذهب اليوم (عيار 21)",
                          controller: _goldPriceController,
                          icon: Icons.price_change,
                          suffix: "ج.م",
                          isPrimary: true,
                        ),
                        ls.sbh(15),
                        ZakatInputCard(
                          ls:ls,
                          title: "إجمالي الأموال والمدخرات",
                          controller: _cashController,
                          icon: Icons.account_balance_wallet,
                          suffix: "ج.م",
                        ),
                        ls.sbh(15),
                        ZakatInputCard(
                          ls: ls,

                          title: "وزن الذهب المدخر (جرام)",
                          controller: _goldWeightController,
                          icon: Icons.eighteen_mp_outlined,
                          suffix: "جرام",
                        ),
                        ls.sbh(25),
                        SizedBox(
                          width: double.infinity,
                          height: ls.h(55),
                          child: ElevatedButton(
                            onPressed: _calculateZakat,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.prayerTimesTeal,
                              shape: RoundedRectangleBorder(
                                borderRadius: ls.br(15),
                              ),
                            ),
                            child: Customtext(
                              text: "احسب الآن",
                              textcolor: Colors.white,
                              textsize: ls.fz(18),
                              textweight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ls.sbh(30),
                        if (inputGoldPrice > 0 &&
                            (inputCash > 0 || inputGoldWeight > 0))
                          Container(
                            padding: ls.p(15),
                            decoration: BoxDecoration(
                              color: isActuallyEligible
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.orange.withOpacity(0.1),
                              borderRadius: ls.br(12),
                              border: Border.all(
                                color: isActuallyEligible
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isActuallyEligible
                                      ? Icons.check_circle
                                      : Icons.info,
                                  color: isActuallyEligible
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                                ls.sbw(10),
                                Expanded(
                                  child: Customtext(
                                    text: isActuallyEligible
                                        ? "إجمالي مالك (${currentTotal.toStringAsFixed(0)} ج.م) بلغ النصاب ✅"
                                        : "باقي ${(currentNisab - currentTotal).toStringAsFixed(0)} ج.م لتصل للنصاب.",
                                    textcolor: Colors.black87,
                                    textsize: ls.fz(13),
                                    textweight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
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


  void _calculateZakat() {
    double cash = double.tryParse(_cashController.text) ?? 0.0;
    double goldWeight = double.tryParse(_goldWeightController.text) ?? 0.0;
    double goldPrice = double.tryParse(_goldPriceController.text) ?? 0.0;

    double currentNisab = goldPrice * 85;
    double totalWealth = cash + (goldWeight * goldPrice);

    setState(() {
      if (goldPrice <= 0) {
        context.showSnackBar(context,"برجاء إدخال سعر الذهب اليوم أولاً", Colors.red);
        return;
      }

      if (totalWealth >= currentNisab) {
        _zakatResult = totalWealth * 0.025;
        _isEligible = true;
        context.showSnackBar(
          context,
          "تقبل الله منك! الزكاة: ${_zakatResult.toStringAsFixed(2)} ج.م",
          Colors.green,
        );
      } else {
        _zakatResult = 0.0;
        _isEligible = false;
        context.showSnackBar(context, "لم يبلغ مالك النصاب المطلوب",
            Colors.orange[800]!);

      }
    });
  }


}
