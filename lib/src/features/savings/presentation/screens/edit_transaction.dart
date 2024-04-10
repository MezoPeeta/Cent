import 'package:cent/src/core/common/enums/transaction.dart';
import 'package:cent/src/core/common/widgets/delete_dialog.dart';
import 'package:cent/src/core/model/transaction.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:cent/src/features/savings/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:cent/src/features/savings/presentation/cubit/icon_cubit.dart';
import 'package:cent/src/features/savings/presentation/cubit/transaction_cubit.dart';
import 'package:cent/src/features/savings/presentation/goal_theme.dart';
import 'package:cent/src/features/savings/presentation/widgets/icon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({required this.transaction, super.key});

  final Transaction transaction;

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late final nameController =
      TextEditingController(text: widget.transaction.name);
  late final amountController =
      TextEditingController(text: widget.transaction.amount.toString());

  @override
  void initState() {
    super.initState();
    context.read<IconCubit>().getDefault(widget.transaction.id!);
    context.read<TransactionCubit>().getDefault(widget.transaction.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('Edit Transaction'),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog<Widget>(
                    context: context,
                    builder: (context) => DeleteDialog(
                      title: 'Delete Transaction ?',
                      content: 'Delete ${widget.transaction.name}',
                      deleteOnPressed: () {
                        context.read<TransactionBloc>().add(
                              DeleteTransactionEvent(widget.transaction.id!),
                            );
                        context.go('/home');
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline_outlined),
              ),
            ],
          ),

          // ignore: prefer_const_constructors
          SliverToBoxAdapter(
            // ignore: prefer_const_constructors
            child: Column(
              children: [
                BlocBuilder<TransactionCubit, TransactionType>(
                  builder: (context, state) {
                    return SegmentedButton<TransactionType>(
                      segments: const <ButtonSegment<TransactionType>>[
                        ButtonSegment<TransactionType>(
                          label: Text('Expense'),
                          value: TransactionType.expense,
                          icon: Icon(Icons.arrow_drop_down),
                        ),
                        ButtonSegment<TransactionType>(
                          value: TransactionType.income,
                          icon: Icon(Icons.arrow_drop_up),
                          label: Text('Income'),
                        ),
                      ],
                      selected: {state},
                      onSelectionChanged: (selectedTypes) => context
                          .read<TransactionCubit>()
                          .changeType(selectedTypes.first),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: prefer_const_constructors
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<Widget>(
                          context: context,
                          showDragHandle: true,
                          builder: (context) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Choose an icon',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Wrap(
                                      children: GoalTheme()
                                          .icons
                                          .map(
                                            (icon) =>
                                                BlocBuilder<IconCubit, int>(
                                              builder: (context, state) {
                                                final isIconClicked =
                                                    state == icon.codePoint;
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  child: SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<IconCubit>()
                                                            .changeIcon(
                                                              icon.codePoint,
                                                            );
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        16,
                                                      ),
                                                      radius: 5,
                                                      child: Card(
                                                        color: isIconClicked
                                                            ? Theme.of(
                                                                context,
                                                              )
                                                                .colorScheme
                                                                .primary
                                                            : null,
                                                        child: Icon(
                                                          icon,
                                                          color: isIconClicked
                                                              ? Theme.of(
                                                                  context,
                                                                )
                                                                  .colorScheme
                                                                  .onPrimary
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: IconCard(
                        icon: IconData(
                          context.watch<IconCubit>().state,
                          fontFamily: 'MaterialIcons',
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${widget.transaction.amount}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            widget.transaction.name,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(label: Text('Name')),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(label: Text('Amount')),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final currentAmount =
                              double.parse(amountController.text);
                          final transactionType =
                              context.read<TransactionCubit>().state.name;
                          final transactionIcon =
                              context.read<IconCubit>().state;
                          final editTransaction = Transaction(
                            amount: currentAmount,
                            name: nameController.text,
                            type: transactionType,
                            id: widget.transaction.id,
                            icon: transactionIcon,
                          );
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<TransactionBloc>()
                                .add(EditTransaction(editTransaction));
                            if (widget.transaction.type != transactionType) {
                              context.read<SavingsBloc>().add(
                                    EditUserSavings(
                                      currentAmount,
                                      isExpense: transactionType == 'expense',
                                    ),
                                  );
                            }

                            context.pop();
                          }
                        },
                        icon: const Icon(Icons.save_alt),
                        label: const Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
