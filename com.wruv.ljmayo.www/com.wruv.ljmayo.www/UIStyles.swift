//
//  UIStyles.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/11/24.
//

import SwiftUI


class UIStyles:ObservableObject{
    
    //these are for the dark color scheme
    var black: Color
    var white: Color
    var lightGray :Color
    var darkGray :Color
    
    //maybe we want a light colors scheme?
    
    init(){
        black = Color(red: 34 / 255, green: 32 / 255, blue: 46 / 255)
        white = Color(red:232 / 255, green: 241 / 255, blue:238 / 255)
        lightGray = Color(red:132 / 255, green:143 / 255, blue:165 / 255)
        darkGray = Color(red:76 / 255, green:76 / 255, blue:82 / 255)
    }
    
    
    
    func primaryFont(size:CGFloat)->Font{
        return Font.custom("AvenirNext-Medium", size:size)
    }
}
