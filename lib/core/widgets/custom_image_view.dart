import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageType { asset, network, svg, file }

class CustomImageView extends StatefulWidget {
  final String imagePath;
  final ImageType imageType;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool cacheNetwork;

  const CustomImageView({
    super.key,
    required this.imagePath,
    this.imageType = ImageType.asset,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.cacheNetwork = true,
  });

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Use post frame callback for lazy loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Return placeholder until visible for better performance
    if (!_isVisible && widget.imageType == ImageType.network) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(borderRadius: widget.borderRadius),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          child: widget.placeholder ?? const SizedBox.shrink(),
        ),
      );
    }

    Widget imageWidget;

    switch (widget.imageType) {
      case ImageType.asset:
        if (widget.imagePath.endsWith('.svg')) {
          imageWidget = SvgPicture.asset(
            widget.imagePath,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            colorFilter: widget.color != null
                ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                : null,
            placeholderBuilder: (context) =>
                widget.placeholder ?? const SizedBox.shrink(),
          );
        } else {
          imageWidget = Image.asset(
            widget.imagePath,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            color: widget.color,
            errorBuilder: (context, error, stackTrace) =>
                widget.errorWidget ?? const Icon(Icons.error),
            cacheHeight: widget.height?.toInt(),
            cacheWidth: widget.width?.toInt(),
          );
        }
        break;

      case ImageType.network:
        if (widget.imagePath.endsWith('.svg')) {
          imageWidget = SvgPicture.network(
            widget.imagePath,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            colorFilter: widget.color != null
                ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                : null,
            placeholderBuilder: (context) =>
                widget.placeholder ?? const SizedBox.shrink(),
          );
        } else {
          imageWidget = Image.network(
            widget.imagePath,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            color: widget.color,
            cacheHeight: widget.height?.toInt(),
            cacheWidth: widget.width?.toInt(),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return widget.placeholder ?? const SizedBox.shrink();
            },
            errorBuilder: (context, error, stackTrace) =>
                widget.errorWidget ?? const Icon(Icons.error),
          );
        }
        break;

      case ImageType.svg:
        imageWidget = SvgPicture.asset(
          widget.imagePath,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          colorFilter: widget.color != null
              ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
              : null,
          placeholderBuilder: (context) =>
              widget.placeholder ?? const SizedBox.shrink(),
        );
        break;

      case ImageType.file:
        imageWidget = Image.file(
          File(widget.imagePath),
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          color: widget.color,
          errorBuilder: (context, error, stackTrace) =>
              widget.errorWidget ?? const Icon(Icons.error),
          cacheHeight: widget.height?.toInt(),
          cacheWidth: widget.width?.toInt(),
        );
        break;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(borderRadius: widget.borderRadius),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: imageWidget,
      ),
    );
  }
}
