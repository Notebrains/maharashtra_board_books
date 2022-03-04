/// status : 1
/// message : "Success"
/// response : [{"category_id":"1","category_name":"Class 1","numeric_number":"1","board_wise_subjects":[{"board_id":"1","board_name":"English Medium (I)","subjects":[{"subject_id":"1","subject_name":"१ ली बालभारती इंग्रजी","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/english.pdf","is_download":"Not Downloaded"},{"subject_id":"2","subject_name":"Mathematics English","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/dummy1.pdf","is_download":"Not Downloaded"},{"subject_id":"3","subject_name":"Play Do Learn","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/dummy2.pdf","is_download":"Not Downloaded"},{"subject_id":"4","subject_name":"JAVA","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/COMPANY_PROFILE.pdf","is_download":"Not Downloaded"}]},{"board_id":"2","board_name":"Hindi Medium (I)","subjects":[]},{"board_id":"3","board_name":"Marathi Medium (I)","subjects":[]}]},{"category_id":"2","category_name":"Class 2","numeric_number":"2","board_wise_subjects":[{"board_id":"4","board_name":"English Medium (II)","subjects":[{"subject_id":"5","subject_name":"BALBHARTI","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/Balbharti_(1).pdf","is_download":"Not Downloaded"}]},{"board_id":"5","board_name":"Hindi Medium (II)","subjects":[]},{"board_id":"6","board_name":"Marathi Medium (II)","subjects":[]}]},{"category_id":"3","category_name":"Class 3","numeric_number":"3","board_wise_subjects":[{"board_id":"7","board_name":"English Medium (III)","subjects":[]},{"board_id":"8","board_name":"Hindi Medium (III)","subjects":[]},{"board_id":"9","board_name":"Marathi Medium (III)","subjects":[]}]},{"category_id":"4","category_name":"Class 4","numeric_number":"4","board_wise_subjects":[{"board_id":"10","board_name":"English Medium (IV)","subjects":[]},{"board_id":"11","board_name":"Hindi Medium (IV)","subjects":[]},{"board_id":"12","board_name":"Marathi Medium (IV)","subjects":[]}]},{"category_id":"5","category_name":"Class 5","numeric_number":"5","board_wise_subjects":[{"board_id":"13","board_name":"English Medium (V)","subjects":[]},{"board_id":"14","board_name":"Hindi Medium (V)","subjects":[]},{"board_id":"15","board_name":"Marathi Medium (V)","subjects":[]}]},{"category_id":"6","category_name":"Class 6","numeric_number":"6","board_wise_subjects":[{"board_id":"16","board_name":"English Medium (VI)","subjects":[]},{"board_id":"17","board_name":"Hindi Medium (VI)","subjects":[]},{"board_id":"18","board_name":"Marathi Medium (VI)","subjects":[]}]},{"category_id":"7","category_name":"Class 7","numeric_number":"7","board_wise_subjects":[{"board_id":"19","board_name":"English Medium (VII)","subjects":[]},{"board_id":"20","board_name":"Hindi Medium (VII)","subjects":[]},{"board_id":"21","board_name":"Marathi Medium (VII)","subjects":[]}]},{"category_id":"8","category_name":"Class 8","numeric_number":"8","board_wise_subjects":[{"board_id":"22","board_name":"English Medium (VIII)","subjects":[]},{"board_id":"23","board_name":"Hindi Medium (VIII)","subjects":[]},{"board_id":"24","board_name":"Marathi Medium (VIII)","subjects":[]}]},{"category_id":"9","category_name":"Class 9","numeric_number":"9","board_wise_subjects":[{"board_id":"25","board_name":"English Medium (IX)","subjects":[]},{"board_id":"26","board_name":"Hindi Medium (IX)","subjects":[]},{"board_id":"27","board_name":"Marathi Medium (IX)","subjects":[]}]},{"category_id":"10","category_name":"Class 10","numeric_number":"10","board_wise_subjects":[{"board_id":"28","board_name":"English Medium (X)","subjects":[]},{"board_id":"29","board_name":"Hindi Medium (X)","subjects":[]},{"board_id":"30","board_name":"Marathi Medium (X)","subjects":[]}]},{"category_id":"11","category_name":"Class 11","numeric_number":"11","board_wise_subjects":[{"board_id":"31","board_name":"English Medium (XI)","subjects":[]},{"board_id":"32","board_name":"Hindi Medium (XI)","subjects":[]},{"board_id":"33","board_name":"Marathi Medium (XI)","subjects":[]},{"board_id":"34","board_name":"Gujarati (XI)","subjects":[]},{"board_id":"35","board_name":"Kannada (XI)","subjects":[]},{"board_id":"36","board_name":"Sindhi (XI)","subjects":[]},{"board_id":"37","board_name":"Telugu (XI)","subjects":[]}]},{"category_id":"12","category_name":"Class 12","numeric_number":"12","board_wise_subjects":[{"board_id":"38","board_name":"English Medium (XII)","subjects":[]},{"board_id":"39","board_name":"Hindi Medium (XII)","subjects":[]},{"board_id":"40","board_name":"Marathi Medium (XII)","subjects":[]},{"board_id":"41","board_name":"Gujarati (XII)","subjects":[]},{"board_id":"42","board_name":"Kannada (XII)","subjects":[]},{"board_id":"43","board_name":"Sindhi (XII)","subjects":[]},{"board_id":"44","board_name":"Telugu (XII)","subjects":[]}]}]

