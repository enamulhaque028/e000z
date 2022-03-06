// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:advanced_app_manager/home/providers/providers.dart';
import 'package:advanced_app_manager/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PopupMenu extends HookConsumerWidget {
  const PopupMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(selectionProvider.notifier);

    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'select',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Divider(),
                Text('Select all'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'unselect',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Divider(),
                Text('Unselect'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'sort',
            child: Column(
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Sort'),
                    Icon(Icons.arrow_upward),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'uninstall',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Uninstall all'),
                Divider(),
              ],
            ),
          ),
        ];
      },
      onSelected: (String value) async {
        log(value);
        if (value == 'sort') {
          sortItem(context);
        } else if (value == 'select') {
          isSelected.state = true;
          ref.read(filteredAppsProvider).state.whenData((value) {
            ref.read(selectedAppListProvider.notifier).state = value;
          });
        } else if (value == 'unselect') {
          isSelected.state = false;
          ref.read(selectedAppListProvider.notifier).state = const [];
        } else if (value == 'uninstall') {
          final selectedApp = ref.read(selectedAppListProvider);
          for (final item in selectedApp) {
            await ref
                .read(apkProvider)
                .uninstallApp(item.app.packageName ?? '');
          }
          isSelected.state = false;
          ref.read(selectedAppListProvider.notifier).state = const [];
        }
      },
      child: Container(
        height: 40,
        width: 20,
        alignment: Alignment.center,
        child: const Icon(
          Icons.more_vert,
        ),
      ),
    );
  }
}

void sortItem(BuildContext context) {
  // final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: 320,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                CustomRadioButton(),
              ],
            ),
          ),
        ),
      );
    },
  );
}
