// Mocking the dependency (repository)
import 'package:mocktail/mocktail.dart';
import 'package:timelog/features/timelog/data/data_source/timelog_remote_datasource.dart';

class MockTimeLogRemoteDataSource extends Mock
    implements TimelogRemoteDataSource {}
