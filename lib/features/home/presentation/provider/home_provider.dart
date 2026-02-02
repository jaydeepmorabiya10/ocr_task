import 'package:flutter/material.dart';
import '../../domain/usecases/get_leads_usecase.dart';
import '../../domain/entities/lead.dart';

class HomeProvider extends ChangeNotifier {
  final GetLeadsUseCase getLeadsUseCase;

  HomeProvider({required this.getLeadsUseCase});

  List<Lead> _leads = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  int? _totalPages;
  String? _errorMessage;

  List<Lead> get leads => _leads;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;

  Future<void> fetchLeads({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _leads.clear();
      _hasMore = true;
      _errorMessage = null;
      _totalPages = null;
    }

    if (!_hasMore || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    final result = await getLeadsUseCase(
      GetLeadsParams(page: _currentPage, limit: 10),
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _hasMore = false;
      },
      (leadResponse) {
        _leads.addAll(leadResponse.leads);
        _currentPage++;
        _totalPages = leadResponse.lastPage;
        if (_totalPages != null && _currentPage > _totalPages!) {
          _hasMore = false;
        }
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void refresh() {
    fetchLeads(isRefresh: true);
  }
}
