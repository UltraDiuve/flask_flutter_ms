import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingActionButtonInfo {
  final String label;
  final Icon icon;
  final void Function() onPressed;

  FloatingActionButtonInfo({
    required this.label,
    required this.icon,
    required this.onPressed,
  });
}

class SingleOrMultipleFloatingActionButtons extends StatelessWidget {
  const SingleOrMultipleFloatingActionButtons({Key? key, required this.infos})
      : super(key: key);

  final List<FloatingActionButtonInfo> infos;

  @override
  Widget build(BuildContext context) {
    switch (infos.length) {
      case 0:
        {
          return (Container());
        }
      case 1:
        {
          return (FloatingActionButton(
            tooltip: infos[0].label,
            onPressed: infos[0].onPressed,
            child: infos[0].icon,
          ));
        }
      default:
        {
          return (SpeedDial(
              icon: Icons.more_horiz,
              children: infos.map(_createDialChild).toList()));
        }
    }
  }
}

SpeedDialChild _createDialChild(FloatingActionButtonInfo info) {
  return (SpeedDialChild(
    child: info.icon,
    label: info.label,
    onTap: info.onPressed,
  ));
}
