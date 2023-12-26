//
//  ProofDailyWorkViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 29/09/2023.
//

import Foundation
import Combine
//enum TimeoutError: Error{
//  case timedOut
//}

final class ProofDailyWorkViewModel:ObservableObject {

    init(){
//  timedOutSubject()
//        subject.send()
    }

    let subject = PassthroughSubject<Void, Never>()
    // 1
    func  timedOutSubject() {

        // 2
        let debounced = subject
          .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
          // 3
          .share()
//        let timedOutSubject = subject
//            .timeout(.seconds(10), scheduler: DispatchQueue.main,customError:nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 20 + 1.5) { [unowned self] in
          subject.send(completion: .finished)
        }

        let subscription1 = subject
          .sink { string in
            print("+\(deltaTime)s: Subject emitted: \(string)")
          }
        let subscription2 = debounced
          .sink { string in
            print("+\(deltaTime)s: Debounced emitted: \(string)")
          }
    }
}
public extension Subject where Output == String {
  /// A function that can feed delayed values to a subject for testing and simulation purposes
  func feed(with data: [(TimeInterval, String)]) {
    var lastDelay: TimeInterval = 0
    for entry in data {
      lastDelay = entry.0
      DispatchQueue.main.asyncAfter(deadline: .now() + entry.0) { [unowned self] in
        self.send(entry.1)
      }
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + lastDelay + 1.5) { [unowned self] in
      self.send(completion: .finished)
    }
  }
}
let start = Date()
let deltaFormatter: NumberFormatter = {
  let f = NumberFormatter()
  f.negativePrefix = ""
  f.minimumFractionDigits = 1
  f.maximumFractionDigits = 1
  return f
}()

/// A simple delta time formatter suitable for use in playground pages: start date is initialized every time the page starts running
public var deltaTime: String {
  return deltaFormatter.string(for: Date().timeIntervalSince(start))!
}
