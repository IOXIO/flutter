
[Flutter Layout](https://flutter.dev/docs/development/ui/layout)

[Flutter Layout Tutorials](https://flutter.dev/docs/development/ui/layout/tutorial)

[Flutter Adding Interactivity](https://flutter.dev/docs/development/ui/interactive)

## Layouts

- **Widget** (POINT)
  - UI 구성하는 클래스
  - layout and UI elements

![1](https://flutter.dev/assets/ui/layout/lakes-icons-visual-f9e45691d76ba85d4ea2160941f42c8a2ce1a17d41d6e6aac8f3feb89e679f99.png)

![2](https://flutter.dev/assets/ui/layout/sample-flutter-layout-46c76f6ab08f94fa4204469dbcf6548a968052af102ae5a1ae3c78bc24e0d915.png)

- Container
  -  to customize its child widget
  -  패딩, 마진, 보더, background color 등 기능을 추가

  ## lay out a widget (?)

1. layout widget 선택
2. visible widget 생성
3. visible widget을 layout widget에 추가
4. layout widget을 페이지에 추가

- Material apps

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
```

- Non-Material apps

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Text(
          'Hello World',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
```

## lay out multiple widgets vertically and horizontally

- Row 

- Coulum

![](https://flutter.dev/assets/ui/layout/pavlova-left-column-diagram-c9bf1a39b39270615ce8e82608952ac3edaa0d1eab8691f8783e6408fdfbdfb3.png)

- 정렬

  - MainAxisAlignment
  - CrossAxisAlignment

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```
 
- Sizing
  - Expanded : 화면에 사이즈 맞춤
    - flex : 특정 widget 비율

```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: Image.asset('images/pic1.jpg'),
    ),
    Expanded(
      flex: 2,
      child: Image.asset('images/pic2.jpg'),
    ),
    Expanded(
      child: Image.asset('images/pic3.jpg'),
    ),
  ],
);
```


- Packing widgets

```dart
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.black),
    Icon(Icons.star, color: Colors.black),
  ],
)
```

- Nesting rows and columns

![Nesting rows and columns](https://flutter.dev/assets/ui/layout/widget-tree-pavlova-rating-row-7555ca5c12948715086787af2783d2e489e44117928b798f4c5d05bb8bec5119.png)

```dart
var stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.black),
    Icon(Icons.star, color: Colors.black),
  ],
);

final ratings = Container(
  padding: EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      stars,
      Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
    ],
  ),
);
```


### Common layout widgets

- Container

  - Add paiing, margins, borders
  - Change background color or image
  - Contains a single child widget

```dart
Widget _buildImageColumn() => Container(
      decoration: BoxDecoration(
        color: Colors.black26,
      ),
      child: Column(
        children: [
          _buildImageRow(1),
          _buildImageRow(3),
        ],
      ),
    );

Widget _buildDecoratedImage(int imageIndex) => Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4),
        child: Image.asset('images/pic$imageIndex.jpg'),
      ),
    );

Widget _buildImageRow(int imageIndex) => Row(
      children: [
        _buildDecoratedImage(imageIndex),
        _buildDecoratedImage(imageIndex + 1),
      ],
    );
```

- GridView

  - Grid 형태로 위젯 배치
  - 열 내용의 초과를 감지 하고 스크롤 재공
  - GridView.count :  컬럼수
  - GridView.extent :  타일의 최대 넓이

```dart
Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(30));

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
List<Container> _buildGridTileList(int count) => List.generate(
    count, (i) => Container(child: Image.asset('images/pic$i.jpg')));
