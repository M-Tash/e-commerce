import 'package:bloc/bloc.dart';
import 'package:e_commerce/domain/use_cases/get_all_categories_use_case.dart';
import 'package:e_commerce/ui/home/tabs/home_tab/cubit/states.dart';
import 'package:dartz/dartz.dart';
import '../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import '../../../../../domain/use_cases/get_all_brands_use_case.dart';

class HomeTabViewModel extends Cubit<HomeTabStates> {
  GetAllCategoriesUseCase categoriesUseCase;
  GetAllBrandsUseCase getAllBrandsUseCase;

  HomeTabViewModel(
      {required this.categoriesUseCase, required this.getAllBrandsUseCase})
      : super(HomeTabInitState());
  List<CategoryOrBrandEntity> categoriesList = [];
  List<CategoryOrBrandEntity> brandsList = [];

  void getAllCategories() async {
    emit(CategoryLoadingState(loadingMessage: 'Loading'));
    var either = await categoriesUseCase.invoke();
    either.fold((l) {
      emit(CategoryErrorState(errors: l));
    }, (response) {
      categoriesList = response.data ?? [];
      emit(CategorySuccessState(categoryResponseEntity: response));
    });
  }

  void getAllBrands() async {
    emit(BrandLoadingState(loadingMessage: 'Loading'));
    var either = await getAllBrandsUseCase.invoke();
    either.fold((l) {
      emit(BrandErrorState(errors: l));
    }, (response) {
      brandsList = response.data ?? [];
      emit(BrandSuccessState(categoryOrBrandResponseEntity: response));
    });
  }
}
