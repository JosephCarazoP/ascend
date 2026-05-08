import 'package:flutter/material.dart';

import 'theme_toggle_button.dart';

class AuthScreenShell extends StatelessWidget {
  const AuthScreenShell({
    super.key,
    required this.appBarTitle,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String appBarTitle;
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = theme.dividerTheme.color ?? colorScheme.outline;
    final mutedColor = colorScheme.onSurface.withValues(alpha: 0.05);

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: colorScheme.secondary.withValues(
                                alpha: 0.12,
                              ),
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(icon, color: colorScheme.secondary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'ASCEND',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(title, style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.66),
                        ),
                      ),
                      const SizedBox(height: 24),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: mutedColor,
                          border: Border(top: BorderSide(color: borderColor)),
                        ),
                        child: const SizedBox(height: 1),
                      ),
                      const SizedBox(height: 24),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
