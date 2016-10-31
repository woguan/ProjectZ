
//
//  Bluetooth.swift
//
//  Created by Guan Wong on 4/13/16.
//  Copyright © 2016 Guan Wong. All rights reserved. asdf
//

import UIKit
import CoreBluetooth

// setting super global variable - Can be seen by every file
let serial = Bluetooth();

class Bluetooth: NSObject, CBCentralManagerDelegate{
    
    fileprivate var centralManager: CBCentralManager?
    fileprivate var peripheralBLE: CBPeripheral?
    
    
    
    override init() {
        super.init()
        
        let centralQueue = DispatchQueue(label: "com.diegowong", attributes: [])
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    // Use this function to scan for peripherals
    func startScanning() {
        if let central = centralManager {
            central.scanForPeripherals(withServices: [BLEServiceUUID], options: nil)
        }
        else{
            print("Something wrong happened. Error: V002 - Check Bluetooth.swift")
        }
    }
    
    var bleService: BTService? {
        didSet {
            if let service = self.bleService {
                service.startDiscoveringServices()
            }
        }
    }
    
    
    // new added
    func disconnect(){
        if let p = peripheralBLE{
            centralManager?.cancelPeripheralConnection(p)
        }
        else{
            print("Something wrong happened. Error: V001 - Check Bluetooth.swift")
        }
    }
    
    func stopScanning(){
        centralManager?.stopScan()
    }
    
    func isConnected() -> Bool{
        if let p = peripheralBLE{
            if (p.state == CBPeripheralState.disconnected){
                return false
            }
            else{
                if (p.name == DeviceName){
                return true
                }
            }
        }
        
        
        return false
    }
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Be sure to retain the peripheral or it will fail during connection.
        
        // Validate peripheral information
        if ((peripheral.name == nil) || (peripheral.name == "")) {
            return
        }
        
        // If not already connected to a peripheral, then connect to this one
        if ((self.peripheralBLE == nil) || (self.peripheralBLE?.state == CBPeripheralState.disconnected) || self.peripheralBLE?.identifier != MachineIdentifier) {
            // Retain the peripheral before trying to connect
            self.peripheralBLE = peripheral
            
            // Reset service
            self.bleService = nil
            
            // Connect to peripheral
            central.connect(peripheral, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        // Create new service class
        if (peripheral == self.peripheralBLE) {
            self.bleService = BTService(initWithPeripheral: peripheral)
        }
     
        // Stop scanning for new devices
        central.stopScan()
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        // See if it was our peripheral that disconnected
        if (peripheral == self.peripheralBLE) {
            self.bleService = nil;
            self.peripheralBLE = nil;
        }
        
        // Start scanning for new devices
       // self.startScanning()
    }
    
    // MARK: - Private
    
    func clearDevices() {
        self.bleService = nil
        self.peripheralBLE = nil
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch (central.state) {
        case CBCentralManagerState.poweredOff:
            self.clearDevices()
            
        case CBCentralManagerState.unauthorized:
            // Indicate to user that the iOS device does not support BLE.
            break
            
        case CBCentralManagerState.unknown:
            // Wait for another event
            break
            
        case CBCentralManagerState.poweredOn:
           // self.startScanning()
            break
        case CBCentralManagerState.resetting:
            self.clearDevices()
            
        case CBCentralManagerState.unsupported:
            break
        }
    }
    

    
}
