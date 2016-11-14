//
//  GVSensorViewController.swift
//  GiottoDataViewer
//
//  Created by Brandon Schmuck on 11/5/16.
//  Copyright © 2016 Eiji Hayashi. All rights reserved.
//

import UIKit

class GVSensorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var devices = [GVDevice]()

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var devicesTableView: UITableView!
    
    var selectedDevice: GVDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);

        self.devicesTableView.delegate = self
        self.devicesTableView.dataSource = self
        loadDevices()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.devicesTableView.dequeueReusableCell(withIdentifier: "SensorCell") as! GVDeviceTableViewCell
        let device = devices[indexPath.row]
        cell.locationLabel.text = device.building
        
        let deviceParams = device.name.components(separatedBy: "_")
        
        
        if deviceParams.count > 4 {
            cell.sensorNameLabel.text = "SuperSensor \(deviceParams[1])"
            cell.sensorChannelLabel.text = "\(deviceParams[2]) - \(deviceParams[3]) - \(deviceParams[4])"
            cell.selectionStyle = .none;
            let deviceImage = "\(deviceParams[2])Icon"
            if let image = UIImage(named: deviceImage) {
                cell.deviceImage.image = image
            }
        } else {
            cell.sensorNameLabel.text = deviceParams[0]
            cell.selectionStyle = .none;
            let deviceImage = "\(device.type!)Icon"
            if let image = UIImage(named: deviceImage) {
                cell.deviceImage.image = image
            }
        }
        

        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDevices() {
        let bdManager = GVBuildingDepotManager.sharedInstance()
        let locationManager = GVLocationManager.sharedInstance()
        
        let locations = locationManager?.currentLocations()
        for location in locations! {
            let deviceArray = bdManager?.fetchSensors(withLocationTag: location as! String)
            self.devices.removeAll()
            for device in deviceArray! {
                self.devices.append(device as! GVDevice)
            }
        }
    }
    @IBAction func searchByUser(_ sender: AnyObject) {
        if let text = searchField.text {
            let bdManager = GVBuildingDepotManager.sharedInstance()
            let deviceArray = bdManager?.fetchSensors(withOwner: text)
            self.devices.removeAll()
            for device in deviceArray! {
                self.devices.append(device as! GVDevice)
            }
            self.devicesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDevice = self.devices[indexPath.row]
        self.performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GVDeviceViewController {
            vc.device = self.selectedDevice
        }
    }

    @IBAction func addNewDevice(_ sender: AnyObject) {
    }
    
    @IBAction func openSettings(_ sender: AnyObject) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
