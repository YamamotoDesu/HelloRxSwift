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
