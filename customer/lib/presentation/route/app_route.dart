import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/application/address/address_bloc.dart';
import 'package:quick/application/ads/ads_bloc.dart';
import 'package:quick/application/auth/auth_bloc.dart';
import 'package:quick/application/banner/banner_bloc.dart';
import 'package:quick/application/blog/blog_bloc.dart';
import 'package:quick/application/brand/brand_bloc.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/chat/chat_bloc.dart';
import 'package:quick/application/products/attribute/attribute_bloc.dart';
import 'package:quick/application/products/compare/compare_bloc.dart';
import 'package:quick/application/profile/currency/currency_bloc.dart';
import 'package:quick/application/filter/filter_bloc.dart';
import 'package:quick/application/gemini/gemini_bloc.dart';
import 'package:quick/application/main/main_bloc.dart';
import 'package:quick/application/maksekeskus/maksekeskus_bloc.dart';
import 'package:quick/application/map/map_bloc.dart';
import 'package:quick/application/notification/notification_bloc.dart';
import 'package:quick/application/products/create/create_product_bloc.dart';
import 'package:quick/application/products/detail/product_detail_bloc.dart';
import 'package:quick/application/products/edit/edit_product_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/application/products/user_products/user_product_bloc.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/application/profile/transactions/transactions_bloc.dart';
import 'package:quick/application/profile/wallet/wallet_bloc.dart';
import 'package:quick/application/review/review_bloc.dart';
import 'package:quick/application/search/search_bloc.dart';
import 'package:quick/application/select/select_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/bottom_sheets/banner_bottom_sheet.dart';
import 'package:quick/presentation/components/bottom_sheets/blog_bottom_sheet.dart';
import 'package:quick/presentation/components/select_ui_type.dart';
import 'package:quick/presentation/pages/auth/forget_password.dart';
import 'package:quick/presentation/pages/blog/blog_screen.dart';
import 'package:quick/presentation/pages/category/category_page.dart';
import 'package:quick/presentation/pages/chat/chat_ai_page.dart';
import 'package:quick/presentation/pages/profile/wallet_history/failure_page.dart';
import 'package:quick/presentation/pages/profile/wallet_history/maksekeskus_screen.dart';
import 'package:quick/presentation/pages/country/city_page.dart';
import 'package:quick/presentation/pages/country/country_page.dart';
import 'package:quick/presentation/pages/notification/widgets/notification_bottom_sheet.dart';
import 'package:quick/presentation/pages/auth/auth_page.dart';
import 'package:quick/presentation/pages/blog/blog_list_page.dart';
import 'package:quick/presentation/pages/category/search_page.dart';
import 'package:quick/presentation/pages/chat/chat_list_page.dart';
import 'package:quick/presentation/pages/chat/chat_page.dart';
import 'package:quick/presentation/pages/profile/wallet_history/congrats_page.dart';
import 'package:quick/presentation/pages/filter/filter_page.dart';
import 'package:quick/presentation/pages/main/main_page.dart';
import 'package:quick/presentation/pages/map/map_page.dart';
import 'package:quick/presentation/pages/notification/notification_page.dart';
import 'package:quick/presentation/components/web_view.dart';
import 'package:quick/presentation/pages/products/compare/compare_list_page.dart';
import 'package:quick/presentation/pages/products/compare/compare_product_page.dart';
import 'package:quick/presentation/pages/products/edit/edit_product_page.dart';
import 'package:quick/presentation/pages/products/ads/select_ads_page.dart';
import 'package:quick/presentation/pages/products/ads/widgets/payment_modal.dart';
import 'package:quick/presentation/pages/products/full/products_full_page.dart';
import 'package:quick/presentation/pages/products/list/products_list_page.dart';
import 'package:quick/presentation/pages/profile/change_password.dart';
import 'package:quick/presentation/pages/profile/edit_account.dart';
import 'package:quick/presentation/pages/profile/help_policy_term/help_page.dart';
import 'package:quick/presentation/pages/profile/help_policy_term/policy_page.dart';
import 'package:quick/presentation/pages/profile/help_policy_term/term_page.dart';
import 'package:quick/presentation/pages/profile/my_account.dart';
import 'package:quick/presentation/pages/profile/referral_page.dart';
import 'package:quick/presentation/pages/profile/settings/settings_page.dart';
import 'package:quick/presentation/pages/profile/transactions/transaction_list.dart';
import 'package:quick/presentation/pages/profile/wallet_history/wallet_history_page.dart';
import 'package:quick/presentation/pages/review/review_page.dart';
import 'package:quick/presentation/pages/review/widgets/review_images.dart';
import 'package:quick/presentation/pages/story/story_page.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../application/story/story_bloc.dart';
import '../pages/auth/confirm_screen.dart';
import '../pages/auth/login_screen.dart';
import '../pages/auth/sign_up_field_screen.dart';
import '../pages/auth/sign_up_screen.dart';
import '../pages/auth/update_password.dart';
import '../pages/products/create/create_product_page.dart';
import '../pages/products/preview/preview_page.dart';
import '../pages/products/product_detail/product_page.dart';
import '../pages/products/product_detail/widgets/only_image.dart';
import '../pages/products/user_products/user_products_page.dart';
import '../pages/profile/settings/widgets/currency.dart';
import '../pages/profile/settings/widgets/language.dart';

