//
//  LocationFetcher.swift
//  NamedThings
//
//  Created by Михаил Медведев on 30.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import CoreLocation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

	var map: MapWrapView?
	var lastKnownLocation: CLLocationCoordinate2D?

	override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
