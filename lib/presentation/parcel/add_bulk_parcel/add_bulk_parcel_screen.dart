import "dart:io" as io;

import 'package:bot_toast/bot_toast.dart';
import 'package:courier_merchent_app/domain/auth/model/area_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:excel/excel.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/application/home/home_provider.dart';
import 'package:courier_merchent_app/utils/utils.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../application/global.dart';
import '../../../application/parcel/parcel_provider.dart';
import '../../../application/shop/shop_provider.dart';
import '../../../domain/auth/model/shop_model.dart';
import '../../../domain/parcel/model/merchant_info_model.dart';
import '../../widgets/widgets.dart';
import '../add_single_parcel/sections/merchant_info_section.dart';
import '../widgets/create_parcel_end_drawer.dart';

class AddBulkParcelScreen extends HookConsumerWidget {
  static const route = '/add-bulk-parcel';

  const AddBulkParcelScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState<bool>(false);
    final result = useState<FilePickerResult?>(null);

    final scaffoldKey = useMemoized<GlobalKey<ScaffoldState>>(GlobalKey.new);

    final selectedShop = useState<MyShopModel?>(null);

    Future<void> setShop() async {
      final shops = await ref.read(getMyShopsProvider.future);
      selectedShop.value = shops.firstOrNull;
    }

    useEffect(() {
      Future.microtask(() => setShop());
      return () => BotToast.closeAllLoading();
    }, const []);
    return Scaffold(
      key: scaffoldKey,
      appBar: const KAppBar(
        titleText: 'Create Multiple Parcel',
        actions: [SizedBox.shrink()],
      ),
      endDrawer: CreateParcelEndDrawer(
        scaffoldKey: scaffoldKey,
        selectedShop: selectedShop.value,
        myShops: ref.watch(getMyShopsProvider).valueOrNull ?? IList(),
        onTap: (shop) => selectedShop.value = shop,
      ),
      body: SingleChildScrollView(
        padding: padding16,
        child: Column(
          children: [
            MerchantInfoSection(
              scaffoldKey: scaffoldKey,
              myShops: ref.watch(getMyShopsProvider),
              selectedShop: selectedShop,
            ),
            gap16,
            Visibility(
              visible: result.value != null && result.value!.files.isNotEmpty,
              replacement: Column(
                children: [
                  Visibility(
                    visible: ref.read(homeProvider).hasValue,
                    child: ContainerBGWhiteSlideFromRight(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      child: Row(
                        children: [
                          Logo(
                            Logos.microsoft_excel,
                            size: 16.sp,
                          ),
                          gap8,
                          "Download Sample Format..."
                              .text
                              .blue600
                              .lg
                              .make()
                              .expand(),
                          SizedBox(
                            width: 62.w,
                            child: KTextButton(
                              onPressed: () async {
                                final Uri url = Uri.parse(APIRoute.BASE_URL +
                                    ref
                                        .read(homeProvider)
                                        .value!
                                        .data
                                        .bulkExcel);

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                }

                                // final inLunch = await canLaunchUrl(url);
                                // Logger.i('inLunch: $inLunch');
                              },
                              child: const Icon(
                                Bootstrap.cloud_download_fill,
                              ).iconColor(ColorPalate.primary300),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  gap16,
                  ContainerBGWhiteSlideFromTop(
                    padding: padding0,
                    child: AspectRatio(
                      aspectRatio: 2.5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorPalate.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(16.r),
                          dashPattern: const [6, 4],
                          color: ColorPalate.black600,
                          child: KInkWell(
                            onTap: () async {
                              result.value =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: ['xls', 'xlsx'],
                              );
                            },
                            child: Center(
                              child: Column(
                                crossAxisAlignment: crossCenter,
                                mainAxisAlignment: mainCenter,
                                children: [
                                  const Icon(
                                    BoxIcons.bx_upload,
                                    size: 32,
                                  ).iconColor(ColorPalate.black600),
                                  gap8,
                                  "Select the EXCEL file for Upload"
                                      .text
                                      .color(ColorPalate.black600)
                                      .xl
                                      .bold
                                      .make(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ContainerBGWhiteSlideFromLeft(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    child: Row(
                      children: [
                        Logo(
                          Logos.microsoft_excel,
                          size: 16.sp,
                        ),
                        gap8,
                        (result.value?.files.single.name ?? "")
                            .text
                            .blue600
                            .lg
                            .make()
                            .expand(),
                        CloseButton(
                          onPressed: () {
                            result.value = null;
                          },
                        )
                      ],
                    ),
                  ),
                  gap16,
                  KFilledButton(
                    loading: loading.value,
                    onPressed: () {
                      loading.value = true;
                      final bytes = io.File(result.value!.files.single.path!)
                          .readAsBytesSync();

                      final baseStr = Uri.dataFromBytes(bytes)
                          .toString()
                          .split("base64,")[1];
                      Logger.i('baseStr: $baseStr');
                      ref
                          .read(createBulkParcelProvider(
                        merchant: MerchantInfoModel(
                          name: ref.watch(authProvider).user.name,
                          phone: ref.watch(authProvider).user.phone,
                          address: selectedShop.value?.address ?? "",
                          shopName: selectedShop.value?.shopName ?? "",
                          districtId: selectedShop.value?.district.id ?? '',
                          areaId: selectedShop.value?.area.id ?? '',
                          area: AreaModel.init(),
                          district: AreaModel.init(),
                        ),
                        data: baseStr,
                      ).future)
                          .then((value) {
                        if (value.data.isNotEmpty) {
                          loading.value = false;
                          ref.invalidate(recentParcelProvider);
                          showToast("Bulk Parcel uploaded successfully...");
                          context.pop();
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: mainCenter,
                      children: [
                        const Icon(
                          Bootstrap.cloud_upload_fill,
                          size: 16,
                        ).iconColor(ColorPalate.white),
                        gap8,
                        "Upload Bulk Parcel".text.white.make(),
                      ],
                    ),
                  ),
                  // gap16,
                  // ExcelWidget(result: result.value),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExcelWidget extends HookConsumerWidget {
  const ExcelWidget({
    super.key,
    required this.result,
  });
  final FilePickerResult? result;

  @override
  Widget build(BuildContext context, ref) {
    final bytes = io.File(result!.files.single.path!).readAsBytesSync();

    var excel = Excel.decodeBytes(bytes);

    print(excel["Sheet1"].rows.length);
    for (var row in excel["Sheet1"].rows) {
      print(row);
      // tbleRows.add(row);
    }

    final baseStr = Uri.dataFromBytes(bytes,
        mimeType: "application/${result?.files.single.extension}");

    return Text("$baseStr");
    // return Excel.
  }
}
