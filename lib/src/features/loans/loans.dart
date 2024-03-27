import 'package:flutter/material.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 135,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.add_outlined),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: 310,
                  height: 150,
                  child: Card(
                    shape: const StadiumBorder(),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.fastfood_sharp),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Loan Name"),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            borderRadius: BorderRadius.circular(20),
                            minHeight: 10,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
