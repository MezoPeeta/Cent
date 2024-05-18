import 'package:cent/src/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.medium(
            title: Text('Settings'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: const Text(
                      'Biometric Lock',
                      style: TextStyle(fontSize: 20),
                    ),
                    leading: const Icon(Icons.fingerprint_outlined),
                    trailing: BlocBuilder<BiometricCubit, bool>(
                      builder: (context, state) {
                        return Switch.adaptive(
                          value: state,
                          onChanged: (v) => context
                              .read<BiometricCubit>()
                              .changeValue(value: v),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
