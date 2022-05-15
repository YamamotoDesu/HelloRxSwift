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
