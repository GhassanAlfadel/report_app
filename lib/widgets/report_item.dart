import 'package:flutter/material.dart';
import 'package:report_app/widgets/report_model.dart';

class ReportItem extends StatelessWidget {
  final ReportModel reportModel;

  const ReportItem({super.key, required this.reportModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 138, 157, 167),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            reportModel.status,
            style: const TextStyle(fontSize: 22, color: Colors.black),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                reportModel.name,
                style: const TextStyle(fontSize: 26, color: Colors.black),
              ),
              Text(
                reportModel.location,
                style: const TextStyle(fontSize: 26, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
