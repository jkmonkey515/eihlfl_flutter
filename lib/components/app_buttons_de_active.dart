part of 'app_buttons.dart';

class AppDeActiveButton extends StatelessWidget {
  const AppDeActiveButton({
    super.key,
    required this.size,
    required this.onPressed,
    required this.text,
    this.child,
  });

  const AppDeActiveButton.withChild({
    super.key,
    required this.size,
    required this.onPressed,
    this.text,
    required this.child,
  });

  final Color backgroundColor = const Color(0xffEFEFEF);
  final Color foregroundColor = const Color(0xff969696);
  final ButtonSize size;
  final VoidCallback onPressed;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: Opacity(
        opacity: 1.0,
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            height: buttonHeightFromSize(size),
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: backgroundColor),
            ),
            child: Center(
              child: child ??
                  Text(
                    text!,
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: foregroundColor,
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