class SubjectsApiResModel {
  SubjectsApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  SubjectsApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['response'] != null) {
      _response = [];
      json['response'].forEach((v) {
        _response?.add(Response.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<Response>? _response;

  int? get status => _status;
  String? get message => _message;
  List<Response>? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_response != null) {
      map['response'] = _response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category_id : "1"
/// category_name : "Class 1"
/// numeric_number : "1"
/// board_wise_subjects : [{"board_id":"1","board_name":"English Medium (I)","subjects":[{"subject_id":"1","subject_name":"१ ली बालभारती इंग्रजी","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/english.pdf","is_download":"Not Downloaded"},{"subject_id":"2","subject_name":"Mathematics English","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/dummy1.pdf","is_download":"Not Downloaded"},{"subject_id":"3","subject_name":"Play Do Learn","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/dummy2.pdf","is_download":"Not Downloaded"},{"subject_id":"4","subject_name":"JAVA","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/COMPANY_PROFILE.pdf","is_download":"Not Downloaded"}]},{"board_id":"2","board_name":"Hindi Medium (I)","subjects":[]},{"board_id":"3","board_name":"Marathi Medium (I)","subjects":[]}]

class Response {
  Response({
      String? categoryId, 
      String? categoryName, 
      String? numericNumber, 
      List<BoardWiseSubjects>? boardWiseSubjects,}){
    _categoryId = categoryId;
    _categoryName = categoryName;
    _numericNumber = numericNumber;
    _boardWiseSubjects = boardWiseSubjects;
}

  Response.fromJson(dynamic json) {
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _numericNumber = json['numeric_number'];
    if (json['board_wise_subjects'] != null) {
      _boardWiseSubjects = [];
      json['board_wise_subjects'].forEach((v) {
        _boardWiseSubjects?.add(BoardWiseSubjects.fromJson(v));
      });
    }
  }
  String? _categoryId;
  String? _categoryName;
  String? _numericNumber;
  List<BoardWiseSubjects>? _boardWiseSubjects;

  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get numericNumber => _numericNumber;
  List<BoardWiseSubjects>? get boardWiseSubjects => _boardWiseSubjects;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['numeric_number'] = _numericNumber;
    if (_boardWiseSubjects != null) {
      map['board_wise_subjects'] = _boardWiseSubjects?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// board_id : "1"
/// board_name : "English Medium (I)"
/// subjects : [{"subject_id":"1","subject_name":"१ ली बालभारती इंग्रजी","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/english.pdf","is_download":"Not Downloaded"},{"subject_id":"2","subject_name":"Mathematics English","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/dummy1.pdf","is_download":"Not Downloaded"},{"subject_id":"3","subject_name":"Play Do Learn","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/dummy2.pdf","is_download":"Not Downloaded"},{"subject_id":"4","subject_name":"JAVA","book_pdf":"https://teracotta.in/demo/projects/books_management/uploads/COMPANY_PROFILE.pdf","is_download":"Not Downloaded"}]

class BoardWiseSubjects {
  BoardWiseSubjects({
      String? boardId, 
      String? boardName, 
      List<Subjects>? subjects,}){
    _boardId = boardId;
    _boardName = boardName;
    _subjects = subjects;
}

  BoardWiseSubjects.fromJson(dynamic json) {
    _boardId = json['board_id'];
    _boardName = json['board_name'];
    if (json['subjects'] != null) {
      _subjects = [];
      json['subjects'].forEach((v) {
        _subjects?.add(Subjects.fromJson(v));
      });
    }
  }
  String? _boardId;
  String? _boardName;
  List<Subjects>? _subjects;

  String? get boardId => _boardId;
  String? get boardName => _boardName;
  List<Subjects>? get subjects => _subjects;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['board_id'] = _boardId;
    map['board_name'] = _boardName;
    if (_subjects != null) {
      map['subjects'] = _subjects?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// subject_id : "1"
/// subject_name : "१ ली बालभारती इंग्रजी"
/// book_pdf : "https://teracotta.in/demo/projects/books_management/uploads/english.pdf"
/// is_download : "Not Downloaded"

class Subjects {
  Subjects({
      String? subjectId, 
      String? subjectName, 
      String? bookPdf, 
      String? isDownload,}){
    _subjectId = subjectId;
    _subjectName = subjectName;
    _bookPdf = bookPdf;
    _isDownload = isDownload;
}

  Subjects.fromJson(dynamic json) {
    _subjectId = json['subject_id'];
    _subjectName = json['subject_name'];
    _bookPdf = json['book_pdf'];
    _isDownload = json['is_download'];
  }
  String? _subjectId;
  String? _subjectName;
  String? _bookPdf;
  String? _isDownload;

  String? get subjectId => _subjectId;
  String? get subjectName => _subjectName;
  String? get bookPdf => _bookPdf;
  String? get isDownload => _isDownload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subject_id'] = _subjectId;
    map['subject_name'] = _subjectName;
    map['book_pdf'] = _bookPdf;
    map['is_download'] = _isDownload;
    return map;
  }

}