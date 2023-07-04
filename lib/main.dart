import 'package:cgv/data/database/local_database.dart';
import 'package:cgv/data/datastore/local_datastore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/const/color.dart';
import 'common/const/network.dart';
import 'common/router/router.dart';
import 'data/network/local_network.dart';
import 'data/repository/database_source_impl.dart';
import 'data/repository/datastore_source_impl.dart';
import 'data/repository/network_source_impl.dart';
import 'data/repository/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      lazy: false,
      create: (context) {
        final databaseSource = DatabaseSourceImpl(
          database: LocalDatabase(),
        );
        final dataStoreSource = DataStoreSourceImpl(
          dataStore: LocalDataStore(),
        );
        final networkSource = NetworkSourceImpl(
          LocalNetwork.dio,
          baseUrl: kNetworkBaseUrl,
        );
        return Repository(
          databaseSource: databaseSource,
          dataStoreSource: dataStoreSource,
          networkSource: networkSource,
        );
      },
      child: MaterialApp.router(
        title: 'CGV Clone',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          primaryColor: primaryColor,
          fontFamily: 'NotoSansKR',
          tabBarTheme: const TabBarTheme(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSansKR',
            ),
            labelColor: Colors.white,
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: textColor,
              fontSize: 14,
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        routerConfig: routerConfig,
      ),
    );
  }
}
