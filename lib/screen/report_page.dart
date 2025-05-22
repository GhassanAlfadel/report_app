// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_app/providers/auth_provider.dart';
import 'package:report_app/providers/report_provider.dart';
import 'package:report_app/widgets/report_model.dart';

class ReportPage extends StatefulWidget {
  final String option;

  const ReportPage({
    super.key,
    required this.option,
  });

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // @override
  // void initState() {
  //   final reportProvider = Provider.of<ReportProvider>(context, listen: false);
  //   reportProvider.fetchReports("water");
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final TextEditingController nameContrioler = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            "اضافة تقرير",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "اسم الكلية",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: nameContrioler,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الموقع",
                  style: TextStyle(fontSize: 30),
                )),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: locationController,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            args["collection"] == "furn"
                ? Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "نوع الاثات",
                            style: TextStyle(fontSize: 30),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          controller: typeController,
                          textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  )
                : const SizedBox(
                    height: 0,
                  ),
            TextButton(
              onPressed: () {
                reportProvider.addReport(
                    ReportModel(
                        name: nameContrioler.text.trim(),
                        location: locationController.text.trim(),
                        status: "تحت المراجعه",
                        userId: authProvider.userId,
                        devison: args["collection"].toString() == "electric"
                            ? args["devision"].toString()
                            : args["collection"].toString() == "furn"
                                ? typeController.text.trim()
                                : "",
                        time: DateTime.now().toString(),
                        type: args["type"].toString()),
                    args["collection"].toString());
                FocusScope.of(context).unfocus();
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      content: const Text('تم ارسال التقرير بنجاح'),
                      actions: [
                        TextButton(
                          child: const Text("اغلاق"),
                          onPressed: () {
                            Navigator.of(context).pop(); //
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: const Text(
                  "ارسال التقرير",
                  style: TextStyle(fontSize: 23, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
