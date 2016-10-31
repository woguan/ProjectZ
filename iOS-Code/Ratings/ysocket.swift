//
//  ysocket.swift
//  arduinoWifiTest
//
//  Created by Guan Wong on 5/19/16.
//  Copyright © 2016 Guan Wong. All rights reserved.
//

import Foundation
open class YSocket{
    var addr:String
    var port:Int
    var fd:Int32?
    var connected:Bool?
    
    init(){
        self.addr=""
        self.port=0
        self.connected = false
    }
    public init(addr a:String,port p:Int){
        self.addr=a
        self.port=p
        self.connected = false
    }
    func isConnected() -> Bool{
        return self.connected!
    }
}
