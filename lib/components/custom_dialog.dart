import 'package:finance/components/helper/sizes.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String bodyMessage;
  final String textCancel;
  final String textConfirm;
  const CustomDialog({
    super.key,
    required this.title,
    required this.bodyMessage,
    required this.textCancel,
    required this.textConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(PaddingSizes.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: TextSizes.md,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              const SizedBox(height: PaddingSizes.md),
              Text(
                bodyMessage,
                style: TextStyle(
                  fontSize: TextSizes.sm,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              const SizedBox(height: PaddingSizes.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      textCancel,
                      style: TextStyle(
                        fontSize: TextSizes.sm,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      textConfirm,
                      style: TextStyle(
                        fontSize: TextSizes.sm,
                        color: Theme.of(context)
                            .colorScheme
                            .inverseSurface
                            .withOpacity(0.7),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
