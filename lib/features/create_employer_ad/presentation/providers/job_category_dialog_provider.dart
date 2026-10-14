import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/create_employer_ad_remote_data_source.dart';
import '../../data/models/job_category_model.dart';
import '../../data/repositories/create_employer_ad_repository_impl.dart';
import '../../domain/repositories/create_employer_ad_repository.dart';

class JobCategoryDialogState {
  final bool isLoading;
  final String? errorMessage;
  final List<JobCategoryModel> mainCategories;
  final JobCategoryModel? selectedMainCategory;
  final List<JobCategoryModel> subCategories;
  final List<JobCategoryModel> selectedSubCategories;
  final String searchQuery;

  JobCategoryDialogState({
    this.isLoading = false,
    this.errorMessage,
    this.mainCategories = const [],
    this.selectedMainCategory,
    this.subCategories = const [],
    this.selectedSubCategories = const [],
    this.searchQuery = '',
  });

  List<JobCategoryModel> get filteredList {
    final targetList = selectedMainCategory == null
        ? mainCategories
        : subCategories;
    if (searchQuery.trim().isEmpty) return targetList;
    return targetList
        .where(
          (item) => item.name.toLowerCase().contains(
            searchQuery.toLowerCase().trim(),
          ),
        )
        .toList();
  }

  JobCategoryDialogState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<JobCategoryModel>? mainCategories,
    JobCategoryModel? selectedMainCategory,
    bool clearMainCategory = false,
    List<JobCategoryModel>? subCategories,
    List<JobCategoryModel>? selectedSubCategories,
    String? searchQuery,
  }) {
    return JobCategoryDialogState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      mainCategories: mainCategories ?? this.mainCategories,
      selectedMainCategory: clearMainCategory
          ? null
          : (selectedMainCategory ?? this.selectedMainCategory),
      subCategories: subCategories ?? this.subCategories,
      selectedSubCategories:
          selectedSubCategories ?? this.selectedSubCategories,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class JobCategoryDialogNotifier extends StateNotifier<JobCategoryDialogState> {
  final Ref ref;
  final CreateEmployerAdRepository repository;

  JobCategoryDialogNotifier(this.ref, this.repository)
    : super(JobCategoryDialogState()) {
    loadMainCategories();
  }

  Future<void> loadMainCategories() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final response = await repository.getMainCategories();

    response.fold(
      (l) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'خطا در برقراری ارتباط با سرور',
        );
      },
      (list) {
        state = state.copyWith(isLoading: false, mainCategories: list);
      },
    );
  }

  Future<void> selectMainCategory(JobCategoryModel main) async {
    state = state.copyWith(
      selectedMainCategory: main,
      isLoading: true,
      errorMessage: null,
      searchQuery: '',
    );

    final response = await repository.getMainCategories();

    response.fold(
      (l) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'خطا در برقراری ارتباط با سرور',
        );
      },
      (list) {
        state = state.copyWith(isLoading: false, subCategories: list);
      },
    );
  }

  void backToMainCategories() {
    state = state.copyWith(
      clearMainCategory: true,
      subCategories: [],
      searchQuery: '',
    );
  }

  void toggleSubCategory(JobCategoryModel sub) {
    final current = List<JobCategoryModel>.from(state.selectedSubCategories);
    if (current.any((item) => item.id == sub.id)) {
      current.removeWhere((item) => item.id == sub.id);
    } else {
      current.add(sub);
    }
    state = state.copyWith(selectedSubCategories: current);
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

final jobCategoryDialogProvider = StateNotifierProvider.autoDispose
    .family<
      JobCategoryDialogNotifier,
      JobCategoryDialogState,
      List<JobCategoryModel>
    >((ref, initialSelected) {
      final dio = ref.watch(dioProvider);
      final remote = CreateEmployerAdRemoteDataSourceImpl(dio);
      final repo = CreateEmployerAdRepositoryImpl(remote);
      return JobCategoryDialogNotifier(ref, repo);
    });
