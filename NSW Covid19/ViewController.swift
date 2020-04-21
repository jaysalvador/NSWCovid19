//
//  ViewController.swift
//  NSW Covid19
//
//  Created by Jay Salvador on 31/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import DataNSW

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let group = DispatchGroup()

        let client = PackageClient()
        
        var package: Package?

        group.enter()
        
        client?.getPackages { (response) in

            switch response {
            case .success(let result):

                print(result.packages?.count ?? 0)
                
                package = result.packages?.first { $0.name == Package.casesByLocationAndSource }

            case .failure(let error):

                print(error)
            }

            group.leave()
        }
        
        group.notify(queue: .main) {

            let patients = LocationClient()
            
            patients?.getPatients(id: package?.id, offset: nil) { (response) in
                
                switch response {
                case .success(let result):
                    
                    print(result.locations?.count ?? 0)
                    
                case .failure(let error):
                    
                    print(error)
                }
                
            }
        }
    }

}