part 'auth_route.dart';

part 'setting_route.dart';

part 'product_route.dart';

abstract class AppRoute {
  AppRoute._();

  static goMain(BuildContext context) =>
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => MainBloc()),
                BlocProvider(create: (context) => ChatBloc()),
                BlocProvider(create: (context) => ProfileBloc()),
                BlocProvider<CategoryBloc>(
                  create: (context) => CategoryBloc()
                    ..add(CategoryEvent.fetchCategory(
                        context: context, isRefresh: true)),
                ),
                BlocProvider<StoryBloc>(
                  create: (context) => StoryBloc()
                    ..add(StoryEvent.fetchStory(
                        context: context, isRefresh: true)),
                ),
                BlocProvider<ProductBloc>(
                  create: (context) => ProductBloc()
                    ..add(ProductEvent.fetchAdsProduct(
                        context: context, isRefresh: true))
                    ..add(ProductEvent.fetchAllProduct(
                        context: context, isRefresh: true)),
                ),
                BlocProvider<BlogBloc>(
                  create: (context) => BlogBloc()
                    ..add(
                        BlogEvent.fetchBlog(context: context, isRefresh: true)),
                ),
                BlocProvider<BannerBloc>(
                    create: (context) => BannerBloc()
                      ..add(BannerEvent.fetchBanner(
                          context: context, isRefresh: true))),
                if (LocalStorage.getToken().isNotEmpty)
                  BlocProvider<NotificationBloc>(
                      create: (context) => NotificationBloc()
                        ..add(NotificationEvent.fetchCount(context: context))),
                BlocProvider<BrandBloc>(
                    create: (context) => BrandBloc()
                      ..add(BrandEvent.fetchBrands(context: context))),
              ],
              child: const MainPage(),
            );
          },
        ),
        (route) => false,
      );

  static goSelectAdsPage(
      {required BuildContext context, ProductData? product}) async {
    if (AppHelpers.getAds()) {
      return await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<ProductBloc>()),
              BlocProvider.value(value: context.read<MainBloc>()),
              if (product?.productAds == null)
                BlocProvider(
                  create: (context) => AdsBloc()
                    ..add(AdsEvent.fetchAds(
                      context: context,
                      isRefresh: true,
                      categoryId: product?.categoryId,
                    ))
                    ..add(AdsEvent.fetchUserAds(
                      context: context,
                      isRefresh: true,
                      categoryId: product?.categoryId,
                    )),
                ),
            ],
            child: SelectAdsPage(product: product),
          ),
        ),
      );
    } else {
      Navigator.pop(context, false);
    }
  }

  static goAdsPaymentModal({
    required BuildContext context,
    required CustomColorSet colors,
    required int? selectAdsId,
  }) {
    AppHelpers.showCustomModalBottomSheetDrag(
      context: context,
      paddingTop: 20,
      initialChildSize: 0.6,
      modal: (c) => BlocProvider.value(
        value: context.read<AdsBloc>()
          ..add(AdsEvent.fetchPayments(context: context))
          ..add(AdsEvent.selectAds(id: selectAdsId ?? 0)),
        child: PaymentModal(colors: colors, controller: c),
      ),
    );
  }

  static goAllCategoryPage(BuildContext context, {CategoryData? category}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<CategoryBloc>()
                ..add(CategoryEvent.selectCategory(
                  context: context,
                  category: category,
                  onlySelect: true,
                )),
            ),
            BlocProvider.value(value: context.read<MainBloc>()),
            BlocProvider.value(value: context.read<ProductBloc>()),
          ],
          child: const CategoryPage(),
        ),
      ),
    );
  }

  static goBlogBottomSheet(BuildContext context, BlogData blog) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider.value(
        value: context.read<BlogBloc>()
          ..add(BlogEvent.fetchBlogById(
              context: context, id: blog.id ?? 0, blog: blog)),
        child: const BlogBottomSheet(),
      ),
    );
  }

  static goBlogPage(BuildContext context, BlogData blog) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<BlogBloc>()
            ..add(BlogEvent.fetchBlogById(
                context: context, id: blog.id ?? 0, blog: blog)),
          child: const BlogScreen(),
        ),
      ),
    );
  }

  static Future goMap(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
          BlocProvider(create: (context) => MapBloc()),
        ], child: const MapPage()),
      ),
    );
  }

  static goBannerBottomSheet(
      BuildContext context, BannerData banner, CustomColorSet colors) {
    AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<BannerBloc>()),
          BlocProvider.value(value: context.read<MainBloc>()),
        ],
        child: BannerBottomSheet(
          banner: banner,
          colors: colors,
        ),
      ),
    );
  }

  static goFilterPage(BuildContext context, {int? categoryId}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            if (categoryId != null)
              BlocProvider.value(
                value: context.read<FilterBloc>()
                  ..add(
                    FilterEvent.setCategory(
                        category: CategoryData(id: categoryId)),
                  ),
              ),
            BlocProvider.value(value: context.read<FilterBloc>()),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider(
              create: (context) => CategoryBloc()
                ..add(
                  CategoryEvent.fetchCategory(
                      context: context, isRefresh: true),
                ),
            ),
          ],
          child: FilterPage(categoryId: categoryId),
        ),
      ),
    );
  }

  static goSearchPage({
    required BuildContext context,
    int? userId,
    int? categoryId,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
            BlocProvider(create: (context) => SearchBloc()),
          ],
          child: SearchPage(userId: userId, categoryId: categoryId),
        ),
      ),
    );
  }

  static goReviewPage({
    required BuildContext context,
    required CustomColorSet colors,
    int? userId,
    int? productId,
    int? blogId,
    int? driverId,
    int? orderId,
    String? productSlug,
  }) {
    return AppHelpers.showCustomModalBottomSheetDrag(
      paddingTop: 0,
      context: context,
      modal: (c) => BlocProvider(
        create: (context) => ReviewBloc()
          ..add(ReviewEvent.fetchReviewList(
              context: context,
              userId: userId,
              productSlug: productSlug,
              blogId: blogId,
              driverId: driverId,
              isRefresh: true))
          ..add(ReviewEvent.fetchReview(
              context: context,
              userId: userId,
              driverId: driverId,
              productId: productId,
              blogId: blogId)),
        child: ReviewPage(
          colors: colors,
          blogId: blogId,
          controller: c,
          userId: userId,
          orderId: orderId,
          productId: productId,
          productSlug: productSlug,
        ),
      ),
    );
  }

  static goNotification({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
                value: context.read<NotificationBloc>()
                  ..add(NotificationEvent.fetchNotification(
                      context: context, isRefresh: true))
                  ..add(NotificationEvent.fetchCount(context: context))),
            BlocProvider.value(value: context.read<BlogBloc>()),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child: const NotificationPage(),
        ),
      ),
    );
  }

  static goBlog({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<BlogBloc>(),
          child: const BlogListPage(),
        ),
      ),
    );
  }

  static goChatsList({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
                value: context.read<ChatBloc>()
                  ..add(ChatEvent.getChatList(
                      context: context, isRefresh: true))),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child: const ChatListPage(),
        ),
      ),
    );
  }

  static goChat(
      {required BuildContext context,
      required UserModel? sender,
      String? chatId,
      ProductData? product}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ChatBloc()
                ..add(ChatEvent.checkChatId(
                    context: context, sellerId: sender?.id)),
            ),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child: ChatPage(
            sender: sender,
            chatId: chatId,
            product: product,
          ),
        ),
      ),
    );
  }

  static goChatAI({
    required BuildContext context,
    ProductData? product,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ChatBloc()
                ..add(ChatEvent.checkChatId(
                    context: context, sellerId: product?.id)),
            ),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child: ChatAiPage(
            product: product,
          ),
        ),
      ),
    );
  }

  static goNotificationBottomSheet(BuildContext context,
      NotificationModel notification, CustomColorSet colors) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: NotificationBottomSheetSheet(
        notification: notification,
        colors: colors,
      ),
    );
  }

  static Future goWebView({required BuildContext context, String? url}) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WebViewPage(url: url),
      ),
    );
  }

  static Future goStoryPagePage(
      {required BuildContext context,
      required RefreshController controller,
      required int index}) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<StoryBloc>()),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child: StoryPage(controller: controller, index: index),
        ),
      ),
    );
  }

  static goReviewImages(
      {required BuildContext context,
      required int index,
      required List<Galleries> list}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReviewImages(
          selectIndex: index,
          list: list,
        ),
      ),
    );
  }

  static goMaksekeskusBottomSheet(
      {required BuildContext context,
      bool? parcel,
      bool? wallet,
      int? parcelId,
      num? price,
      required CustomColorSet colors,
      required ValueChanged<String> onSuccess}) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider<MaksekeskusBloc>(
        create: (context) => MaksekeskusBloc()
          ..add(MaksekeskusEvent.fetchMaksekeskus(
            price: price,
            wallet: wallet,
            parcel: parcel,
            context: context,
            parcelId: parcelId,
          )),
        child: MaksekeskusScreen(colors: colors, onSuccess: onSuccess),
      ),
    );
  }

  static goFailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FailurePage()),
    );
  }

  static goSuccessPage(BuildContext context, {VoidCallback? onTap}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CongratsPage(onTap: onTap)),
    );
  }
}