```

- ListView
  - 목록을 위한 특수 Column
  - 수직/수평 배치 가능
  - 스크롤 제공
  - Column보다 쉽지만 구성의 한계

```dart
Widget _buildList() => ListView(
      children: [
        _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
        _tile('The Castro Theater', '429 Castro St', Icons.theaters),
        _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
        _tile('Roxie Theater', '3117 16th St', Icons.theaters),
        _tile('United Artists Stonestown Twin', '501 Buckingham Way',
            Icons.theaters),
        _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
        Divider(),
        _tile('Kescaped_code#39;s Kitchen', '757 Monterey Blvd', Icons.restaurant),
        _tile('Emmyescaped_code#39;s Restaurant', '1923 Ocean Ave', Icons.restaurant),
        _tile(
            'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
        _tile('La Ciccia', '291 30th St', Icons.restaurant),
      ],
    );

ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
```

- Stack

  - 다른위젯과 겹칠때 사용
  - 첫번째 위젯이 기본 위젯, 그 이후 기본 위젯 위에 겹쳐짐
  - 스크롤 안됨
  - 랜더링 영역 벗어났을때 clip 가능

```dart
Widget _buildStack() => Stack(
    alignment: const Alignment(0.6, 0.6),
    children: [
      CircleAvatar(
        backgroundImage: AssetImage('images/pic.jpg'),
        radius: 100,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.black45,
        ),
        child: Text(
          'Mia B',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
```

- Card
  - Material card 구현
  - 정보 덩어리 보여줄 때 사용
  - 단일 자녀 허용
  - rounded corners, drop shadow
  - 스크롤안됨
  - Material library에 포함

```dart
Widget _buildCard() => SizedBox(
    height: 210,
    child: Card(
      child: Column(
        children: [
          ListTile(
            title: Text('1625 Main Street',
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('My City, CA 99984'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('(408) 555-1212',
                style: TextStyle(fontWeight: FontWeight.w500)),
            leading: Icon(
              Icons.contact_phone,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: Text('costa@example.com'),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    ),
  );
```

- ListTile
  - 최대 3줄의 텍스트, 아이콘(옵션)이 포함된 행
  - Row보다 쉽지만 구성의 한계
  - Material library에 포함



## Tutorial

```
- Flutter의 레이아웃 메커니즘 작동 방식
- 위젯을 수직 및 수평으로 배치하는 방법
- Flutter 레이아웃을 구축하는 방법
```

- Step 1 : Diagram the layout
  - rows, columns 확인
  - grid 확인
  - 겹치는 레이아웃 확인
  - 탭 확인
  - 정렬, 패딩, 보더 필요 영역 확인

  ![](https://flutter.dev/assets/ui/layout/lakes-column-elts-b1f1ec8c2cc0cc667f3935dd665a27b2d15171c8466dc5b893e98b88b265414c.png)

  ![](https://flutter.dev/assets/ui/layout/title-section-parts-91480d296e122c9cf2994439b82da0c43df795c1085ec6efb9a916da371248c5.png)

  ![](https://flutter.dev/assets/ui/layout/button-section-diagram-3dac85a884b67876ce7b39e4f0bd43b93886c8f61d25055ad2d0971adb16907c.png)



- Step 2 : Implement the title row
- Step 3 : Implement the button row
- Step 4 : Implement the text section
- Step 5 : Implement the image section

*Sample : main.dart*



## Adding interactivity to your Flutter app

```
- Tab
- custom widget
- stateless widgets, stateful widgets
```

- StatelessWidget
  - 상태가 변하지 않음
  - StatelessWidget 상송
  - Icon, IconButton, Text
- StatefulWidget
  - 상태가 변함
  - StatefulWidget을 상속
  - Checkbox, Radio, Slider, InkWell, Form, TextField

### Stateful widget

- StatefulWidget의 서브 클래스와 State의 서브 클래스의 두 클래스로 구현됩니다.
- 위젯의 상태는 State 에 저장된다.
- 상태 클래스에는 위젯의 변경 가능한 상태와 위젯의 build () 메소드가 포함됩니다.
- 위젯의 상태가 변경되면 상태 객체는 setState ()를 호출하여 프레임 워크에 위젯을 다시 그리도록 지시합니다.

*Sample : main2.dart*


### Managing state

```
- 상태를 관리하는 방법에는 여러 가지가 있습니다.
- 위젯 디자이너로서 사용할 접근 방식을 선택하십시오.
- 의심스러운 경우 상위 위젯에서 상태를 관리하여 시작하십시오.
```

- 위젯이 상태 관리
  - setState() 호출하여 update UI
  
- 위젯 부모가 상태 관리
  - StatelessWidget 을 확장, 부모에서 상태 관리
  - 탭이 감지되면 부모에게 전달
  - 부모가 setState
- 위젯, 부모 관리
  - 상태를 stateful widget, Parent 에서 관리

- *Sample : main3.dart* 