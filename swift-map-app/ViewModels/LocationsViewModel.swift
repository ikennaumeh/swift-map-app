//
//  LocationsViewModel.swift
//  swift-map-app
//
//  Created by Ikenna Umeh on 04/12/2025.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location] = []
    @Published var mapLocation: Location {
        didSet{
            updateCameraPostion(location: mapLocation)
        }
    }
    @Published var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion())
    
    @Published var showLocationsList: Bool = false
    
    init () {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateCameraPostion(location: locations.first!)
    }
    
    private func updateCameraPostion(location: Location) {
        withAnimation (.easeInOut){
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: location.coordinates,
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                )
            )
        }
    }
    
    func toggleLocationsList() {
        withAnimation (.easeInOut){
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed(){
        // get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {return}
        
        // check if next index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // if next index is not valid, restart from 0
            if let firstLocation = locations.first {
                showNextLocation(location: firstLocation)
            }
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
}
