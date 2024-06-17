//
//  CheckVpnStatus.swift
//  VpnStatus
//
//  Created by FuturetekICT on 6/17/24.
//

import Foundation
import SystemConfiguration

class CheckVpnStatus {
    func isVPNConnected() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else {
            print("Failed to get proxy settings")
            return false
        }
        
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        print("Proxy settings: \(nsDict)")
        
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary else {
            print("No __SCOPED__ key found in proxy settings")
            return false
        }
        
        print("Scoped keys: \(keys.allKeys)")
        
        for key in keys.allKeys as! [String] {
            if key == "tap" || key == "tun" || key == "ppp" || key == "ipsec" || key == "ipsec0" || key.starts(with: "utun") {
                print("VPN is connected via \(key)")
                return true
            }
        }
        print("No VPN connection detected")
        return false
    }
}
