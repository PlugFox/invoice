import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/src/common/widget/input_text_field.dart';
import 'package:invoice/src/feature/invoice/controller/invoice_form_controller.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';
import 'package:money2/money2.dart';

class InvoiceFormServices extends StatelessWidget {
  const InvoiceFormServices({
    required this.paddingH,
    required this.form,
    super.key, // ignore: unused_element
  });

  final double paddingH;
  final InvoiceFormController form;

  void addService(BuildContext context) {
    final name = TextEditingController(), amount = TextEditingController();
    final listenable = Listenable.merge([name, amount]);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add service'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),
            InputTextField(
              controller: name,
              label: 'Service name',
              hint: 'Enter service name',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            InputTextField(
              controller: amount,
              label: 'Amount',
              hint: 'Enter amount',
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text('Cancel'),
          ),
          const SizedBox.square(dimension: 16),
          ListenableBuilder(
            listenable: listenable,
            builder: (context, child) {
              final nameValue = name.text.trim();
              final amountValue = double.tryParse(amount.text);
              final isValid = nameValue.isNotEmpty && amountValue != null && amountValue > 0;
              return ElevatedButton.icon(
                onPressed: isValid
                    ? () {
                        form.changeServices((services) => [
                              ...services,
                              ProvidedService(
                                number: services.length + 1,
                                name: nameValue,
                                amount: Fixed.fromNum(amountValue, scale: form.currency.value.scale),
                              ),
                            ]);
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    : null,
                label: const Text('Add'),
                icon: const Icon(Icons.add),
              );
            },
          ),
        ],
      ),
    ).whenComplete(() {
      name.dispose();
      amount.dispose();
    });
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () => addService(context),
                      label: const Text('Add service'),
                      icon: const Icon(Icons.add),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 8),
            sliver: ValueListenableBuilder<List<ProvidedService>>(
              valueListenable: form.services,
              builder: (context, services, child) => SliverFixedExtentList(
                itemExtent: 64,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final service = services[index];
                    return SizedBox(
                      key: ObjectKey(service),
                      height: 56,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          if (index == 0) const SizedBox(height: 1) else const Divider(height: 1),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '#${index + 1}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(service.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyLarge),
                                      Text(
                                        service.amount.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SizedBox.square(
                                  dimension: 48,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    tooltip: 'Delete service ${service.name}',
                                    onPressed: () => form.changeServices(
                                        (services) => services.where((s) => s.number != service.number)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: services.length,
                ),
              ),
            ),
          ),
        ],
      );
}
