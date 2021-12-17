//
//  Closured.swift
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
final public class Closured {
    
    public typealias Closure = (()->())
    
    public var wrappedValue: Closure?
    
    public var projectedValue: Closured { self }
    
    /// default queue for methods which does not accept Queue to perform closure on it
    private let queue: DispatchQueue
    
    public init(queue: DispatchQueue = .main, wrappedValue: Closure? = nil) {
        self.wrappedValue = wrappedValue
        self.queue = queue
    }
    
    /// Perform closure synchronosly
    ///
    /// This method user the queue provided in init
    ///  - Throws: `ClosuredError`
    public func sync() throws {
        try queue.sync { [weak self] in
            guard let strongSelf = self else {
                ClosuredLogger.selfDealocated(container: Self.self)
                throw ClosuredError.selfDealocated(container: Self.self)
            }
            guard let wrappedValue = strongSelf.wrappedValue else {
                ClosuredLogger.closureFoundNil(container: Self.self, closure: Closure.self)
                throw ClosuredError.closureFoundNil(container: Self.self, closure: Closure.self)
            }
            wrappedValue()
        }
    }
    
    /// Perform closure synchronosly with provided queue as its arguement
    ///  - Throws: `ClosuredError`
    public func sync(on queue: DispatchQueue) throws {
        try queue.sync { [weak self] in
            guard let strongSelf = self else {
                ClosuredLogger.selfDealocated(container: Self.self)
                throw ClosuredError.selfDealocated(container: Self.self)
            }
            guard let wrappedValue = strongSelf.wrappedValue else {
                ClosuredLogger.closureFoundNil(container: Self.self, closure: Closure.self)
                throw ClosuredError.closureFoundNil(container: Self.self, closure: Closure.self)
            }
            wrappedValue()
        }
    }
    
    /// Perform closure asynchronosly with provided queue as its arguement
    public func async(on queue: DispatchQueue) {
        queue.async { [weak self] in
            guard let strongSelf = self else {
                ClosuredLogger.selfDealocated(container: Self.self)
                return
            }
            guard let wrappedValue = strongSelf.wrappedValue else {
                ClosuredLogger.closureFoundNil(container: Self.self, closure: Closure.self)
                return
            }
            wrappedValue()
        }
    }
    
    /// Perform closure asynchronosly
    ///
    /// This method user the queue provided in init
    public func async() {
        queue.async { [weak self] in
            guard let strongSelf = self else {
                ClosuredLogger.selfDealocated(container: Self.self)
                return
            }
            guard let wrappedValue = strongSelf.wrappedValue else {
                ClosuredLogger.closureFoundNil(container: Self.self, closure: Closure.self)
                return
            }
            wrappedValue()
        }
    }
    
    /// Bind closure
    public func bind(_ binding: @escaping () -> Void) {
        wrappedValue = {
            binding()
        }
    }
    
    /// Bind closure by wrapping one reference value  inside
    public func bindByWrapping<Wrraped>(_ wrapp: Wrraped,_ binding: @escaping ((Wrraped) -> Void)) where Wrraped: AnyObject {
        wrappedValue = { [weak wrapp] in
            guard let wrapp = wrapp else {
                ClosuredLogger.wrappedValueFoundNil(container: Self.self, closure: Self.Closure, values: [Wrraped.self])
                return
            }
            binding(wrapp)
        }
    }
    
    /// Bind closure by wrapping two reference value  inside
    public func bindByWrapping<Wrraped1,Wrraped2>(_ wrapp1: Wrraped1,_ wrapp2: Wrraped2 ,_ binding: @escaping ((Wrraped1, Wrraped2) -> Void)) where Wrraped1: AnyObject, Wrraped2: AnyObject {
        wrappedValue = { [weak wrapp1, weak wrapp2] in
            guard let wrapp1 = wrapp1, let wrapp2 = wrapp2 else {
                ClosuredLogger.wrappedValueFoundNil(container: Self.self, closure: Self.Closure, values: [Wrraped1.self,
                                                                                                             Wrraped2.self])
                return
            }
            binding(wrapp1, wrapp2)
        }
    }
    
    /// Bind closure by wrapping three reference value  inside
    public func bindByWrapping<Wrraped1,Wrraped2,Wrraped3>(_ wrapp1: Wrraped1,_ wrapp2: Wrraped2, _ wrapp3: Wrraped3,_ binding: @escaping ((Wrraped1, Wrraped2, Wrraped3) -> Void)) where Wrraped1: AnyObject, Wrraped2: AnyObject, Wrraped3: AnyObject {
        wrappedValue = { [weak wrapp1, weak wrapp2, weak wrapp3] in
            guard let wrapp1 = wrapp1, let wrapp2 = wrapp2, let wrapp3 = wrapp3 else {
                ClosuredLogger.wrappedValueFoundNil(container: Self.self, closure: Self.Closure, values:  [Wrraped1.self,
                                                                                                              Wrraped3.self,
                                                                                                              Wrraped2.self])
                return
            }
            binding(wrapp1, wrapp2, wrapp3)
        }
    }
}
