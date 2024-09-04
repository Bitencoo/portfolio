import 'package:flutter/material.dart';

class ActionInputDialog extends StatefulWidget {
  final int diceQuantity;
  final int diceSides;
  const ActionInputDialog(
      {Key? key, required this.diceQuantity, required this.diceSides})
      : super(key: key);

  @override
  State<ActionInputDialog> createState() => _ActionInputDialogState();
}

class _ActionInputDialogState extends State<ActionInputDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Modificadores D${widget.diceSides}',
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Confirmar'))
      ],
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.diceQuantity,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: const Color(0xFF8823DB),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "D${widget.diceSides}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 203, 67, 249)),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Modificador",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF8823DB),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: const Color(0xFF2E2A2A),
                                                width: 2,
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 50,
                                            height: 35,
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              cursorColor:
                                                  const Color(0xFF8823DB),
                                              initialValue: '0',
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF8823DB),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: const Color(0xFF2E2A2A),
                                                width: 2,
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                print("clicou");
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Text(
                    "Modificador Resultado Final",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      cursorColor: const Color(0xFF8823DB),
                      initialValue: '0',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
