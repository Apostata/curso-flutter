# Life cycles
![alt text](https://github.com/Apostata/curso-flutter/blob/master/lifecycles.png?raw=true)



## Constructor

This function is not part of the life cycle, because this time the State of the widget property is empty, if you want to access the widget properties in the constructor will not work. But the constructor must be to the first call.

## createState()
When Flutter is instructed to build a `StatefulWidget`, it immediately calls `createState()`

## initState()
Called when this object is inserted into the tree.

When inserting the render tree when invoked, this function is called only once in the life cycle. Here you can do some initialization, such as initialization State variables.

## setState()
The `setState()` method is called often from the Flutter framework itself and from the developer.

## didChangeDependencies()
Called when a dependency of this [State] object changes.

## didUpdateWidget()
Called whenever the widget configuration changes.

## deactivate()
Called when this object is removed from the tree. Before dispose, we will call this function.

## dispose()
Called when this object is removed from the tree permanently.

## didChangeAppLifecycleState()
Called when the system puts the app in the background or returns the app to the foreground.
Here is a good detail document: https://www.bookstack.cn/read/flutterbyexample/aebe8dda4df3319f.md