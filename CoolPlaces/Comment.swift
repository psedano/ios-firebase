//
//  Comment.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/22/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import Foundation

class Comment {
    private var _text: String!
    private var _user: String!
    private var _uid: String!
    
    var text: String {
        return _text
    }
    
    var user: String {
        return _user
    }
    
    var uid: String {
        return _uid
    }
    
    func setText(text: String) {
        self._text = text
    }
    
    func setUser(user: String) {
        self._user = user
    }
    
    func setUID(uid: String) {
        self._uid = uid
    }
}