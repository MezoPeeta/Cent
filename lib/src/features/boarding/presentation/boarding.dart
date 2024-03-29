import 'package:cent/src/core/utils/cache_helper.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model/boarding.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late PageController _pageViewController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: PageView(
              controller: _pageViewController,
              onPageChanged: (value) => setState(() {
                _currentIndex = value;
              }),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/img/welcome.svg',
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      "Thank you for choosing Cent",
                      style: TextStyle(fontSize: 23),
                    ),
                    const Text(
                      "Welcome aboard! Start managing your finances smarter and more efficiently",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/img/data.svg',
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      "What's your name?",
                      style: TextStyle(fontSize: 23),
                    ),
                    SizedBox(
                        width: 200,
                        child: TextFormField(
                          initialValue: context.read<SavingsBloc>().state.name,
                          onChanged: (value) => context
                              .read<SavingsBloc>()
                              .add(ChangeUserName(value)),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "All your data is stored on your device, we don't collect any data",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/img/savings.svg',
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      "Add into balance",
                      style: TextStyle(fontSize: 23),
                    ),
                    SizedBox(
                        width: 80,
                        child: TextFormField(
                          initialValue: context
                              .read<SavingsBloc>()
                              .state
                              .balance
                              .toString(),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => context.read<SavingsBloc>().add(
                              AddUserBalance(
                                  double.parse(value == "" ? "0" : value))),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "All your data is stored on your device, we don't collect any data",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentIndex > 0
                    ? IconButton(
                        onPressed: () {
                          _pageViewController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_outlined),
                      )
                    : Container(),
                IconButton(
                  onPressed: () {
                    if (_currentIndex == 2) {
                      context.go('/home');
                      CacheHelper.setBool("boardingDone", true);
                      return;
                    }
                    _pageViewController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_outlined),
                ),
              ],
            ),
          )),
        ],
      ),
    ));
  }
}
