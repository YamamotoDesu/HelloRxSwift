import UIKit
import RxSwift

let disposeBag = DisposeBag()

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let obervable = Observable.combineLatest(left, right, resultSelector: {
    lastLeft, lastRight in
    "\(lastLeft) \(lastRight)"
})

let disposable = obervable.subscribe(onNext: { value in
    print(value)
})

left.onNext(45)
right.onNext(1)
left.onNext(30)
right.onNext(1)
right.onNext(2)
/**
 45 1
 30 1
 30 1
 30 2
 */
