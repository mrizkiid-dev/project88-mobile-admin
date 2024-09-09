part of 'root_bloc.dart';

class RootPageState extends Equatable {
  const RootPageState({
    required this.enumRootPage
  });
  final EnumRootPage enumRootPage;

  RootPageState copyWith(EnumRootPage? enumRootPage) {
    return RootPageState(
      enumRootPage: enumRootPage ?? this.enumRootPage
    );
  }

  factory RootPageState.initial() {
    return RootPageState(enumRootPage: EnumRootPage.homepage);
  }

  factory RootPageState.homepage() {
    return RootPageState(enumRootPage: EnumRootPage.homepage);
  }

  factory RootPageState.productpage() {
    return RootPageState(enumRootPage: EnumRootPage.product);
  }

  factory RootPageState.chatPage() {
    return RootPageState(enumRootPage: EnumRootPage.chat);
  }

  factory RootPageState.orderpage() {
    return RootPageState(enumRootPage: EnumRootPage.order);
  }

  factory RootPageState.profilepage() {
    return RootPageState(enumRootPage: EnumRootPage.profile);
  }
  
  @override
  List<Object> get props => [enumRootPage];
}

// sealed class RootPageState extends Equatable {
//   const RootPageState();

//   @override
//   List<Object> get props => [];
// }