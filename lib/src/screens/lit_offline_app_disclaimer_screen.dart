import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitOfflineAppDisclaimerScreen extends StatelessWidget {
  final String titleText;
  final String descriptionText;
  final String confirmButtonLabel;
  final void Function() onConfirm;

  const LitOfflineAppDisclaimerScreen({
    Key? key,
    this.titleText = "Your data is safe",
    this.descriptionText =
        "This app only stores your data on your device.\n\nWe nor any other third party are able to access your private data.",
    this.confirmButtonLabel = "Okay",
    required this.onConfirm,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              HexColor('#F6F6F6'),
              HexColor('#9C9C9C'),
            ],
          ),
        ),
        child: Center(
          child: ScrollableColumn(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 64.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: SizedBox(
                        height: 128.0,
                        width: 128.0,
                        child: LitGradientCard(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              32.0,
                            ),
                          ),
                          child: Center(
                            child: LitLockIcon(),
                          ),
                        ),
                      ),
                    ),
                    _DescriptionCard(
                      text: descriptionText,
                      title: titleText,
                    ),
                  ],
                ),
              ),
              _ConfirmButton(
                label: confirmButtonLabel,
                onConfirm: onConfirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final String title;
  final String text;

  const _DescriptionCard({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitConstrainedSizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 32.0,
        ),
        child: LitGradientCard(
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Colors.black38,
              offset: Offset(-3, 3),
              spreadRadius: 1.0,
            )
          ],
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 180.0,
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: LitTextStyles.sansSerif.copyWith(
                        color: HexColor('#8A8A8A'),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                      ),
                      child: Text(
                        text,
                        style: LitTextStyles.sansSerif.copyWith(
                          color: HexColor('#A5A5A5'),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final String label;
  final void Function() onConfirm;

  const _ConfirmButton({
    Key? key,
    required this.label,
    required this.onConfirm,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 32.0,
          bottom: 32.0,
        ),
        child: LitPushedThroughButton(
          borderRadius: 16.0,
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 30.0,
          ),
          child: Text(
            label.toUpperCase(),
            style: LitTextStyles.sansSerif.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
              color: HexColor('#8A8A8A'),
              letterSpacing: 0.8,
            ),
          ),
          onPressed: onConfirm,
        ),
      ),
    );
  }
}
