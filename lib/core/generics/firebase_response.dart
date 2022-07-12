class FirebaseResponse<T, E> {
  T? data;
  E? error;
  Status status;

  bool get hasError => error != null;

  FirebaseResponse.loading(
      {this.data, this.error, this.status = Status.loading});
  FirebaseResponse.success(
      {this.data, this.error, this.status = Status.success});
  FirebaseResponse.failed({this.data, this.error, this.status = Status.failed});
}

enum Status { loading, failed, success }
