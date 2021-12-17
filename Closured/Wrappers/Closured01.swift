//
//  Closured01.swift
//  Closured
//
//  Created by Kiarash Vosough on 9/23/1400 AP.
//
//  Copyright 2020 KiarashVosough and other contributors
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

@propertyWrapper
final public class Closured01<T> {
    
    public typealias Closure = (() -> T?)
    
    public var wrappedValue: Closure?
    
    public var projectedValue: Closured01 { self }
    
    /// default queue for methods which does not accept Queue to perform closure on it
    private let queue: DispatchQueue
    
    public init(wrappedValue: Closure?, queue: DispatchQueue = .main) {
        self.wrappedValue = wrappedValue
        self.queue = queue
    }
    
    /// Perform closure synchronosly
    ///
    /// This method user the queue provided in init
    ///  - Throws: `ClosuredError`
    public func sync() throws -> T {
        return try queue.sync { [weak self] in
            guard let strongSelf = self else {
                ClosuredLogger.selfDealocated(container: Self.self)
                throw ClosuredError.selfDealocated(container: Self.self)
            }
            guard let wrappedValue = strongSelf.wrappedValue else {
                ClosuredLogger.closureFoundNil(container: Self.self, closure: Closure.self)
                throw ClosuredError.closureFoundNil(container: Self.self, closure: Closure.self)
            }
            guard let value = wrappedValue() else {
                ClosuredLogger.returnedValuesFoundNil(container: Self.self, closure: Closure.self, values: [T.self])
                throw ClosuredError.returnedValuesFoundNil(container: Self.self, closure: Closure.self, values: [T.self])
            }
            return value
        }
    }
    
    public func sync(on queue: DispatchQueue) throws -> T {
        return try queue.sync { [weak self] in
            guard let strongSelf = self else {
                ClosuredLogger.selfDealocated(container: Self.self)
                throw ClosuredError.selfDealocated(container: Self.self)
            }
            guard let wrappedValue = strongSelf.wrappedValue else {
                ClosuredLogger.closureFoundNil(container: Self.self, closure: Closure.self)
                throw ClosuredError.closureFoundNil(container: Self.self, closure: Closure.self)
            }
            guard let value = wrappedValue() else {
                ClosuredLogger.returnedValuesFoundNil(container: Self.self, closure: Closure.self, values: [T.self])
                throw ClosuredError.returnedValuesFoundNil(container: Self.self, closure: Closure.self, values: [T.self])
            }
            return value
        }
    }
    
    public func async(_ completed: @escaping (Result<T,Error>) -> Void) {
        queue.async { [weak self] in
            guard let strongSelf = self else {
                ClosuredLogger.selfDealocated(container: Self.self)
                completed(.failure(ClosuredError.selfDealocated(container: Self.self)))
                return
            }
            guard let wrappedValue = strongSelf.wrappedValue else {
                ClosuredLogger.closureFoundNil(container: Self.self, closure: Closure.self)
                completed(.failure(ClosuredError.closureFoundNil(container: Self.self, closure: Closure.self)))
                return
            }
            guard let value = wrappedValue() else {
                ClosuredLogger.returnedValuesFoundNil(container: Self.self, closure: Closure.self, values: [T.self])
                completed(.failure(ClosuredError.returnedValuesFoundNil(container: Self.self, closure: Closure.self, values: [T.self])))
                return
            }
            completed(.success(value))
        }
    }
    
    public func async(on queue: DispatchQueue,_ completed: @escaping (Result<T,Error>) -> Void) {
        queue.async { [weak self] in
            guard let strongSelf = self else {
                ClosuredLogger.selfDealocated(container: Self.self)
                completed(.failure(ClosuredError.selfDealocated(container: Self.self)))
                return
            }
            guard let wrappedValue = strongSelf.wrappedValue else {
                ClosuredLogger.closureFoundNil(container: Self.self, closure: Closure.self)
                completed(.failure(ClosuredError.closureFoundNil(container: Self.self, closure: Closure.self)))
                return
            }
            guard let value = wrappedValue() else {
                ClosuredLogger.returnedValuesFoundNil(container: Self.self, closure: Closure.self, values: [T.self])
                completed(.failure(ClosuredError.returnedValuesFoundNil(container: Self.self, closure: Closure.self, values: [T.self])))
                return
            }
            completed(.success(value))
        }
    }
    
    public func byWrapping<Wrraped>(_ wrapp: Wrraped,_ binding: @escaping ((Wrraped) -> T?)) where Wrraped: AnyObject {
        wrappedValue = { [weak wrapp] in
            guard let wrapp = wrapp else {
                ClosuredLogger.wrappedValueFoundNil(container: Self.self, closure: Self.Closure, values: [Wrraped.self])
                return nil
            }
            return binding(wrapp)
        }
    }
    
    public func byWrapping<Wrraped1,Wrraped2>(_ wrapp1: Wrraped1,_ wrapp2: Wrraped2 ,_ binding: @escaping ((Wrraped1, Wrraped2) -> T?)) where Wrraped1: AnyObject, Wrraped2: AnyObject {
        wrappedValue = { [weak wrapp1, weak wrapp2] in
            guard let wrapp1 = wrapp1, let wrapp2 = wrapp2 else {
                ClosuredLogger.wrappedValueFoundNil(container: Self.self, closure: Self.Closure, values: [Wrraped1.self,
                                                                                                             Wrraped2.self])
                return nil
            }
            return binding(wrapp1, wrapp2)
        }
    }
    
    public func byWrapping<Wrraped1,Wrraped2,Wrraped3>(_ wrapp1: Wrraped1,_ wrapp2: Wrraped2, _ wrapp3: Wrraped3,_ binding: @escaping ((Wrraped1, Wrraped2, Wrraped3) -> T?)) where Wrraped1: AnyObject, Wrraped2: AnyObject, Wrraped3: AnyObject {
        wrappedValue = { [weak wrapp1, weak wrapp2, weak wrapp3] in
            guard let wrapp1 = wrapp1, let wrapp2 = wrapp2, let wrapp3 = wrapp3 else {
                ClosuredLogger.wrappedValueFoundNil(container: Self.self, closure: Self.Closure, values:  [Wrraped1.self,
                                                                                                              Wrraped3.self,
                                                                                                              Wrraped2.self])
                return nil
            }
            return binding(wrapp1, wrapp2, wrapp3)
        }
    }
}
