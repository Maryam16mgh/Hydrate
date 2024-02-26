//
//  IosAppModel.swift
//  Hydrate
//
//  Created by Maryam Mohammad on 11/08/1445 AH.
//

import Foundation
import WatchConnectivity



class SessionDelegate: NSObject, ObservableObject, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
       
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }

   

}
