import 'package:courier_merchent_app/application/global.dart';
import 'package:courier_merchent_app/infrastructure/payment_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/payment/history_payment_list_response.dart';
import '../../domain/payment/pending_payment_response.dart';
import '../../domain/payment/single_history_payment_response.dart';

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

// @riverpod
// class PendingPaymentList extends _$PendingPaymentList {
//   @override
//   FutureOr<void> build() {
//     return null;
//   }

//   FutureOr<void> getParcel(
//       {int page = 1, int limit = 10}) async {
//     state = const AsyncLoading();
//     final result =
//         await PaymentRepo().getPendingPaymentList(page: page, limit: limit);

//     state = await AsyncValue.guard(() => result.fold((l) {
//           showErrorToast(l.error.message);
//           return PendingPaymentResponse.init();
//         }, (r) => r));
//   }
// }

@riverpod
FutureOr<HistoryPaymentListResponse> getHistoryPaymentList(
  GetHistoryPaymentListRef ref, {
  int page = 1,
  int limit = 10,
}) async {
  final result =
      await PaymentRepo().getHistoryPaymentList(page: page, limit: limit);
  return result.fold((l) {
    showErrorToast(l.error.message);
    return HistoryPaymentListResponse.init();
  }, (r) => r);
}

@riverpod
FutureOr<SingleHistoryPaymentResponse> getSinglePaymentHistory(
  GetSinglePaymentHistoryRef ref, {
  required String historyId,
}) async {
  final result = await PaymentRepo().getSingleHistoryPayment(historyId);
  return result.fold((l) {
    showErrorToast(l.error.message);
    return SingleHistoryPaymentResponse.init();
  }, (r) => r);
}
