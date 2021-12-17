//
//  ViewModel.swift
//  Example
//
//  Created by Kiarash Vosough on 9/26/1400 AP.
//

import Foundation
import Closured

final class ViewModel {
    
    typealias BasicSignal = () -> Void
    
    typealias NumberSignal = (Int) -> Void
    
    
    @Closured(queue: .global(qos: .background)) var signalImAlive: BasicSignal?
    
    // default queue is main
    @Closured10 var signalNumber: NumberSignal?
    
    func emit() {
        
        // MARK: -  old style
        signalImAlive?()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.signalImAlive?()
        }
        
        
        // MARK: -  with Closured
        
        // perform signal on global queue async with qos of background
        $signalImAlive.async()
        
        do {
            // perform signal on global queue sync with qos of background
            try $signalImAlive.sync()
        } catch  {}
        
        
        // perform signal on main queue async
        $signalNumber.async(90)
        
        // perform signal on main queue async
        $signalNumber.async(70)
        
        do {
            // perform signal on global queue sync with qos of utility
            try $signalNumber.sync(on: .global(qos: .utility), 30)
            
        } catch  {}
    }
}
