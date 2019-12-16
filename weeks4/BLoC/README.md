## BLoC Pattern

BLoC Pattern의 전반적인 지식을 간략히 훑어본다.



### #. BLoC ?

- Bussiness Logic Component 의 줄임말
- 프레젠테이션 레이어와 비즈니스 로직 레이어의 의존성을 분리하는데에 목적을 두고 있다.
- 코드를 `testable` 하고 `reusable` 하게 관리할 수 있다.
- 상태 관리를 효율적으로 하기 위해 Google 개발자에 의해 설계된 Pattern 이므로 Flutter 뿐만 아니라 어떠한 프레임워크에서도 사용이 가능하다.



### #.  Architecture

![BLoC Architecture](https://bloclibrary.dev/assets/bloc_architecture.png)

- BLoC Pattern은 크게 3가지의 Layer로 구성된다.
- Data Layer
  - Data Provider
    - 일반적으로 CRUD 작업을 수행
    - 대표적으로 데이터베이스 및 네트워크 작업
  - Repository
    - 하나 이상의 Data Provider를 가진 wrapper
    - Data Provider와 상호 작용하며 결과를 가공한 후, Business Logic Layer와 커뮤니케이션 하는 역할을 수행
- Business Logic Layer
  - Data Layer와 Presentation Layer 사이의 Bridge 역할을 수행
- Presentation Layer
  - 상태를 기반으로 UI의 렌더링 하는 역할과 사용자 인터렉션에 의한 이벤트 처리를 수행



### #. Implementations

- RxDart 및 Stream API를 이용하여 직접 BLoC 패턴을 구현하는 방법
- [BLoC][flutter_bloc] 패키지를 이용하여 BLoC 패턴을 구현하는 방법
  - 내부적으로 RxDart와 Stream API를 이용하여 구현되어 있으며, 위 방법의 wrapper 개념



### #. BLoC Package Core Concept

- BLoC
  - Event
    - BLoC의 input stream
  - State
    - BLoC의 output stream
  - BLoC
    - BLoC의 두뇌정도로 생각하면 된다.
    - BLoC으로 들어온 input stream을 적절한 처리 후 output stream인 상태로 변환하는 역할을 수행
- Flutter BLoC
  - BlocProvider
    - BLoC 제공자 / 하위요소에 BLoC을 제공
  - BlocBuilder
    - 상태 소비자 / BLoC을 주입받아 Builder를 통해 새로운 상태에 대한 widget을 build
  - BlocListener
    - 상태 소비자 / 상태를 구독하고 있으며, 상태의 변경에 따라 리스너를 1회성으로 호출

- ~~그냥 직접 보시죠...~~

[flutter_bloc]: https://pub.dev/packages/flutter_bloc