# HelloRxSwift
The heart of the RxSwift framework is based on observable which is also known as a sequence.  
Observable is the sequence of data or events which can be subscribed and can be extended by applying different Rx operators like map, filter, flatMap, etc.  
It can receive data asynchronously.  
You can create an observable sequence of any Object that conforms to the Sequence protocol (A type that provides sequential, iterated access to its elements).  

## ■ Observable
### 1. "just" is an observable sequence containing the single specified element.

```swift
import RxSwift

let obervable = Observable.just(1)

```
### 2. "of" operator is used to create an observables array or an observable of individual type.
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

## 3. "from" operator creates an observable of individual type from an array of elements.

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
