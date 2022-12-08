import 'package:cash_app/core/global.dart';
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
            return Container(
              width: widget.logoWidth,
              height: widget.logoHeight,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(widget.logoBorderRadius)
              ),
            );
          } else if (state is GetLogoImageSuccessfulState) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(widget.logoBorderRadius),
                child: Image.network("$baseUrl${state.logoImage.logoImage.path}", width: widget.logoWidth, height: widget.logoHeight, fit: BoxFit.fitHeight,));
          } else if (state is GetLogoImageFailedState) {
            return SizedBox();
          } else {
            return SizedBox();
          }
        });
  }
}