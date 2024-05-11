import 'package:flutter/material.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/style_manager.dart';

class TrackBar extends StatefulWidget {
  double _value = 0.0;

  TrackBar({Key? key}) : super(key: key);

  @override
  _TrackBarState createState() => _TrackBarState();
}

class _TrackBarState extends State<TrackBar> {
  void changeValue(double value) {
    setState(() {
      widget._value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 32),
      decoration: BoxDecoration(
        color: ColorManager.primaryTextColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {},
                  child: const Icon(
                    textDirection: TextDirection.rtl,
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
              InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.pause,
                    color: Colors.white,
                  )),
              InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
            ],
          ),
          Text('00:00',
              style: getSemiBoldStyle(color: Colors.white, fontSize: 14)),
          Expanded(
            child: SizedBox(
              child: Slider(
                value: widget._value,
                min: 0.0,
                max: 100.0,
                onChanged: (value) {
                  changeValue(value);
                },
                activeColor: ColorManager.primaryColor,
                inactiveColor: Colors.white,
              ),
            ),
          ),
          Text('00:00',
              style: getSemiBoldStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}
