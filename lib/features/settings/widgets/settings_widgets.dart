import 'package:flutter/material.dart';

/// iOS-style grouped list shape: first item top-rounded, last item bottom-rounded.
ShapeBorder getSettingsShape(int groupSize, int index) {
  const r = Radius.circular(24);
  const s = Radius.circular(4);
  if (groupSize == 1) return const RoundedRectangleBorder(borderRadius: BorderRadius.all(r));
  if (index == 0) return RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: r, bottom: s));
  if (index == groupSize - 1) return RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: s, bottom: r));
  return const RoundedRectangleBorder(borderRadius: BorderRadius.all(s));
}

class BetaBadge extends StatelessWidget {
  const BetaBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'BETA',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

class SettingsGroupTitle extends StatelessWidget {
  final String title;
  const SettingsGroupTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const SettingsGroup({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (title != null) SettingsGroupTitle(title: title!),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: List.generate(children.length, (i) {
            return Padding(
              padding: EdgeInsets.only(bottom: i < children.length - 1 ? 2 : 0),
              child: children[i],
            );
          }),
        ),
      ),
    ]);
  }
}

/// A single settings row with optional switch, icon, title, subtitle, onClick.
class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final bool hasSwitch;
  final bool switchState;
  final ValueChanged<bool>? onSwitchChange;
  final VoidCallback? onClick;
  final bool showBetaBadge;

  const SettingsItem({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.hasSwitch = false,
    this.switchState = false,
    this.onSwitchChange,
    this.onClick,
    this.showBetaBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainer,
      margin: EdgeInsets.zero,
      shape: onClick != null && !hasSwitch
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
          : null,
      child: InkWell(
        onTap: onClick,
        borderRadius: null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: cs.primary, size: 24),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      if (showBetaBadge) ...[
                        const SizedBox(width: 8),
                        const BetaBadge(),
                      ],
                    ]),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(subtitle!, style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant)),
                      ),
                  ],
                ),
              ),
              if (hasSwitch) ...[
                Switch(
                  value: switchState,
                  onChanged: onSwitchChange,
                  thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) =>
                    states.contains(WidgetState.selected)
                      ? const Icon(Icons.check, size: 16)
                      : const Icon(Icons.close, size: 16)),
                ),
              ] else if (onClick != null) ...[
                Icon(Icons.arrow_forward_ios, size: 16, color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Dropdown selector row.
class SettingsDropdownItem<T> extends StatelessWidget {
  final IconData? icon;
  final String title;
  final T selected;
  final List<T> options;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;

  const SettingsDropdownItem({
    super.key,
    this.icon,
    required this.title,
    required this.selected,
    required this.options,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainer,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: cs.primary, size: 24),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  DropdownButton<T>(
                    value: selected,
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor: cs.surfaceContainerHigh,
                    items: options.map((t) => DropdownMenuItem(value: t, child: Text(labelBuilder(t)))).toList(),
                    onChanged: (v) { if (v != null) onChanged(v); },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Integer slider row.
class SettingsIntegerSliderItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final int value;
  final int min;
  final int max;
  final int divisions;
  final VoidCallback? onReset;
  final ValueChanged<int> onChanged;

  const SettingsIntegerSliderItem({
    super.key,
    this.icon,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    this.onReset,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainer,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Row(children: [
              if (icon != null) ...[Icon(icon, color: cs.primary, size: 24), const SizedBox(width: 16)],
              Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
              if (onReset != null)
                IconButton(icon: const Icon(Icons.restart_alt, size: 20), onPressed: onReset),
              Text('$value', style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
            ]),
            Row(children: [
              Icon(Icons.remove, size: 20, color: cs.primary),
              Expanded(
                child: Slider(
                  value: value.toDouble(),
                  min: min.toDouble(),
                  max: max.toDouble(),
                  divisions: divisions,
                  onChanged: (v) => onChanged(v.round()),
                ),
              ),
              Icon(Icons.add, size: 20, color: cs.primary),
            ]),
          ],
        ),
      ),
    );
  }
}

/// Float slider row (for zoom).
class SettingsSliderItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const SettingsSliderItem({
    super.key,
    this.icon,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainer,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Row(children: [
              if (icon != null) ...[Icon(icon, color: cs.primary, size: 24), const SizedBox(width: 16)],
              Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
              Text('${value.toStringAsFixed(1)}x', style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
            ]),
            Row(children: [
              Icon(Icons.zoom_out, size: 20, color: cs.primary),
              Expanded(
                child: Slider(value: value, min: min, max: max, onChanged: onChanged),
              ),
              Icon(Icons.zoom_in, size: 20, color: cs.primary),
            ]),
          ],
        ),
      ),
    );
  }
}

/// Generic radio dialog.
class SettingsRadioDialog<T> extends StatelessWidget {
  final String title;
  final Map<T, String> options;
  final T selected;
  final ValueChanged<T> onConfirm;
  final Map<T, String>? subtitles;
  final T? betaItem;

  const SettingsRadioDialog({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onConfirm,
    this.subtitles,
    this.betaItem,
  });

  @override
  Widget build(BuildContext context) {
    T tempSelected = selected;
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.maxFinite,
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: options.entries.map((e) {
              return RadioListTile<T>(
                value: e.key,
                groupValue: tempSelected,
                title: Text(e.value),
                subtitle: subtitles?[e.key] != null ? Text(subtitles![e.key]!) : null,
                onChanged: (v) { if (v != null) setState(() => tempSelected = v); },
              );
            }).toList(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        TextButton(
          onPressed: () { onConfirm(tempSelected); Navigator.pop(context); },
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
      ],
    );
  }
}

/// Settings page scaffold with LargeTopAppBar.
class SettingsScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const SettingsScaffold({super.key, required this.title, required this.body, this.actions});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(title),
            pinned: true,
            stretch: true,
            backgroundColor: cs.surfaceContainerHighest,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton.filledTonal(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            actions: actions,
          ),
          SliverToBoxAdapter(child: body),
        ],
      ),
    );
  }
}
