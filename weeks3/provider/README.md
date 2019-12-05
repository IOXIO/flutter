## 앱상태
- 임시상태(지역), 공유 상태(전역)
- setState로 변이

## 간단한 앱 상태 관리
-  [선언적 UI 프로그래밍](https://flutter.dev/docs/development/data-and-backend/state-mgmt/declarative)와 [임시상태(지역), 공유 상태(전역)](https://flutter.dev/docs/development/data-and-backend/state-mgmt/ephemeral-vs-app) 숙지 필요
- provider 패키지 사용할 예정
- ([Redux](https://pub.dev/packages/redux), [Rx](https://pub.dev/packages/rx), [Hook](https://pub.dev/packages/flutter_hooks) 등)을 선택할 강력한 이유가 없는 경우 provider 사용
  - redux: 글로벌 저장소
  - rx: 리액티브 프로그래밍
  - Mobx: 데코레이터 패턴 사용
  - Hook: 함수에서 컴포넌트에서 state 변경 가능
* 리액트의 기법들이 flutter에 많이 도입되고 있는 듯 하다.

### sample app
![sample app](https://flutter.dev/assets/development/data-and-backend/state-mgmt/model-shopper-screencast-e0ada0e83cd8e7fdcad84167b8f7ffd7eb5ef85b0cb8957f03c6f05bd16b1cea.gif)
- 카탈로그와 장바구니( 각각 MyCatalog및 MyCart위젯으로 표시됨)라는 두 개의 별도 화면
- 사용자 정의 앱 바 ( MyAppBar) 및 많은 목록 항목의 스크롤보기 ( MyListItems)
![](https://flutter.dev/assets/development/data-and-backend/state-mgmt/simple-widget-tree-0731408a48dff242cc0ea9b8203bd9a6e0d6f1be0bb158e095ea99212fe8e727.png)
- 최소 6개의 서브 클래스와 widget이 있다.
- 많은 사람들이 다른 곳에 있는 ”상태”에 접근 할 수 있어야합니다. ex) 각각 MyListItem 장바구니에 추가

### 리프팅 상태
- Flutter에서는 상태를 사용하는 위젯 위에 상태를 유지하는 것이 좋다.
  - 선언적 프레임 워크에서 UI를 변경하려면 UI를 다시 빌드해야 하기 때문에..

```dart
// BAD: DO NOT DO THIS
void myTapHandler() {
  var cartWidget = somehowGetMyCartWidget();  // 부모 위젯
  cartWidget.updateWith(item);
}
```

```dart
// BAD: DO NOT DO THIS
Widget build(BuildContext context) {
  return SomeWidget(
    // 부모 위젯의 build() 메소드
  );
}

void updateWith(Item item) {
  // UI를 직접 바꾼다.
}
```
- flutter에서는 내용이 변경 될 때마다 새 위젯 구성
- 그래서 외부에서 메소드 호출해서 값을 변경하기가 어렵다.
- MyCart.[updateWith](https://api.flutter.dev/flutter/semantics/SemanticsNode/updateWith.html)(somethingNew)(메소드 호출) 대신 ( MyCart(contents)생성자)를 사용합니다. (jquey 방식 -> react 방식)

> updateWith 메소드: config인수에 제공된 구성 과 인수에 나열된 자식 을 설명하도록이 개체의 속성을 재구성합니다. (화면 갱신?)

```dart
// GOOD
void myTapHandler(BuildContext context) {
  var cartModel = somehowGetMyCartModel(context); // 장바구니 상태
  cartModel.add(item);
}
```
```dart
// GOOD
Widget build(BuildContext context) {
  var cartModel = somehowGetMyCartModel(context);
  return SomeWidget(
    // 장바구니의 형태 상태를 사용해서 UI를 생성
  );
}
```

![](https://flutter.dev/assets/development/data-and-backend/state-mgmt/simple-widget-tree-with-cart-996ab650c5ec3ead51e8e731b6ba7c3b1c2a07c511b78b24be844dc71b5afb92.png)
- 장바구니 상태가 바뀌면 이전의 MyCart 위젯은 새로운 MyCart 위젯으로 대체
- immutable하다.


## 상태 접근
- 사용자가 카탈로그 항목 중 하나를 클릭하면 장바구니에 추가
- 간단한 선택지: MyListItem은 클릭 할 때 호출 할 수 있는 콜백을 제공

```dart
@override
 Widget build ( BuildContext context ) { return SomeWidget ( // 위 메소드에 대한 참조를 전달하여 위젯을 생성합니다. MyListItem ( myTapCallback ), ); } 

void myTapCallback ( Item item ) { 
  print ( '사용자가 $ item을 탭함 ' ); } 
```

- 잘 동작하지만, 여러 곳에서 수정해야하는 앱 상태의 경우 많은 콜백을 통과해야 한다.
- Flutter는 위젯이 하위레벨 (즉, 자식뿐만 아니라 그 아래의 위젯)에게 데이터와 서비스를 제공하는 메커니즘을 가지고 있습니다. 
  - 상태값을 상위레벨에서 갖고 있기 때문에..
- 이 메커니즘은 InheritedWidget, InheritedNotifier, InheritedModel(low level)에 의해 제공되고, 하위 레벨 위젯에서 작동하지만 사용하기 쉬운 패키지를 **provider** 제공

- scoped_model에는 3가지 컨셉이 있습니다.
  - ChangeNotifier
  - ChangeNotifierProvider
  - Consumer

## ChangeNotifier
- ChangeNotifierFlutter SDK에 포함 된 간단한 클래스로 리스너에게 변경 알림을 제공
- 무언가가 변경된 경우 ChangeNotifier해당 변경 사항을 구독 가능 (Observable의 한 형태)
- 간단한 앱일 경우 ChangeNotifier 사용, 복잡한 형태일 경우 ChangeNotifiers 사용

```dart
class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
```
- ChangeNotifier는 notifyListeners를 통해서만 전달된다.
- 앱의 UI를 변경할 수있는 방식으로 모델이 변경 될 때마다 이 메소드를 호출하십시오. 

- ChangeNotifier는 fleg:foundation의 일부분이며, 상위 레벨에 의존적이지 않다.
- CartModel의 간단한 단위 테스트: cart에서 상태변경을 감지 한 후에, add method 호출

```dart
test('adding item increases total cost', () {
  final cart = CartModel();
  final startingPrice = cart.totalPrice;
  cart.addListener(() {
    expect(cart.totalPrice, greaterThan(startingPrice));
  });
  cart.add(Item('Dash'));
});
```

## ChangeNotifierProvider
- ChangeNotifierProvider는 ChangeNotifier의 인스턴스를 하위 항목에 제공하는 위젯
- provider패키지 에서 제공
- MyCart와 MyCatalog의 상단에 있는 유일한 위젯은 MyApp

![](https://flutter.dev/assets/development/data-and-backend/state-mgmt/simple-widget-tree-with-cart-996ab650c5ec3ead51e8e731b6ba7c3b1c2a07c511b78b24be844dc71b5afb92.png)

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}
```
- ChangeNotifier의 인스턴스(CartModel)를 MyApp의 하위 항목에 제공 (store)

- 둘 이상의 클래스를 제공하려는 경우 MultiProvider 사용
```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => CartModel()),
        Provider(builder: (context) => SomeOtherClass()),
      ],
      child: MyApp(),
    ),
  );
}
```

## Consumer
- CartModel의 사용은, 소비자 위젯을 통해 수행된다.
```dart
return Consumer<CartModel>(
  builder: (context, cart, child) {
    return Text("Total price: ${cart.totalPrice}");
  },
);
```

- 접근하고자 하는 모델의 유형을 지정: Consumer <CartModel> -> 구독의 개념이므로 명확하게 명시
- 유일한 속성 Builder는 ChangeNotifier가 변경될 때마다 호출되는 함수 (즉, notifyListeners모델을 호출 하면, 모든 해당 Consumer 위젯의 모든 빌더 메소드를 호출)


- Builder: 빌더는 세 가지 인수로 호출
  - 첫번째는 컨텍스트인데, 모든 빌드 메소드에서 얻을 수 있다.
  - 두 번째 인수는 ChangeNotifier의 인스턴스(instance)이다. 우리가 처음에 요구한 것. 모델의 데이터를 사용하여 주어진 지점에서 UI의 모양을 정의할 수 있다.
  - 세 번째 논거는 최적화를 위해 존재하는 자식이다. 소비자 아래에 모델이 변경될 때 변경되지 않는 큰 위젯 하위 트리가 있는 경우, 한 번 구성하여 빌더를 통해 얻을 수 있다. (재사용)

```dart
return Consumer<CartModel>(
  builder: (context, cart, child) => Stack(
        children: [
          // Use SomeExpensiveWidget here, without rebuilding every time.
          child,
          Text("Total price: ${cart.totalPrice}"),
        ],
      ),
  // Build the expensive widget here.
  child: SomeExpensiveWidget(),
);
```

- 소비자 위젯을 가능한 한 변경될 트리에 가깝게 둬야한다. 세부 정보가 변경될때마다, 많은 UI를 갱신하는 것은 비효율

```dart
// DON'T DO THIS
return Consumer<CartModel>(
  builder: (context, cart, child) {
    return HumongousWidget(
      // ...
      child: AnotherMonstrousWidget(
        // ...
        child: Text('Total price: ${cart.totalPrice}'),
      ),
    );
  },
);
```

```dart
// DO THIS
return HumongousWidget(
  // ...
  child: AnotherMonstrousWidget(
    // ...
    child: Consumer<CartModel>(
      builder: (context, cart, child) {
        return Text('Total price: ${cart.totalPrice}');
      },
    ),
  ),
);
```

## Provider.of
- 때로는 UI를 변경하기 위해 모델의 데이터가 실제로 필요하지 않지만 여전히 UI에 액세스
  - ex) 예를 들어 ClearCart 버튼 클릭
- 수신 매개 변수를 false로 설정한 Provider.of를 사용하여, 재 빌드하도록 요청
```dart
Provider.of<CartModel>(context, listen: false).add(item);
```
- 빌드 방법에 위 코드를 사용하면 위젯 notifyListeners이 호출 될 때, 재빌드 되지 않는다.

## 별첨
- provider을 사용하려면, 의존성을 pubspec.yaml의 첫 번째에 추가

```dart
name: my_name
description: Blah blah blah.

# ...

dependencies:
  flutter:
    sdk: flutter

  provider: ^3.0.0

dev_dependencies:
  # ...
```

## 나의 결론
- 참고: [상태 관리 접근법 목록](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options)
- redux, rx, MobX, Hook을 쓰자~
- flutter redux를 사용할 [shopping cart](https://github.com/pszklarska/flutter_shopping_cart)