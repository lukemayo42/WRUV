//
//  UIStyles.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/11/24.
//

import SwiftUI


class UIStyles:ObservableObject{
    
    
    var black: Color
    var white: Color
    var gray :Color
    var blue :Color
    
    init(){
        black = Color(.black)
        white = Color(.white)
        gray = Color(.gray)
        blue = Color(.blue)
    }
    
    func primaryFont(size:CGFloat)->Font{
        return Font.custom("AvenirNext-Medium", size:size)
    }
}
