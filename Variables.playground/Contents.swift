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
