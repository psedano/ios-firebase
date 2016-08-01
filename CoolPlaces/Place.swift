//
//  Place.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/21/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import Foundation

class Place {
    
    private var _descripcion: String!
    private var _estado: String!
    private var _placeId: Int!
    private var _imagen: String!
    private var _lat: Double!
    private var _lon: Double!
    private var _lugar: String!

    var descripcion: String {
        return _descripcion
    }
    
    var estado: String {
        return _estado
    }
    
    var placeId: Int {
        return _placeId
    }
    
    var imagen: String {
        return _imagen
    }
    
    var lat: Double {
        return _lat
    }
    
    var lon: Double {
        return _lon
    }
    
    var lugar: String {
        return _lugar
    }
    
    init(descripcion: String, estado: String, placeId: Int, imagen: String, lat: Double, lon: Double, lugar: String){
        
        self._descripcion = descripcion
        self._estado = estado
        self._placeId = placeId
        self._imagen = imagen
        self._lat = lat
        self._lon = lon
        self._lugar = lugar
        
    }
    
}
