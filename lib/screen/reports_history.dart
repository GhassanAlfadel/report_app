import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_app/providers/report_provider.dart';
import 'package:report_app/widgets/report_item.dart';

class ReportsHistory extends StatefulWidget {
  const ReportsHistory({super.key});

  @override
  State<ReportsHistory> createState() => _ReportsHistoryState();
}

class _ReportsHistoryState extends State<ReportsHistory> {
  @override
  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 134, 152),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 134, 152),
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            "سجل التقارير",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: args["collection"].toString() == "electric"
            ? reportProvider.fetchElectricReports(
                args["collection"].toString(), args["devision"].toString())
            : reportProvider.fetchReports(args["collection"].toString()),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return ReportItem(reportModel: snapShot.data![index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: snapShot.data!.length);
        },
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/add_report", arguments: args);
          },
          icon: const Icon(Icons.add)),
    );
  }
}
