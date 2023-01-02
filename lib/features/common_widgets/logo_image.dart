import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/common_widgets/blink_container.dart';
import 'package:cash_app/features/common_widgets/error_box.dart';
import 'package:cash_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:cash_app/features/home/presentation/blocs/home_event.dart';
import 'package:cash_app/features/home/presentation/blocs/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformLogoImage extends StatefulWidget {

  double logoBorderRadius, logoWidth, logoHeight;
  PlatformLogoImage({required this.logoBorderRadius, required this.logoWidth, required this.logoHeight});

  @override
  State<PlatformLogoImage> createState() => _PlatformLogoImageState();
}

class _PlatformLogoImageState extends State<PlatformLogoImage> {

  @override
  void initState() {
    // final logoImage = BlocProvider.of<LogoImageBloc>(context);
    // logoImage.add(GetLogoImageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoImageBloc, LogoImageState>(
        builder: (_, state) {
          if (state is GetLogoImageLoadingState) {
            return BlinkContainer(width: widget.logoWidth, height: widget.logoHeight, borderRadius: widget.logoBorderRadius);
          } else if (state is GetLogoImageSuccessfulState) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(widget.logoBorderRadius),
                child: Image.memory(state.logoImage.logoImage, width: widget.logoWidth, height: widget.logoHeight, fit: BoxFit.fitHeight,));
          } else if (state is GetLogoImageFailedState) {
            return SizedBox();
          } else {
            return SizedBox();
          }
        });
  }
}