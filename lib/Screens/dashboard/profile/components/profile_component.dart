import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TProfileMenu extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String title, value;
  final bool? email;
  const TProfileMenu({
    super.key,
    this.onPressed,
    this.email,
    required this.title,
    required this.value,
    this.icon = Icons.arrow_right,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18 / 1.5),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 1),
                  overflow: TextOverflow.ellipsis,
                )),
            // email == false
            //     ? Expanded(child: Container())
            //     : const Expanded(child: Icon(Icons.arrow_right, size: 18))
          ],
        ),
      ),
    );
  }
}

class TCircularImage extends StatelessWidget {
  final double width, height, padding;
  final String? image;
  final BoxFit? fit;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;

  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = 10,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Image(
            fit: fit,
            color: overlayColor,
            image: isNetworkImage
                ? CachedNetworkImageProvider(image!)
                : const AssetImage('assets/images/avatar.png')
                    as ImageProvider),
      ),
    );
  }
}

class TSectionHeading extends StatelessWidget {
  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  const TSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.showActionButton = true,
    this.buttonTitle = "view all",
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor, fontWeightDelta: 2),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackArrow;
  final List<Widget>? actions;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;

  const TAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_left),
            )
          : leadingIcon != null
              ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon),
                )
              : null,
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
