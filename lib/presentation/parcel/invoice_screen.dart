import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/widgets.dart';

class InvoiceScreen extends HookConsumerWidget {
  static const route = '/invoice';

  const InvoiceScreen({
    super.key,
    required this.serialId,
  });

  final String serialId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const KAppBar(
        titleText: 'Invoice',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            serialId.text.make(),
          ],
        ),
      ),
    );
  }
}
