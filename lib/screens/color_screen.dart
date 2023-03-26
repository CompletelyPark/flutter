import 'package:flutter/material.dart';

class selectcolor extends StatefulWidget {
  const selectcolor({super.key});

  @override
  State<selectcolor> createState() => _selectcolorState();
}

class _selectcolorState extends State<selectcolor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                color_widget(color: Colors.redAccent),
                color_widget(color: Colors.orangeAccent),
                color_widget(color: Colors.yellowAccent),
                color_widget(color: Colors.greenAccent),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                color_widget(color: Colors.blueAccent),
                color_widget(color: Colors.indigoAccent),
                color_widget(color: Colors.purpleAccent),
                color_widget(color: Colors.pinkAccent),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class color_widget extends StatelessWidget {
  const color_widget({
    super.key,
    required this.color,
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
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
