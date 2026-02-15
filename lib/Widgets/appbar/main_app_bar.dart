import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final List<AppBarActionItem>? actions;
  final bool showBack;
  final Color? backgroundColor;
  final Color? iconColor;
  final double elevation;
  final double height;
  final double? logoWidth;
  final double? logoHeight;

  const MainAppBar({
    Key? key,
    required this.logoPath,
    this.actions,
    this.showBack = false,
    this.backgroundColor,
    this.iconColor,
    this.elevation = 0,
    this.height = 70,
    this.logoWidth,
    this.logoHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: elevation,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🔹 Back Button (optional)
                if (showBack)
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 2),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(context),
                      icon: SvgPicture.asset(
                        'assets/svg_icons/back.svg',
                        width: size.width * 0.06,
                        height: size.width * 0.06,
                        colorFilter: const ColorFilter.mode(
                          Colors.red, // 🔴 Icon ka color red ho jayega
                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                  ),

                // 🔹 Logo (always visible)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      logoPath,
                      width: logoWidth ?? size.width * 0.25,
                      height: logoHeight ?? size.height * 0.06,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // 🔹 Right-side Actions
                if (actions != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!
                        .map(
                          (action) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            child: GestureDetector(
                              onTap: action.onTap,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ✅ Support IconData or Image (SVG/PNG)
                                  if (action.icon != null)
                                    Icon(
                                      action.icon,
                                      color: action.color ??
                                          iconColor ??
                                          Colors.black,
                                      size: size.width * 0.06,
                                    )
                                  else if (action.imagePath != null)
                                    _buildImageOrSvg(
                                      action.imagePath!,
                                      size.width * 0.06,
                                      action.color ?? iconColor ?? Colors.black,
                                    ),
                                  if (action.label != null)
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.002),
                                      child: Text(
                                        action.label!,
                                        style: TextStyle(
                                          color: action.color ??
                                              iconColor ??
                                              Colors.black,
                                          fontSize: size.width * 0.028,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔧 Detect and render SVG/PNG properly
  Widget _buildImageOrSvg(String path, double size, Color color) {
    if (path.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return Image.asset(
        path,
        width: size,
        height: size,
        color: color,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

// ✅ Updated AppBarActionItem to support both icon & image
class AppBarActionItem {
  final IconData? icon; // for normal icons
  final String? imagePath; // for SVG/PNG
  final String? label;
  final VoidCallback? onTap;
  final Color? color;

  AppBarActionItem({
    this.icon,
    this.imagePath,
    this.label,
    this.onTap,
    this.color,
  });
}
