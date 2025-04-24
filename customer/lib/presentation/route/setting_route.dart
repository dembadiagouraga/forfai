part of 'app_route.dart';

abstract class SettingRoute {
  SettingRoute._();

  static goSettingPage({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<ProductBloc>()),
                  BlocProvider.value(value: context.read<CategoryBloc>()),
                  BlocProvider.value(value: context.read<BannerBloc>()),
                  BlocProvider.value(value: context.read<ProfileBloc>()),
                  BlocProvider.value(value: context.read<BlogBloc>()),
                  BlocProvider.value(value: context.read<StoryBloc>()),
                  BlocProvider.value(value: context.read<BrandBloc>()),
                  BlocProvider.value(value: context.read<MainBloc>()),
                ],
                child: const SettingPage(),
              )),
    );
  }

  static goMyAccount({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ProfileBloc>()),
            BlocProvider.value(value: context.read<NotificationBloc>()),
            BlocProvider.value(value: context.read<BlogBloc>()),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child: const MyAccount(),
        ),
      ),
    );
  }

  static goSelectCountry({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => AddressBloc()
            ..add(AddressEvent.fetchCountry(context: context, isRefresh: true)),
          child: const CountryPage(),
        ),
      ),
    );
  }

  static goSelectCity({
    required BuildContext context,
    required int countryId,
    bool pushAddress = false,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => AddressBloc()
            ..add(AddressEvent.fetchCity(
                context: context, isRefresh: true, countyId: countryId)),
          child: CityPage(countryId: countryId, pushAddress: pushAddress),
        ),
      ),
    );
  }

  static goEditProfile(
      {required BuildContext context, required CustomColorSet colors}) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<ProfileBloc>(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
        ],
        child: EditAccountScreen(
          colors: colors,
        ),
      ),
    );
  }

  static goChangePassword(
      {required BuildContext context, required CustomColorSet colors}) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider.value(
        value: context.read<ProfileBloc>(),
        child: ChangePassword(
          colors: colors,
        ),
      ),
    );
  }

  static goLanguage({required BuildContext context}) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ProductBloc>()),
          BlocProvider.value(value: context.read<CategoryBloc>()),
          BlocProvider.value(value: context.read<BannerBloc>()),
          BlocProvider.value(value: context.read<ProfileBloc>()),
          BlocProvider.value(value: context.read<BlogBloc>()),
          BlocProvider.value(value: context.read<BrandBloc>()),
          BlocProvider.value(value: context.read<StoryBloc>()),
        ],
        child: const LanguagePage(),
      ),
    );
  }

  static goCurrency({required BuildContext context}) {
    return AppHelpers.showCustomModalBottomSheetDrag(
      context: context,
      maxChildSize: 0.8,
      modal: (c) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CurrencyBloc()),
          BlocProvider.value(value: context.read<ProductBloc>()),
          BlocProvider.value(value: context.read<CategoryBloc>()),
          BlocProvider.value(value: context.read<BannerBloc>()),
          BlocProvider.value(value: context.read<ProfileBloc>()),
          BlocProvider.value(value: context.read<BlogBloc>()),
          BlocProvider.value(value: context.read<BrandBloc>()),
          BlocProvider.value(value: context.read<StoryBloc>()),
        ],
        child: CurrencyPage(controller: c),
      ),
    );
  }

  static goHelp({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<ProfileBloc>()
                ..add(ProfileEvent.getHelps(context: context)),
            ),
            BlocProvider.value(value: context.read<MainBloc>()),
            BlocProvider.value(value: context.read<ProductBloc>())
          ],
          child: const HelpPage(),
        ),
      ),
    );
  }

  static goPolicy({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ProfileBloc>()
            ..add(ProfileEvent.getPolicy(context: context)),
          child: const PolicyPage(),
        ),
      ),
    );
  }

  static goTerm({required BuildContext context, bool isProfile = true}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          if (isProfile) {
            return BlocProvider.value(
              value: context.read<ProfileBloc>()
                ..add(ProfileEvent.getTerm(context: context)),
              child: const TermPage(),
            );
          } else {
            return BlocProvider(
              create: (context) =>
                  ProfileBloc()..add(ProfileEvent.getTerm(context: context)),
              child: const TermPage(),
            );
          }
        },
      ),
    );
  }

  static goTransactionList({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ProfileBloc>()),
            BlocProvider(
              create: (context) => TransactionsBloc()
                ..add(TransactionsEvent.fetchTransactions(
                    context: context, isRefresh: true)),
            )
          ],
          child: const TransactionList(),
        ),
      ),
    );
  }

  static goWalletHistory({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ProfileBloc>()),
            BlocProvider(
              create: (context) => WalletBloc()
                ..add(WalletEvent.fetchTransactions(
                    context: context, isRefresh: true))
                ..add(WalletEvent.fetchPayments(context: context)),
            )
          ],
          child: const WalletHistoryPage(),
        ),
      ),
    );
  }

  static goMyReferral({required BuildContext context}) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BlocProvider.value(
              value: context.read<ProfileBloc>()
                ..add(ProfileEvent.fetchReferral(context: context)),
              child: const ReferralPage(),
            )));
  }

  static goSelectUIType({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SelectUITypePage()),
    );
  }
}
