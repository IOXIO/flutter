## Platform Specific Code

### #. Overview

- Flutter에서 네이티브 기능과 통신하는 방법에 대해 알아본다.
- Java 또는 Kotlin 코드로 작성된 Android 플랫폼 API 호출
- Objective-C 또는 Swift 코드로 작성된 iOS 플랫폼 API 호출



### #. Architecture

![Platform Specific Code Architecture](https://flutter.dev/images/PlatformChannels.png)

- 핵심은 `MethodChannel`
- `MethodChannel` 을 통해 네이티브단의 메서드를 실행하고, 결과를 전달 받을 수 있다.



### #. Channel Data Types

| Dart                       | Android             | iOS                                            |
| -------------------------- | ------------------- | ---------------------------------------------- |
| null                       | null                | nil (NSNull when nested)                       |
| bool                       | java.lang.Boolean   | NSNumber numberWithBool:                       |
| int                        | java.lang.Integer   | NSNumber numberWithInt:                        |
| int, if 32 bits not enough | java.lang.Long      | NSNumber numberWithLong:                       |
| double                     | java.lang.Double    | NSNumber numberWithDouble:                     |
| String                     | java.lang.String    | NSString                                       |
| Uint8List                  | byte[]              | FlutterStandardTypedData typedDataWithBytes:   |
| Int32List                  | int[]               | FlutterStandardTypedData typedDataWithInt32:   |
| Int64List                  | long[]              | FlutterStandardTypedData typedDataWithInt64:   |
| Float64List                | double[]            | FlutterStandardTypedData typedDataWithFloat64: |
| List                       | java.util.ArrayList | NSArray                                        |
| Map                        | java.util.HashMap   | NSDictionary                                   |

