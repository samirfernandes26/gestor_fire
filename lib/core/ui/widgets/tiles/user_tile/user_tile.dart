import 'package:flutter/material.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/constants/images_constants.dart';

class TileUser extends StatelessWidget {
  const TileUser({super.key, required this.onTap});

  final Future<void>? Function() onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => Card(
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            surfaceTintColor:
                context.brightness == Brightness.light
                    ? Colors.white
                    : Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  onTap: onTap,
                  onLongPress: () {
                    final batta = 1;
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            ImagesConstants.avatarFeminino,
                            semanticLabel: 'Avatar Feminino',
                            width: 64,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Nome: ',
                                      style: context.theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      'Samir Fernandes de Lima Resende',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.theme.textTheme.labelSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'Valor R\$:',
                                      style: context.theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      'data.total',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.theme.textTheme.labelSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blueAccent,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
