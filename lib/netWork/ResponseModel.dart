
class ResponseModel<T>{
  late Status status;
  late String massage;
  late T data;

  ResponseModel.loading(this.massage):status=Status.LOADING;
  ResponseModel.completed(this.data):status=Status.COMPLETED;
  ResponseModel.error(this.massage):status=Status.ERROR;






 }
  enum Status{LOADING,COMPLETED,ERROR}