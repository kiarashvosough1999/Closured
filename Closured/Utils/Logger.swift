//
//  Logger.swift
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

struct ClosuredLogger {
    
    static func selfDealocated(container: Any.Type) {
        #if DEBUG
        fatalError("""
              \(container) was dealocated, unable to execute closure
              """)
        #else
        print("""
              \(container) was dealocated, unable to execute closure
              """)
        #endif
    }
    
    static func closureFoundNil(container: Any.Type, closure: Any.Type) {
        #if DEBUG
        fatalError("""
              on \(type(of: container)), cannot execure closure of type \(type(of: closure)), as it was found nil
              """)
        #else
        print("""
              on \(type(of: container)), cannot execure closure of type \(type(of: closure)), as it was found nil
              """)
        #endif
    }
    
    static func argumentFoundNil(container: Any.Type, closure: Any.Type, args: [Any.Type]) {
        #if DEBUG
        fatalError("""
              on \(type(of: container)), cannot execure closure of type \(type(of: closure)), as its argument was found nil
              args: \(args)
              """)
        #else
        print("""
              on \(type(of: container)), cannot execure closure of type \(type(of: closure)), as its argument was found nil
              args: \(args)
              """)
        #endif
    }
    
    static func wrappedValueFoundNil(container: Any.Type, closure: Any.Type, values: [Any.Type]) {
        #if DEBUG
        fatalError("""
              on \(type(of: container)), cannot execure closure of type \(type(of: closure)), as its wrappedValue inside closure found nil, wrapped values: \(values)
              """)
        #else
        print("""
              on \(type(of: container)), cannot execure closure of type \(type(of: closure)), as its wrappedValue inside closure found nil, wrapped values: \(values)
              """)
        #endif
    }
    
    static func returnedValuesFoundNil(container: Any.Type, closure: Any.Type, values: [Any.Type]) {
        #if DEBUG
        fatalError("""
              on \(type(of: container)), cannot execure closure of type \(type(of: closure)), as its returned Value inside closure found nil, returned values: \(values)
              """)
        #else
        print("""
              on \(type(of: container)), cannot execure closure of type \(type(of: closure)), as its returned Value inside closure found nil, returned values: \(values)
              """)
        #endif
    }
}
