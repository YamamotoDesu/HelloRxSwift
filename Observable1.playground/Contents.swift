import RxSwift

let obervable = Observable.just(1)
let observale2 = Observable.of(1, 2, 3)
let observale3 = Observable.of([1,2,3])
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

observale3.subscribe { event in
    if let element = event.element {
        print(element)
        //> [1, 2, 3]
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


