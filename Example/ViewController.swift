//
//  ViewController.swift
//  Example
//
//  Created by Kiarash Vosough on 9/26/1400 AP.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: ViewModel
    
    init() {
        self.viewModel = ViewModel()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBindings()
        viewModel.emit()
    }

    private func setBindings() {
        
        viewModel.$signalImAlive.byWrapping(self, view) { strongSelf, view in
            print("basic signal emmited")
        }
        
        viewModel.$signalNumber.byWrapping(self) { strongSelf, number in
            print(type(of: strongSelf))
            print(number)
        }
    }
}

