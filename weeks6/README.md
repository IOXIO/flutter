# Coolbook 일부 파트

- Form
- List
- Networking

---

## Form

### # Build a form with validation

- 복수의 폼 필드를 그룹화 하고 적합성을 확인함.
- 텍스트를 입력 할 방법이 없다. ???
- TextFormField - validator() 이용
    - 오류 메시지 String 으로 반환
    - 오류가 없으면 null 반환

### # Create and style a text field

- TextField
    - 밑줄을 가진 가장 일반적인 입력 위젯
- TextFormField
    - 다른 FormField 위젯과의 유효성 검증 및 통합

### # Focus and text fields

- autofocus
    - 화면에 보여지는 즉시 포커스 - true
- 포커스 이동
    - [포커스 이동보러 이동](https://flutter.dev/docs/cookbook/forms/focus)

### # Handle changes to a text field

- onChanged() 호출

```dart
TextField(
  onChanged: (text) {
    print("First text field: $text");
  },
);
```

-  TextEditingController 사용
    - [TextEditingController 보러가시죠](https://flutter.dev/docs/cookbook/forms/text-field-changes)

### # Retrieve the value of a text field
- [위와 거의 동일](https://flutter.dev/docs/cookbook/forms/retrieve-input)

---

## List

### # Create a grid list

- 열이 있는 List
- 가장 간단한 방법은 GridView.count() 사용
- [GridView](https://flutter.dev/docs/cookbook/lists/grid-lists)

### # Create a horizontal list

- 기본은 Vertical
- scrollDirection: Axis.horizontal
- 기본 ListView는 스크롤이 있는 Column(Row)와 비슷하다.
- [Horizontal list](https://flutter.dev/docs/cookbook/lists/horizontal-list)

### # Create lists with different types of items

- 다른 유형의 아이템 만들기
- ListView.builder() 생성자 사용
    - 한번에 다 생성하는 ListView와 달리 항목이 보여질때 생성
- [different types item](https://flutter.dev/docs/cookbook/lists/mixed-list)

### # Place a floating app bar above a list

- 기존의 Scaffold Appbar는 사용하지 않는다.
- CustomScrollView 사용
    - 스크롤 가능한 위젯과 다른 위젯을 혼합 시킬수 있는 것으로 생각?
    - 제공되는 List 및 Widget 을 Sliver라고 부름
    - SliverList, SliverGridList, SliverAppBar
- [보러가자](https://flutter.dev/docs/cookbook/lists/floating-app-bar)

### # Use lists

- 기본 목록 작업
- Cookbook list 메뉴 순서에서 왜 첫번째에 없는지 의문...
- [List](https://flutter.dev/docs/cookbook/lists/basic-list)

### # Work with long lists

- 이미 위에서 설명
- [그래도 보러가자](https://flutter.dev/docs/cookbook/lists/long-lists)

---

## Networking

### # Fetch data from the internet

- http 패키지 사용
- [보면서 하시죠](https://flutter.dev/docs/cookbook/networking/fetch-data)

### # Make authenticated requests

- header 추가
```dart
Future<http.Response> fetchPost() {
  return http.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    // Send authorization headers to the backend.
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
}
```

### # Parse JSON in the background

- Json을 변환할 때 백그라운드로 옮겨 실행

```dart
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/photos');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}
```

- compute 의 message 값은 원시값 또는 단순객체 가능
- Future또는 http.Response 같은 복잡한 객체는 에러