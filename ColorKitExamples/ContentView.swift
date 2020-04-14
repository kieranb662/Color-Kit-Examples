//
//  ContentView.swift
//  ColorKitExamples
//
//  Created by Kieran Brown on 4/13/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import ColorKit


struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Color Pickers")) {
                    NavigationLink("RGB", destination: RGBExample())
                    NavigationLink("Rectangular HSB", destination: HSBExample())
                    NavigationLink("Circular HSB", destination: CircularHSBPickerExample())
                    NavigationLink("CMYK", destination: CMYKExample())
                    NavigationLink("Gray Scale", destination: GrayscaleExample())
                    NavigationLink("Alpha", destination: AlphaSliderExample())
                    NavigationLink("Full Color Picker", destination: ColorPickerExample())
                }
                Section(header: Text("Gradient Pickers")) {
                    NavigationLink("Simple Linear", destination: SimpleLinearExample())
                    NavigationLink("Linear", destination: LinearGradientExample())
                    NavigationLink("Simple Radial", destination: SimpleRadialExample())
                    NavigationLink("Radial", destination: RadialGradientExample())
                    NavigationLink("Simple Angular", destination: SimpleAngularExample())
                    NavigationLink("Angular", destination: AngularGradientExample())
                    NavigationLink("Full Gradient Picker", destination: FullGradientPickerExample())
                }
            }.navigationBarTitle("Color Kit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().colorScheme(.dark)
    }
}
