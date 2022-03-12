# [HelloRxSwift](https://github.com/YamamotoDesu/Yamamoto-Notes/wiki/RxSwift-Topics)
The heart of the RxSwift framework is based on observable which is also known as a sequence.  


## ■ Observable
Observable is the sequence of data or events which can be subscribed and can be extended by applying different Rx operators like map, filter, flatMap, etc.  
It can receive data asynchronously.  

### 1. `just` is an observable sequence containing the single specified element.

```swift
import RxSwift

let obervable = Observable.just(1)

```
### 2. `of` operator is used to create an observables array or an observable of individual type.
```swift
import RxSwift
let observale2 = Observable.of(1, 2, 3)
let observale3 = Observable.of([1,2,3])

observale3.subscribe { event in
    if let element = event.element {
        print(element)
        //> [1, 2, 3]
    }
}

```

```swift
import RxSwift

let disposeBag = DisposeBag()

Observable.of("A", "B", "C")
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)
// > next(A)
// > next(B)
// > next(C)
// > completed

Observable<String>.create { observer in
    
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")
    
    return Disposables.create()
}.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: { print("Completed") }, onDisposed: { print("Disposed") })
    .disposed(by: disposeBag)
              // > A
              // > Completed
              // > Disposed

```

## 3. `from` operator creates an observable of individual type from an array of elements.

```swift
import RxSwift
let observable4 = Observable.from([1, 2, 3, 4, 5])

observable4.subscribe { event in
    if let element = event.element {
        print(element)
        //> 1
        //> 2
        //> 3
        //> 4
        //> 5
    }
}

let subscription4 = observable4.subscribe(onNext: { element in
    print(element)
    //> 1
    //> 2
    //> 3
    //> 4
    //> 5
})

subscription4.dispose()

```

### The Subscribe is how you connect an observer to an Observable.
We have created observables but we need to subscribe to the observables.   
An observable won’t send events until it has a subscriber.  
`onNext` This method is called whenever the Observable emits an item. 
This method takes as a parameter the item emitted by the Observable. When a value is added to an observable it will send the next event to its subscribers.

`onError` This method is called whenever an error event is emitted indicating that it has failed to generate the expected data or has encountered some other error. Further calls to onNext or onCompletedare not made. The method returns the details of the error. This will terminate the observable sequence.

`onCompleted` This method after observable has emitted all the events and sends a completed event to its subscribers. This method is not called if any error event has encountered.

-----

## ■ PublishSubject
```swift
import RxSwift

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
subject.onNext("Issue 1")
subject.subscribe { event in
    print(event)
    // > next(Issue 2)
    // > next(Issue 3)
}

subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.dispose()

subject.onCompleted()

subject.onNext("Issue 4")
```

-----

## ■ BehaviorSubject
```swift
import RxSwift

let disposeBag = DisposeBag()

let subject = BehaviorSubject(value: "Initial Value")

subject.onNext("Last Issue")

subject.subscribe { event in
    print(event)
    // > next(Last Issue)
    // > next(Issue 1)
}

subject.onNext("Issue 1")
```

-----
## ■ ReplaySubject
```swift
import RxSwift

let disposeBag = DisposeBag()

let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.subscribe {
    print($0)
    // > next(Issue 2)
    // > next(Issue 3)
}

subject.onNext("Issue 4")
subject.onNext("Issue 5")
subject.onNext("Issue 6")

print("[Subscription 2]")
subject.subscribe {
    print($0)
    // > next(Issue 5)
    // > next(Issue 6)
}
```
-----

## ■ Variable(OLD)
```swift
import RxSwift

let disposeBag = DisposeBag()

let variable = Variable("Initial value")

variable.value = "Hello World"

variable.asObservable()
    .subscribe {
        print($0)
        // > next(Hello World)
    }


let variable2 = Variable([String]())

variable2.value.append("Item 1")

variable2.asObservable()
    .subscribe {
        print($0)
        // > next(["Item 1"])
        // > next(["Item 1", "Item 2"])
    }

variable2.value.append("Item 2")
```

-----
## ■ BehaviorRelay
```swift
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: ["Item 1"])

relay.accept(["Item 2"])

relay.asObservable()
    .subscribe {
        print($0)
        // > next(["Item 2"])
    }

let relay2 = BehaviorRelay(value: ["Item 1"])

relay2.accept(relay2.value + ["Item 2"])

relay2.asObservable()
    .subscribe {
        print($0)
        // > next(["Item 1", "Item 2"])
    }

let relay3 = BehaviorRelay(value: ["Item 1"])

var value = relay3.value
value.append("Item 2")
value.append("Item 3")

relay3.accept(value)


relay3.asObservable()
    .subscribe {
        print($0)
        // > next(["Item 1", "Item 2", "Item 3"])
    }
```
