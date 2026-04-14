abstract class PaginationEvent {}

class LoadInitialEvent extends PaginationEvent {}

class LoadMoreEvent extends PaginationEvent {}

class RefreshEvent extends PaginationEvent {}
