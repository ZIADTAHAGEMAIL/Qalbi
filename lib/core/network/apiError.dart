 class apiError{
  final String error;
  final int? stausCode;
  apiError({required this.error,this.stausCode});

  String tostring(){
    return "Error is $error";
  }
}