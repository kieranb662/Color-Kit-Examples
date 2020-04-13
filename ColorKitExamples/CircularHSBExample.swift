//
//  RadialPadExample.swift
//  SlidersExamples
//
//  Created by Kieran Brown on 4/11/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import Sliders
import Shapes
import ColorKit



struct BrightnessSliderStyle: LSliderStyle {
    let color: ColorToken
    
    let strokeWidth: CGFloat
    var gradient: Gradient {
        Gradient(colors: [Color(hue: color.hue, saturation: color.saturation, brightness: 0),
                          Color(hue: color.hue, saturation: color.saturation, brightness: 1)])
    }
    
    func makeThumb(configuration: LSliderConfiguration) -> some View {
        ZStack {
            Pentagon()
                .fill(color.color)
            Pentagon()
                .stroke(Color.white, style: .init(lineWidth: 3, lineJoin: .round))
        }.frame(width: strokeWidth/2, height: 0.66*strokeWidth)
            .offset(x: 0, y: 0.16*strokeWidth-1.5)
    }
    
    func makeTrack(configuration: LSliderConfiguration) -> some View {
        GeometryReader { proxy in
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(LinearGradient(gradient: self.gradient, startPoint: .leading, endPoint: .trailing))
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white)
            }.frame(width: proxy.size.width)
        }
    }
}

struct SaturationHueRadialPad: RadialPadStyle {
    let brightness: Double
    var hueColors: [Color] {
        stride(from: 0, to: 1, by: 0.01).map {
            Color(hue: $0, saturation: 1, brightness: brightness)
        }
    }
    
    func makeThumb(configuration: RadialPadConfiguration) -> some View {
        let color = Color(hue: (configuration.angle.degrees/360), saturation: configuration.radialOffset, brightness: self.brightness)
        return ZStack {
            Circle()
                .fill(Color.white)
            Circle()
                .inset(by: 6)
                .fill(color)
        }.frame(width: 45, height: 45)
    }
    
    func makeTrack(configuration: RadialPadConfiguration) -> some View {
        ZStack {
            Circle()
                .fill(Color(hue: 0, saturation: 0, brightness: self.brightness))
            HueCircleView()
                .blendMode(.plusDarker)
            Circle()
                .stroke(Color.white, lineWidth: 2)
        }.frame(width: 300, height: 300)
    }
}

struct CircularHSBColorPicker: View {
    @Binding var color: ColorToken
    var sliderHeight: CGFloat = 40
    var overlay: some View {
        VStack {
            Text("h: \(String(format: "%.0f", color.hue*360))")
            Text("s: \(String(format: "%.0f", color.saturation*100))%")
            Text("b: \(String(format: "%.0f", color.brightness*100))%")
            Text(String(color.color.description.dropLast(2)))
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 5)
                .fill(color.color)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2))
            .shadow(radius: 3)
                .aspectRatio(1, contentMode: .fit)
            .overlay(overlay)
            RadialPad(offset: Binding(get: {self.color.saturation}, set: {self.color = self.color.update(saturation: $0)}),
                      angle: Binding(get: { Angle(degrees: self.color.hue*360) }, set: { self.color = self.color.update(hue: $0.degrees/360) }))
                .radialPadStyle(SaturationHueRadialPad(brightness: color.brightness))
            LSlider(Binding(get: {self.color.brightness}, set: {self.color = self.color.update(brightness: $0)}))
                .linearSliderStyle(BrightnessSliderStyle(color: color, strokeWidth: sliderHeight))
                .frame(height: sliderHeight)
        }
    }
}

struct CircularHSBPickerExample: View {
    @State var color: ColorToken = ColorToken(hue: 0.3, saturation: 1, brightness: 0.6)
    
    var body: some View {
        ZStack {
            Color(white: 0.2)
            .edgesIgnoringSafeArea(.all)
            CircularHSBColorPicker(color: $color)
                .padding(50)
        }.navigationBarTitle("Circular HSB Picker")
    }
}

struct RadialPadExample_Previews: PreviewProvider {
    static var previews: some View {
        CircularHSBPickerExample()
    }
}
