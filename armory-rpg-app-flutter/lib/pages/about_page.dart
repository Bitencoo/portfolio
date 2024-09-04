import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('about'.i18n()),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("ideia.png"),
                    height: 90,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "v1.0.0",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Card(
                color: Theme.of(context).backgroundColor.withAlpha(255),
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'about-create-dice'.i18n(),
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'about-roll-dice'.i18n(),
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'about-options-text'.i18n(),
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'about-remove-ads'.i18n(),
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
