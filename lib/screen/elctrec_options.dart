import 'package:flutter/material.dart';
import 'package:report_app/widgets/options_item.dart';

class ElctrecOptions extends StatelessWidget {
  const ElctrecOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            "صيانة الكهرباء",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Align(
          alignment: Alignment.centerRight,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            children: [
              OptionsItem(
                option: "المكيف",
                goToPage: () {
                  Navigator.of(context).pushNamed("/report_history",
                      arguments: {
                        'collection': "electric",
                        "devision": "مكيف",
                        "type": "مكيف"
                      });
                },
              ),
              OptionsItem(
                option: "المبردات و الثلاجات",
                goToPage: () {
                  Navigator.of(context).pushNamed("/report_history",
                      arguments: {
                        'collection': "electric",
                        "devision": "مبرد",
                        "type": "مبرد او ثلاجه"
                      });
                },
              ),
              OptionsItem(
                option: "اللمبات والمراوح",
                goToPage: () {
                  Navigator.of(context).pushNamed("/report_history",
                      arguments: {
                        'collection': "electric",
                        "devision": "مروحه",
                        "type": "لمبه او مروحه"
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
