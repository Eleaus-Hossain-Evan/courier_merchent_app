import 'package:courier_merchent_app/application/global.dart';
import 'package:courier_merchent_app/infrastructure/payment_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/payment/pending_payment_response.dart';

part 'payment_provider.g.dart';

@riverpod
FutureOr<PendingPaymentResponse> getPendingPaymentList(
  GetPendingPaymentListRef ref, {
  int page = 1,
  int limit = 10,
}) async {
  final result =
      await PaymentRepo().getPendingPaymentList(page: page, limit: limit);
  return result.fold((l) {
    showErrorToast(l.error.message);
    return PendingPaymentResponse.init();
  }, (r) => r);
}
