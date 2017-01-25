
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
    
    // hi diego
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
        
        if #available(iOS 10.0, *)
        {
            switch (central.state) {
                
            case CBManagerState.poweredOff:
                self.clearDevices()
                
            case CBManagerState.unauthorized:
                // Indicate to user that the iOS device does not support BLE.
               
                break
                
            case CBManagerState.unknown:
                // Wait for another event
              
                break
                
            case CBManagerState.poweredOn:
                
                
              //  self.centralManager!.scanForPeripheralsWithServices([CBUUID(string:TRANSFER_UUID)], options:[CBCentralManagerScanOptionAllowDuplicatesKey: false])
                break
            case CBManagerState.resetting:
                self.clearDevices()
                
            case CBManagerState.unsupported:
                
                break
            }
        }
        else
        {
            
            switch central.state.rawValue
            {
            case 0: // CBCentralManagerState.Unknown
            
                break
                
            case 1: // CBCentralManagerState.Resetting
                self.clearDevices()
                
                
            case 2:// CBCentralManagerState.Unsupported
           
                break
                
            case 3: // CBCentralManagerState.unauthorized
        
                break
                
            case 4: // CBCentralManagerState.poweredOff:
                self.clearDevices()
                
            case 5: //CBCentralManagerState.poweredOn:
         //       self.centralManager!.scanForPeripheralsWithServices([CBUUID(string:TRANSFER_UUID)], options:[CBCentralManagerScanOptionAllowDuplicatesKey: false])
                break
                
            default:break
            }
            
        }
        
        
    }
    

    
}
