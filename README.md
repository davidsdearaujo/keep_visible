Keep your widget visible when the keyboard appears.

In [this example](https://github.com/davidsdearaujo/keep_visible/blob/master/example/lib/main.dart) the footer is always visible:

<img width="250" src="https://user-images.githubusercontent.com/16373553/234002467-d3db4db6-5ee4-4243-8702-d92a7da4b180.gif"/>


## Usage

Import:
```dart
import 'package:keep_visible/keep_visible.dart';
```

Wrap the widget you want to keep visible with a `KeepVisible` widget:

```dart
KeepVisible(
  child: Text('Login Button'),
),
```
