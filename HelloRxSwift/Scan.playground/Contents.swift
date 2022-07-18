import UIKit
import RxSwift

let disposeBag = DisposeBag()

let source = Observable.of(1,2,3,5,6)

source.scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
        /*
         1
         3
         6
         11
         17
         */
    }).disposed(by: disposeBag)
