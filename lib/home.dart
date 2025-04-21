import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'blocs/user/user_bloc.dart';
import 'screens/animation_example/animation_screen.dart';
import 'screens/bloc_example/user_bloc_screen.dart';
import 'screens/getx_example/counter_getx_screen.dart';
import 'screens/inherited_widget_example/counter_root.dart';
import 'screens/isolate_example/isolate_home.dart';
import 'screens/network_example/network_home.dart';
import 'screens/provider_example/user_screen.dart';
import 'screens/riverpod_example/user_riverpod_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.appTitle),
      ),
      body: ListView(
        children: [
          _buildListTile(
            title: l10n.inheritedWidget,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CounterRoot()),
            ),
            subtitle: l10n.inheritedWidgetDesc,
          ),
          _buildListTile(
            title: l10n.network,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NetworkHome()),
            ),
            subtitle: l10n.networkDesc,
          ),
          _buildListTile(
            title: l10n.provider,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const UserScreen()),
            ),
            subtitle: l10n.providerDesc,
          ),
          _buildListTile(
            title: l10n.bloc,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => UserBloc(),
                  child: const UserBlocScreen(),
                ),
              ),
            ),
            subtitle: l10n.blocDesc,
          ),
          _buildListTile(
            title: l10n.getx,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CounterGetXScreen()),
            ),
            subtitle: l10n.getxDesc,
          ),
          _buildListTile(
            title: l10n.riverpod,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const UserRiverpodScreen()),
            ),
            subtitle: l10n.riverpodDesc,
          ),
          _buildListTile(
            title: 'Animations',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AnimationScreen()),
            ),
            subtitle: 'Examples of different types of Flutter animations',
          ),
          _buildListTile(
            title: 'Isolates',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const IsolateHome()),
            ),
            subtitle: 'Examples of different types of Flutter animations',
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required VoidCallback onTap,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}