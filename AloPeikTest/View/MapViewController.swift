//
//  MapViewController.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
protocol mapViewControllerDelegate {
    func selectedlocation(product:ProductObject, selectedAddress:String, latitude:CLLocationDegrees , longitude:CLLocationDegrees)
}
class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    private var centerAnnotation:MKPointAnnotation!
    private var locationManager:CLLocationManager!
    private var selectedLocation:CLLocationCoordinate2D!
    private var markerView:UIImageView!
    private var currentAddress:String!
    private var isLocationDetermined:Bool!
    
    public var delegate:mapViewControllerDelegate!
    public var productObject:ProductObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialValues()
        self.initialViews()
        // Do any additional setup after loading the view.
    }
    
    
    private func initialViews(){
        //self.doneButton.isEnabled = false
        self.mapView.isZoomEnabled = true
    }
    
    
    private func initialValues(){
        self.selectedLocation = CLLocationCoordinate2D()
        self.mapView.delegate = self
        isLocationDetermined = false
        self.getCurrentLocation()
    }
    
    private func getCurrentLocation(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if self.locationManager.responds(to:#selector(self.locationManager.requestWhenInUseAuthorization)){
            self.locationManager.requestWhenInUseAuthorization()
        }else{
            self.locationManager.startUpdatingLocation()
        }
    }

    
    @IBAction func cancelSelectingLocation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func locationSelected(_ sender: UIButton) {
        self.delegate.selectedlocation(product: self.productObject, selectedAddress: currentAddress, latitude: selectedLocation.latitude, longitude: selectedLocation.longitude)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MapView Delegate
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.selectedLocation = self.mapView.centerCoordinate
        self.updateMarker()
        
    }
    
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.doneButton.isEnabled = false
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if (!isLocationDetermined){
            isLocationDetermined = true
            var mapRegion = MKCoordinateRegion()
            mapRegion.center = self.mapView.userLocation.coordinate
            mapRegion.span.latitudeDelta = 0.2
            mapRegion.span.longitudeDelta = 0.2
            self.mapView.setRegion(mapRegion, animated: true)
            self.selectedLocation.latitude = mapView.userLocation.coordinate.latitude
            self.selectedLocation.longitude = mapView.userLocation.coordinate.longitude
            self.addMarkerOnTheMap()
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    private func addMarkerOnTheMap(){
        markerView = UIImageView(image: UIImage(named: "Annotation"))
        self.view.addSubview(markerView)
        markerView.center = self.mapView.center
        selectedLocation = self.mapView.centerCoordinate
    }
    
    private func updateMarker(){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude)) { (placeMarks, error) in
            let placeMark:CLPlacemark = (placeMarks?[0])!
            self.currentAddress = {
                if((placeMark.locality) != nil){
                    return placeMark.locality! + placeMark.name!
                }else{
                    return placeMark.name
                }
            }()
            unowned let unownedSelf = self
            if ((unownedSelf.currentAddress) != nil){
                print (unownedSelf.currentAddress)
                self.addressLabel.text = unownedSelf.currentAddress
                self.doneButton.isEnabled = true
            }
        }
    }
    //Location Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,
             .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
            
        case .denied,
             .restricted:
            self.failureAlert()
        case .notDetermined:
            return
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors " + error.localizedDescription)
    }
    
    
    private func failureAlert(){
        let alert = UIAlertController(title: "Error", message: "Failed To Determine Your Location", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
}
