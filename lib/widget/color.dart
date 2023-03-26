import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class color_widget extends StatelessWidget {
  const color_widget({
    super.key,
    required this.color,
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Theme.of(context).colorScheme.background,
      )),
      height: 50,
      width: MediaQuery.of(context).size.width / 8,
      child: Center(
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class color_picker extends StatefulWidget {
  color_picker({super.key});

  @override
  State<color_picker> createState() => _color_pickerState();
}

class _color_pickerState extends State<color_picker> {
  Color backgroundcolor = Colors.greenAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ColorPicker(
        pickerColor: backgroundcolor,
        onColorChanged: (Color color) {
          setState(
            () {
              backgroundcolor = color;
            },
          );
        },
        pickerAreaHeightPercent: 0.5,
        paletteType: PaletteType.hueWheel,
      ),
    );
  }
}
