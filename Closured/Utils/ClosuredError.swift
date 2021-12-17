//
//  CocoClosureError.swift
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

public enum ClosuredError: Error {
    
    /// Error which indicate that the captured self was deallocated.
    ///
    /// Performing closure is not possible on this state.
    case selfDealocated(container: Any.Type)
    
    /// Error which indicate that the closure was not binded and founded nil.
    ///
    /// Performing closure is not possible on this state.
    case closureFoundNil(container: Any.Type, closure: Any.Type)
    
    case argumentFoundNil(container: Any.Type, closure: Any.Type, args: [Any.Type])
    
    /// Error which indicate that  one of the captured  values on binding was deallocated.
    ///
    /// Performing closure is not possible on this state.
    case wrappedValueFoundNil(container: Any.Type, closure: Any.Type, values: [Any.Type])
    
    /// Error which indicate that returned value from performing closure was nil.
    ///
    /// Performing closure is not possible on this state.
    case returnedValuesFoundNil(container: Any.Type, closure: Any.Type, values: [Any.Type])
}
