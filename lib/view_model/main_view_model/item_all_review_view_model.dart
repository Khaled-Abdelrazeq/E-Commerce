import 'package:e_commerce/model/product_model.dart';
import 'package:get/get.dart';

enum SearchFilter {
  allReview,
  oneStar,
  twoStars,
  threeStars,
  fourStars,
  fiveStars
}

class ItemAllReviewsViewModel extends GetxController {
  SearchFilter currentFilter = SearchFilter.allReview;

  List<ProductCommentModel> allComments = [];
  List<ProductCommentModel> oneStarComments = [];
  List<ProductCommentModel> twoStarComments = [];
  List<ProductCommentModel> threeStarComments = [];
  List<ProductCommentModel> fourStarComments = [];
  List<ProductCommentModel> fiveStarComments = [];
  List<ProductCommentModel> currentListOfComments = [];

  String searchBy = 'Comments';

  void changeSearchFilter(
      SearchFilter filter, List<ProductCommentModel> listOfModels) {
    currentFilter = filter;
    changeCommentList(listOfModels);

    switch (currentFilter) {
      case SearchFilter.allReview:
        currentListOfComments = allComments;
        searchBy = 'No Comments';
        break;
      case SearchFilter.oneStar:
        currentListOfComments = oneStarComments;
        searchBy = 'No One Star Comments';
        break;
      case SearchFilter.twoStars:
        currentListOfComments = twoStarComments;
        searchBy = 'No Two Star Comments';
        break;
      case SearchFilter.threeStars:
        currentListOfComments = threeStarComments;
        searchBy = 'No Three Star Comments';
        break;
      case SearchFilter.fourStars:
        currentListOfComments = fourStarComments;
        searchBy = 'No Four Star Comments';
        break;
      case SearchFilter.fiveStars:
        currentListOfComments = fiveStarComments;
        searchBy = 'No Five Star Comments';
        break;
    }
    update();
  }

  void changeCommentList(List<ProductCommentModel> listOfModels) {
    oneStarComments = [];
    twoStarComments = [];
    threeStarComments = [];
    fourStarComments = [];
    fiveStarComments = [];
    allComments = [];
    for (int i = 0; i < listOfModels.length; i++) {
      switch (listOfModels[i].rate) {
        case '1':
          oneStarComments.add(listOfModels[i]);
          allComments.add(listOfModels[i]);
          break;

        case '2':
          twoStarComments.add(listOfModels[i]);
          allComments.add(listOfModels[i]);
          break;

        case '3':
          threeStarComments.add(listOfModels[i]);
          allComments.add(listOfModels[i]);
          break;

        case '4':
          fourStarComments.add(listOfModels[i]);
          allComments.add(listOfModels[i]);
          break;

        case '5':
          fiveStarComments.add(listOfModels[i]);
          allComments.add(listOfModels[i]);
          break;
      }
    }
  }
}
