abstract class BaseDatasourceFactory<T> {
  T createData(DataSourceState dataSourceState);
}

enum DataSourceState { network, local, mock }
