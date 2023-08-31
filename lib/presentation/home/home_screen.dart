import 'package:bot_toast/bot_toast.dart';
import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/home/home_provider.dart';
import '../../utils/utils.dart';
import '../parcel/widgets/pdf_export.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/recent_parcel_section.dart';
import 'widgets/search_delivery.dart';
import 'widgets/service_section.dart';

class HomeScreen extends HookConsumerWidget {
  static String route = "/home";
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshController = useMemoized(
        () => RefreshController(initialLoadStatus: LoadStatus.canLoading));
    ref.listen(homeProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });

    useEffect(() {
      // Future.microtask(() => ref.read(authProvider.notifier).profileView());
      return () => BotToast.closeAllLoading();
    }, const []);

    return Scaffold(
      appBar: const HomeAppBar(),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          // enablePullUp: true,
          onRefresh: () => ref
              .refresh(homeProvider.notifier)
              .getRecentParcelList()
              .then((value) =>
                  refreshController.refreshCompleted(resetFooterState: true)),

          // header: const MaterialHeader(),
          child: SingleChildScrollView(
            padding: padding16,
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                const SearchDelivery(),
                gap32,

                //?  Services section ---------------------

                "Our Services".text.lg.bold.make(),
                gap16,
                const ServiceSection(),
                gap32,

                //?  recent parcel section ----------------
                "Recent Parcels".text.lg.bold.make(),
                gap16,
                const RecentParcelSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final parcel = ParcelModel.fromJson("""
{
        "_id": "64ef1e6ab01c421d79c904ef",
        "merchantInfo": {
            "name": "Hadiuzzaman",
            "phone": "01671849382",
            "address": "Uttara sector 10 , Dhaka",
            "shopName": "Le fabre",
            "district": {
                "_id": "642e4713912a102364a618e1",
                "name": "Dhaka"
            },
            "area": {
                "_id": "64ef1dd3b01c421d79c904be",
                "name": "Uttara"
            }
        },
        "regularParcelInfo": {
            "invoiceId": "INV0125478",
            "weight": "1 kg",
            "productPrice": 1500,
            "materialType": "liquid",
            "category": "books",
            "details": "des",
            "instruction": "ins"
        },
        "regularPayment": {
            "cashCollection": 2000,
            "deliveryCharge": 100,
            "codCharge": 20,
            "weightCharge": 30,
            "totalCharge": 150
        },
        "regularStatus": "dropoff",
        "merchantUpdate": 1,
        "customerInfo": {
            "name": "samsul",
            "phone": "01671849382",
            "address": "cittagoan",
            "district": {
                "_id": "642e4713912a102364a6190b",
                "name": "Chattogram"
            },
            "area": {
                "_id": "64ef1de5b01c421d79c904c4",
                "name": "Sitakunda"
            }
        },
        "regularStatusLogs": [
            {
                "time": "2023-08-30T10:48:09.786Z",
                "_id": "64ef1e6ab01c421d79c904f0",
                "log": "পার্সেলটি পিকআপের জন্য মার্চেন্ট অনুরোধ করেছেন"
            },
            {
                "time": "2023-08-30T10:52:33.875Z",
                "_id": "64ef1f71b01c421d79c9054b",
                "log": "পার্সেলটি পিকআপ হয়েছে।"
            },
            {
                "time": "2023-08-30T10:53:33.405Z",
                "_id": "64ef1fadb01c421d79c90574",
                "log": "পার্সেলটি Test 1 Hub হাব থেকে Parent hub হাবের উদ্দেশ্য পাঠানো হয়েছে।"
            },
            {
                "time": "2023-08-30T10:58:07.542Z",
                "_id": "64ef20bfb01c421d79c905be",
                "log": "পার্সেলটির হাব পরিবর্তন সম্পন্ন হয়েছে"
            },
            {
                "time": "2023-08-30T10:59:23.112Z",
                "_id": "64ef210bb01c421d79c905e7",
                "log": "পার্সেলটি Parent hub হাব থেকে test 2 hub হাবের উদ্দেশ্য পাঠানো হয়েছে।"
            },
            {
                "time": "2023-08-30T11:00:07.727Z",
                "_id": "64ef2137b01c421d79c905fa",
                "log": "পার্সেলটির হাব পরিবর্তন সম্পন্ন হয়েছে"
            },
            {
                "time": "2023-08-30T11:00:19.487Z",
                "_id": "64ef2143b01c421d79c90615",
                "log": "পার্সেলটি পিকআপের জন্য r2(01753001190) উপর এসাইন করেছে।"
            },
            {
                "time": "2023-08-30T11:04:36.234Z",
                "_id": "64ef2244b01c421d79c90663",
                "log": "পার্সেলটি ডেলিভারী হয়েছে।"
            },
            {
                "time": "2023-08-30T11:40:01.331Z",
                "_id": "64ef2a91b01c421d79c906f6",
                "log": "এডমিন পার্সেলটি আপডেট করেছেন| পূর্বের (collection: 2000, delivery charge:150), এখন (collection: 2000, delivery charge:150)"
            }
        ],
        "serialId": "30082023-Q4IT1K-Test123-test2-123",
        "qrCode": "public/parcel/30082023-Q4IT1K-Test123-test2-123.png",
        "createdAt": "2023-08-30T10:48:10.182Z"
    }
""");
