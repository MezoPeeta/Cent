import 'package:cent/src/core/common/widgets/button.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBalance extends StatelessWidget {
  EditBalance({
    super.key,
    required this.initialValue,
  });

  final String initialValue;
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _salaryController.text = initialValue;
    return SizedBox(
      height: 500,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              width: 250,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _salaryController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.attach_money_outlined),
                  suffixIcon: IconButton(
                      onPressed: () => _salaryController.clear(),
                      icon: const Icon(Icons.cancel_outlined)),
                  label: const Text("My savings"),
                ),
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            CustomElevatedButton(
              onPressed: () {
                BlocProvider.of<SavingsBloc>(context)
                    .add(EditSavings(double.parse(_salaryController.text)));
              },
              text: "Confirm",
              icon: Icons.edit_outlined,
            )
          ],
        ),
      )),
    );
  }
}
