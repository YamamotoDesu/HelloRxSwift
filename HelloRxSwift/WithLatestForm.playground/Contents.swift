import UIKit
import RxSwift

let disposeBag = DisposeBag()

let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let obervable = button.withLatestFrom(textField)
let disposable = obervable.subscribe(onNext: {
    print($0)
})

textField.onNext("Sw")
textField.onNext("Swif")
textField.onNext("Swift")

button.onNext(())
button.onNext(())
/**
 Swift
 Swift
 */
