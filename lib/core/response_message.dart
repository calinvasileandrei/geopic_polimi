
class ResponseMessage<T>{
  int status;
  T body;
  String message;
  ResponseMessage({this.status,this.body,this.message});

}
