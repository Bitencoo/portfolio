import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rpg_app/blocs/dice/dice_bloc.dart';
import 'package:rpg_app/blocs/in_app_purchase/in_app_purchase_bloc.dart';
import 'package:rpg_app/blocs/theme/theme_bloc.dart';
import 'package:rpg_app/models/dice.dart';
import 'package:rpg_app/pages/about_page.dart';
import 'package:rpg_app/pages/actions_page.dart';
import 'package:rpg_app/pages/create_action.dart';
import 'package:rpg_app/pages/dices_page.dart';
import 'package:rpg_app/pages/history_page.dart';
import 'package:rpg_app/theme/dark_theme.dart';
import 'package:rpg_app/theme/light_theme.dart';
import 'package:rpg_app/utils/languages.dart';
import 'blocs/action/action_bloc.dart';
import 'blocs/history/history_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localization/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String defaultLocale = Platform.localeName;
    if (!availableLanguages.contains(defaultLocale)) {
      defaultLocale = "en_US";
    }
    print('DEFAULT:' + defaultLocale);
    return MultiBlocProvider(
      providers: [
        BlocProvider<DiceBloc>(
          create: (context) => DiceBloc()..add(LoadDiceEvent()),
        ),
        BlocProvider<ActionBloc>(
          create: (context) => ActionBloc()..add(LoadActionEvent()),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc()..add(LoadHistoryEvent()),
        ),
        BlocProvider<ThemeBloc>(
          create: ((context) => ThemeBloc()..add(LoadThemeEvent())),
        ),
        BlocProvider<InAppPurchaseBloc>(
            create: ((context) => InAppPurchaseBloc()))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoaded) {
            return MaterialApp(
              locale: Locale(
                  defaultLocale.split('_')[0], defaultLocale.split('_')[1]),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                LocalJsonLocalization.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('es', 'ES'),
                Locale('pt', 'BR'),
              ],
              title: 'Flutter Demo',
              theme: state.themeType == ThemeType.DARK
                  ? themeDataDark
                  : themeDataLight,
              debugShowCheckedModeBanner: false,
              home: MyHomePage(
                themeType: state.themeType,
              ),
              routes: {
                CreateAction.routeName: (context) => CreateAction(
                    dices: ModalRoute.of(context)?.settings.arguments
                        as List<DiceItem>),
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.themeType}) : super(key: key);
  final ThemeType themeType;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? _bannerAd;
  int index = 0;
  List<String> entitlements = [];

  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Platform.isIOS
          ? "ca-app-pub-3940256099942544/2934735716"
          : "ca-app-pub-2701182951790516/3468986771",
      size: AdSize.fullBanner,
      request: const AdRequest(
        nonPersonalizedAds: false,
      ),
      listener: const BannerAdListener(),
    );

    _bannerAd?.load();
  }

  @override
  void initState() {
    super.initState();
    loadBannerAd();
    initPlatformState();
    verifyPurchases();
  }

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.configure(PurchasesConfiguration(apiKey));
  }

  Future<void> verifyPurchases() async {
    try {
      await Purchases.configure(PurchasesConfiguration(apiKey));
      final CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      entitlements = purchaserInfo.allPurchasedProductIdentifiers;
      if (entitlements.contains('remove_ads_test') == false) {
        loadBannerAd();
      }
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {}
  }

  Future<void> restorePurchases() async {
    try {
      await Purchases.configure(PurchasesConfiguration(apiKey));
      CustomerInfo restoredInfo = await Purchases.restorePurchases();
      setState(() {
        entitlements = restoredInfo.allPurchasedProductIdentifiers;
      });
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      DicesPage(
        dices: [],
      ),
      HistoryPage(),
    ];

    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        context.read<ThemeBloc>();
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Image(
              image: AssetImage("ideia.png"),
              height: 90,
              fit: BoxFit.fill,
            ),
            centerTitle: true,
            elevation: 2,
            actions: [
              IconButton(
                onPressed: () {
                  context
                      .read<ThemeBloc>()
                      .add(UpdateThemeEvent(currentTheme: widget.themeType));
                },
                icon: Icon(widget.themeType == ThemeType.LIGHT
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded),
              ),
              PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  position: PopupMenuPosition.under,
                  itemBuilder: ((_) {
                    return [
                      PopupMenuItem(
                        child: SizedBox(child: Text('about'.i18n())),
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          await Future.delayed(Duration.zero);
                          navigator.push(
                            MaterialPageRoute(builder: (_) => AboutPage()),
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: Text('remove-ads'.i18n()),
                        onTap: () async {
                          context
                              .read<InAppPurchaseBloc>()
                              .add(InAppPurchaseLoadEvent());
                        },
                      ),
                      PopupMenuItem(
                        child: Text('restore-purchase'.i18n()),
                        onTap: () {
                          setState(() {
                            restorePurchases();
                          });
                        },
                      )
                    ];
                  }))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (_index) {
              setState(() {
                index = _index;
                _bannerAd?.dispose();
                _bannerAd?.load();
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.dice), label: 'dices'.i18n()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'historic'.i18n()),
            ],
          ),
          body: Column(children: [
            Expanded(child: tabs[index]),
            Visibility(
              visible: !entitlements.contains('remove_ads_test'),
              child: _bannerAd != null
                  ? Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: _bannerAd?.size.width.toDouble(),
                        height: _bannerAd?.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ),
            ),
          ]),
        );
      },
    );
  }
}
