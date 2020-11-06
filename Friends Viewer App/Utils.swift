//
//  Utils.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/6/20.
//

import Foundation

typealias Operation<T, U> = ((T, ((U) -> Void)?) -> Void)?

func mergeOperations<T, U, V>(_ lhs: Operation<T, U>, _ rhs: Operation<U, V>) -> Operation<T, V> {
    { (input, completion) in
        lhs?(input) { output in
            rhs?(output, completion)
        }
    }
}

infix operator >>>>: LogicalConjunctionPrecedence

func >>>><T, U, V>(lhs: Operation<T, U>, rhs: Operation<U, V>) -> Operation<T, V> {
    mergeOperations(lhs, rhs)
}
