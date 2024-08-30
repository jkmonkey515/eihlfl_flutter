part of 'app_buttons.dart';

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    super.key,
    this.foregroundColor,
    this.borderColor,
    this.size,
    required this.state,
    required this.onPressed,
    required this.text,
    this.child,
  });

  const AppSecondaryButton.withChild({
    super.key,
    this.foregroundColor,
    this.borderColor,
    this.size,
    required this.state,
    required this.onPressed,
    this.text,
    required this.child,
  });

  final Color? foregroundColor;
  final Color? borderColor;
  final ButtonSize? size;
  final ButtonState state;
  final VoidCallback onPressed;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: state != ButtonState.initial,
      child: Opacity(
        opacity: state == ButtonState.disable ? 0.2 : 1.0,
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            height: buttonHeightFromSize(size ?? ButtonSize.medium),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: borderColor ?? Get.theme.colorScheme.primary,
              ),
            ),
            child: Center(
              child: state == ButtonState.loading
                  ? SpinKitRing(
                      color: foregroundColor ?? Get.theme.colorScheme.primary,
                      lineWidth: 3.0,
                      size: 20.0,
                    )
                  : child ??
                      Text(
                        text!,
                        style: Get.textTheme.titleMedium?.copyWith(
                          color:
                              foregroundColor ?? Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
