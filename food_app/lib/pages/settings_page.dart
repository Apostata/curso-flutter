import 'package:flutter/material.dart';
import 'package:food_app/components/main_drawer.dart';
import '../models/settings.dart';

class SettingPage extends StatefulWidget {
  final Settings settings;
  final Function(Settings) onSettingsChanged;

  SettingPage(this.settings, this.onSettingsChanged);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subTitle,
    bool value,
    void Function(bool) onChange,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      value: value,
      subtitle: Text(subTitle),
      onChanged: (value) {
        onChange(value);
        widget.onSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Sem Glúten',
                  'Só exibe receitas sem glúten',
                  settings.isGlutenFree,
                  (value) => {
                    setState(() {
                      settings.isGlutenFree = value;
                    })
                  },
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Só exibe receitas sem lactose',
                  settings.isLactoseFree,
                  (value) => {
                    setState(() {
                      settings.isLactoseFree = value;
                    })
                  },
                ),
                _createSwitch(
                  'Vegana',
                  'Só exibe receitas veganas',
                  settings.isVegan,
                  (value) => {
                    setState(() {
                      settings.isVegan = value;
                    })
                  },
                ),
                _createSwitch(
                  'Vegetariana',
                  'Só exibe receitas vegetarianas',
                  settings.isVegetarian,
                  (value) => {
                    setState(() {
                      settings.isVegetarian = value;
                    })
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
