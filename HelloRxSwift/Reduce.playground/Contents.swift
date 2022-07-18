import UIKit
import RxSwift

let disposeBag = DisposeBag()

let source = Observable.of(1,2,3)
source.reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
        // 6
    }).disposed(by: disposeBag)

source.reduce(0, accumulator: {
    summary, newValue in
    return summary + newValue
}).subscribe(onNext: {
    print($0)
    // 6
}).disposed(by: disposeBag)
