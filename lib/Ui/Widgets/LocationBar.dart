import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/global_bloc.dart';
import '../Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (context, state) {
      if (state is GlobalSelectStationState) {
        return state.station.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    state.type != 'train' ? Icons.location_on : Icons.train,
                    color: Colors.red,
                    size: 13.sp,
                  ),
                  Text(state.station,
                      style: TextStyle(
                          fontSize: 9.sp, fontWeight: FontWeight.w600))
                ],
              )
            : Container();
      }
      return Container();
    });
  }
}
