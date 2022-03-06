import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:advanced_app_manager/home/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchBar extends HookConsumerWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(searchProvider);
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                search.state = value;
              },
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                filled: true,
                focusColor: Colors.red,
                hoverColor: Colors.red,
                fillColor: Color(0xFFFFFFFF),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                // prefixIcon: const Icon(Icons.search),
                contentPadding: EdgeInsets.only(left: 16, right: 8),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Container(
            height: 48,
            width: 50,
            decoration: const BoxDecoration(
              color: AppColor.kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
