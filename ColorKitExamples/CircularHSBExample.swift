// Swift toolchain version 6.0
// Running macOS version 26.3
// Created on 4/11/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Sliders
import ColorKit

public struct Pentagon: Shape {
    /// Creates a square bottomed pentagon.
    public init() {}
    
    var insetAmount: CGFloat = 0
    
    public func path(in rect: CGRect) -> Path {
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height
        
        return Path { path in
            path.move(to:    CGPoint(x: w/2, y:   0))
            path.addLine(to: CGPoint(x:   0, y: h/2))
            path.addLine(to: CGPoint(x:   0, y:   h))
            path.addLine(to: CGPoint(x:   w, y:   h))
            path.addLine(to: CGPoint(x:   w, y: h/2))
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension Pentagon: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

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
        }
        .frame(width: strokeWidth/2, height: 0.66*strokeWidth)
        .offset(x: 0, y: 0.16*strokeWidth-1.5)
    }
    
    func makeTrack(configuration: LSliderConfiguration) -> some View {
        GeometryReader { proxy in
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(
                        LinearGradient(
                            gradient: gradient,
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white)
            }
            .frame(width: proxy.size.width)
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
        return ZStack {
            Circle()
                .fill(Color.white)
            
            Circle()
                .inset(by: 6)
                .fill(Color(
                    hue: (configuration.angle.degrees/360),
                            saturation: configuration.radialOffset,
                            brightness: brightness)
                )
        }
        .frame(width: 45, height: 45)
    }
    
    func makeTrack(configuration: RadialPadConfiguration) -> some View {
        ZStack {
            Circle()
                .fill(Color(hue: 0, saturation: 0, brightness: brightness))
            
            HueCircleView()
                .blendMode(.plusDarker)
            
            Circle()
                .stroke(Color.white, lineWidth: 2)
        }
        .frame(width: 300, height: 300)
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
            
            RadialPad(
                offset: Binding(
                    get: { color.saturation },
                    set: { color = color.update(saturation: $0) }),
                angle: Binding(
                    get: { Angle(degrees: color.hue*360) },
                    set: { color = color.update(hue: $0.degrees/360) })
            )
            .radialPadStyle(SaturationHueRadialPad(brightness: color.brightness))
            
            LSlider(
                Binding(
                    get: { color.brightness },
                    set: { color = color.update(brightness: $0) })
            )
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
        }
        .navigationTitle("Circular HSB Picker")
    }
}

struct RadialPadExample_Previews: PreviewProvider {
    static var previews: some View {
        CircularHSBPickerExample()
    }
}
