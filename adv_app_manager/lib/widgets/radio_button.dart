import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../home/providers/providers.dart';

class CustomRadioButton extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(appListSort);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 24.0, bottom: 10.0),
            child: Text(
              'Sort by',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 40,
            child: RadioListTile<AppListSort>(
              title: const Text('None'),
              value: AppListSort.none,
              groupValue: sort.state,
              onChanged: (value) {
                sort.state = value!;
              },
            ),
          ),
          SizedBox(
            height: 40,
            child: RadioListTile<AppListSort>(
              title: const Text('Update Date'),
              value: AppListSort.updatedDate,
              groupValue: sort.state,
              onChanged: (value) {
                sort.state = value!;
              },
            ),
          ),
          SizedBox(
            height: 40,
            child: RadioListTile<AppListSort>(
              title: const Text('Install Date'),
              value: AppListSort.installedDate,
              groupValue: sort.state,
              onChanged: (value) {
                sort.state = value!;
              },
            ),
          ),
          SizedBox(
            height: 40,
            child: RadioListTile<AppListSort>(
              title: const Text('Name'),
              value: AppListSort.name,
              groupValue: sort.state,
              onChanged: (value) {
                sort.state = value!;
              },
            ),
          ),
          SizedBox(
            height: 40,
            child: RadioListTile<AppListSort>(
              title: const Text('Size'),
              value: AppListSort.size,
              groupValue: sort.state,
              onChanged: (value) {
                sort.state = value!;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
