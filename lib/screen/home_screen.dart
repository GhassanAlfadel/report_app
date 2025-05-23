import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_app/providers/auth_provider.dart';
import 'package:report_app/widgets/options_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 134, 152),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 134, 152),
        actions: [
          IconButton(
              onPressed: () {
                authProvider.logout(context);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ))
        ],
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            "اقسام البلاغات",
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
                option: "الماء",
                goToPage: () {
                  Navigator.of(context).pushNamed("/report_history",
                      arguments: {"collection": "water", "type": "صيانة مياه"});
                },
              ),
              OptionsItem(
                option: "الكهرباء",
                goToPage: () {
                  Navigator.of(context).pushNamed("/electricOptions",
                      arguments: {"collection": "electric"});
                },
              ),
              OptionsItem(
                option: "الزراعة",
                goToPage: () {
                  Navigator.of(context).pushNamed("/report_history",
                      arguments: {"collection": "arg", "type": "صيانة زراعه"});
                },
              ),
              OptionsItem(
                option: "الاثاث",
                goToPage: () {
                  Navigator.of(context).pushNamed("/report_history",
                      arguments: {"collection": "furn", "type": "صيانة اثاث"});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
