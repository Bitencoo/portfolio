import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_app/models/dice.dart';

import '../blocs/dice/dice_bloc.dart';
import '../widgets/action_input_widget.dart';

class CreateAction extends StatelessWidget {
  static const String routeName = '/create-action';
  final List<DiceItem> dices;
  const CreateAction({Key? key, required this.dices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8823DB),
          automaticallyImplyLeading: false,
          title: const Text(
            'Tela Criação Ação',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          centerTitle: false,
          elevation: 2,
        ),
        backgroundColor: const Color.fromARGB(125, 58, 57, 59),
        body: BlocProvider(
          create: (context) => DiceBloc()..add(LoadDiceEvent()),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Text(
                              "Qual o nome da sua ação?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            cursorColor: const Color(0xFF8823DB),
                            initialValue: '0',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Text(
                              "Descreva sua ação?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            cursorColor: const Color(0xFF8823DB),
                            initialValue: '0',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Dados",
                        style: TextStyle(color: Colors.white),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.abc),
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Dados",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Container(
                                        width: 24.0,
                                        height: 24.0,
                                        child: InkWell(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .backgroundColor,
                                          ),
                                          onTap: () {},
                                          onLongPress: () {},
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "${6}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      SizedBox(
                                        width: 24.0,
                                        height: 24.0,
                                        child: InkWell(
                                          child: Icon(
                                            Icons.add_circle,
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .backgroundColor,
                                          ),
                                          onTap: () {},
                                          onLongPress: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Modificador",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Container(
                                        width: 24.0,
                                        height: 24.0,
                                        child: InkWell(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .backgroundColor,
                                          ),
                                          onTap: () {},
                                          onLongPress: () {},
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "${6}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      SizedBox(
                                        width: 24.0,
                                        height: 24.0,
                                        child: InkWell(
                                          child: Icon(
                                            Icons.add_circle,
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .backgroundColor,
                                          ),
                                          onTap: () {},
                                          onLongPress: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: dices
                            .map(
                              (dice) => ActionInputWidget(
                                dice: dice.copyWith(quantity: 0),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 64, top: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Modificador Resultado Final",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
