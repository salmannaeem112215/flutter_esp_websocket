import 'package:flutter/material.dart';

class AsynIconButton extends StatefulWidget {
  const AsynIconButton({super.key, this.onTap, required this.img});
  final Future<void> Function()? onTap;
  final String img;
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
            ? Image.asset(
                widget.img,
                height: 25,
                color: Colors.black87,
              )
            : const CircularProgressIndicator(
                color: Colors.black87,
              ),
      ),
    );
  }
}
