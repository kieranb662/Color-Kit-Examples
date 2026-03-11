// Swift toolchain version 6.0
// Running macOS version 26.3
// Created on 4/13/20.
//
// Author: Kieran Brown
//

import SwiftUI
import ColorKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
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
            }
            .navigationTitle("Color Kit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .colorScheme(.dark)
    }
}
