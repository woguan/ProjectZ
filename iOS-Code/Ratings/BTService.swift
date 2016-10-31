//
//  BTService.swift
//
//  Created by Guan Wong on 4/13/16.
//  Copyright © 2016 Guan Wong. All rights reserved.
//

import Foundation
import CoreBluetooth

/* Services & Characteristics UUIDs */
let BLEServiceUUID = CBUUID(string: "FFE0")
let PositionCharUUID = CBUUID(string: "FFE1")
let BLEServiceChangedStatusNotification = "kBLEServiceChangedStatusNotification"
let MachineIdentifier = UUID(uuidString: "D031E051-158B-F550-BC0D-253B59224BD1")
let DeviceName:String = "sophie"


class BTService: NSObject, CBPeripheralDelegate {
    var peripheral: CBPeripheral?
    var positionCharacteristic: CBCharacteristic?
    
    init(initWithPeripheral peripheral: CBPeripheral) {
        super.init()
        
        self.peripheral = peripheral
        self.peripheral?.delegate = self
    }
    
    deinit {
        self.reset()
    }
    
    func startDiscoveringServices() {
        self.peripheral?.discoverServices([BLEServiceUUID])
    }
    
    func reset() {
        if peripheral != nil {
            peripheral = nil
        }
        
        // Deallocating therefore send notification
        self.sendBTServiceNotificationWithIsBluetoothConnected(false)
    }
    
    
    // Mark: - CBPeripheralDelegate
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        let uuidsForBTService: [CBUUID] = [PositionCharUUID]
        
        if (peripheral != self.peripheral) {
            // Wrong Peripheral
            return
        }
        
        if (error != nil) {
            return
        }
        
        if ((peripheral.services == nil) || (peripheral.services!.count == 0)) {
            // No Services
            return
        }
        
        for service in peripheral.services! {
            
            if service.uuid == BLEServiceUUID {
                peripheral.discoverCharacteristics(uuidsForBTService, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if (peripheral != self.peripheral) {
            // Wrong Peripheral
            return
        }
        
        if (error != nil) {
            return
        }
        
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == PositionCharUUID {
                    self.positionCharacteristic = (characteristic)
                    peripheral.setNotifyValue(true, for: characteristic)
                    // Send notification that Bluetooth is connected and all required characteristics are discovered
                    self.sendBTServiceNotificationWithIsBluetoothConnected(true)
                }
            }
        }
    }
    
    // Mark: - Private
    
    // send position
    func writePosition(_ position: UInt8) {
        // See if characteristic has been discovered before writing to it
        if let positionCharacteristic = self.positionCharacteristic {
            //print(positionCharacteristic.description)
            // Need a mutable var to pass to writeValue function
            var mutablePos = position
            let data = Data(bytes: UnsafePointer<UInt8>(&mutablePos), count: sizeof(UInt8))
            self.peripheral?.writeValue(data, for: positionCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
            
        }
    }
    
    // send string
    
    func sendMessageToDevice(_ message: String) {
     let customizeMSG = message + "\n"
            if let characteristic = positionCharacteristic {
                self.peripheral?.writeValue(customizeMSG.data(using: String.Encoding.utf8)!, for: characteristic, type: CBCharacteristicWriteType.withoutResponse)
                
            }

        
    }
    
    func sendBTServiceNotificationWithIsBluetoothConnected(_ isBluetoothConnected: Bool) {
        let connectionDetails = ["isConnected": isBluetoothConnected]
        NotificationCenter.default.post(name: Notification.Name(rawValue: BLEServiceChangedStatusNotification), object: self, userInfo: connectionDetails)
    }
    
}
