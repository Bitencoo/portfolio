import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rpg_app/models/dice.dart';

import '../action_tile.dart';
import '../blocs/action/action_bloc.dart';
import '../models/action.dart';
import '../models/action_dice.dart';
import 'create_action.dart';

class ActionsPage extends StatefulWidget {
  final List<DiceItem> dices;
  const ActionsPage({Key? key, required this.dices}) : super(key: key);

  @override
  State<ActionsPage> createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    loadBannerAd();
  }

  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Platform.isIOS
          ? "ca-app-pub-3940256099942544/2934735716"
          : "ca-app-pub-2701182951790516/3468986771",
      size: AdSize.fullBanner,
      request: const AdRequest(
        keywords: [
          'RPG',
          'Dices',
          'Role Playing Games',
          'Board Game',
          'Games',
          'Role Playing',
          'D&D',
          'Dungeons & Dragons',
          'dungeons and Dragons',
          'Dice Rolling'
        ],
        nonPersonalizedAds: false,
      ),
      listener: const BannerAdListener(),
    );

    _bannerAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionBloc, ActionState>(
      builder: (context, state) {
        if (state is ActionsLoaded) {
          List<ActionItem> actions = state.actions;
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: actions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          child: SlidableAction(
                            actionDescription: actions[index].description,
                            actionName: actions[index].name,
                            dices: actions[index].actionDices,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      height: 60,
                      width: 60,
                      child: Material(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: const Icon(Icons.add),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                CreateAction.routeName,
                                arguments: widget.dices);
                            context.read<ActionBloc>().add(
                                  CreateActionEvent(
                                      action: ActionItem(
                                          actionDices: [
                                        ActionDice(sizeNumber: 6, quantity: 1),
                                        ActionDice(sizeNumber: 8, quantity: 2)
                                      ],
                                          name: 'Novo ataque',
                                          description: 'Meu novo ataque')),
                                );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: false,
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
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
      },
    );
  }
}
