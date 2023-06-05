import 'package:flutter/material.dart';

class AsynIconButton extends StatefulWidget {
  const AsynIconButton({
    super.key,
    this.onTap,
    this.img,
    this.icon,
    this.rotatedTuen = 0,
  });
  final Future<void> Function()? onTap;
  final String? img;

  final IconData? icon;
  final int rotatedTuen;
  @override
  State<AsynIconButton> createState() => _AsynIconButtonState();
}

class _AsynIconButtonState extends State<AsynIconButton> {
  bool isLoading = false;
  setLoading(bool val) {
    if (isLoading == val) return;
    setState(() {
      isLoading = val;
    });
  }

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap == null
          ? null
          : () async {
              setLoading(true);
              await widget.onTap!();
              setLoading(false);
            },
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 25 + 16 + 16,
        width: 25 + 16 + 16,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: !isLoading
            ? getIcon()
            : const CircularProgressIndicator(
                color: Colors.black87,
              ),
      ),
    );
  }

  getIcon() {
    if (widget.img != null) {
      return Image.asset(
        widget.img!,
        height: 25,
        color: Colors.black87,
      );
    } else if (widget.icon != null) {
      return RotatedBox(
        quarterTurns: widget.rotatedTuen,
        child: Icon(
          widget.icon,
          size: 25,
          color: Colors.black87,
        ),
      );
    } else {
      return const SizedBox(height: 24);
    }
  }
}
