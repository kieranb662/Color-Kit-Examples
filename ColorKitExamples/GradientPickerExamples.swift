//
//  GradientPickerExamples.swift
//  ColorKitExamples
//
//  Created by Kieran Brown on 4/13/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import ColorKit


let gradient1: [GradientData.Stop] = [.init(color: ColorToken(colorSpace: .sRGB, r: 252/255, g: 70/255, b: 107/255, a: 1), location: 0),
                                      .init(color: ColorToken(colorSpace: .sRGB, r: 63/255, g: 94/255, b: 251/255, a: 1), location: 1)]
let gradient2: [GradientData.Stop] = [.init(color: ColorToken(colorSpace: .sRGB, r: 63/255, g: 43/255, b: 150/255, a: 1), location: 0),
                                      .init(color: ColorToken(colorSpace: .sRGB, r: 168/255, g: 192/255, b: 255/255, a: 1), location: 1)]
let rainbow: [GradientData.Stop] = [.init(color: ColorToken(colorSpace: .sRGB, r: 148/255, g: 0/255, b: 211/255, a: 1), location: 0),
                                    .init(color: ColorToken(colorSpace: .sRGB, r: 75/255, g: 0/255, b: 130/255, a: 1), location: 0.16),
                                    .init(color: ColorToken(colorSpace: .sRGB, r: 0/255, g: 0/255, b: 255/255, a: 1), location: 0.32),
                                    .init(color: ColorToken(colorSpace: .sRGB, r: 0/255, g: 255/255, b: 0/255, a: 1), location: 0.48),
                                    .init(color: ColorToken(colorSpace: .sRGB, r: 255/255, g: 255/255, b: 0/255, a: 1), location: 0.65),
                                    .init(color: ColorToken(colorSpace: .sRGB, r: 255/255, g: 127/255, b: 0/255, a: 1), location: 0.81),
                                    .init(color: ColorToken(colorSpace: .sRGB, r: 255/255, g: 0/255, b: 0/255, a: 1), location: 0.97)]

// MARK: - Linear

struct SimpleLinearExample: View {
    @ObservedObject var manager: GradientManager = GradientManager(.defaultValue)
    var body: some View {
        ZStack {
            Color(white: 0.2).edgesIgnoringSafeArea(.all)
            LinearGradientPicker()
            .environmentObject(manager)
                .padding(30)
        }
        
    }
}



struct LinearGradientExample: View {
    @ObservedObject var manager: GradientManager = GradientManager(GradientData(name: "My Gradient", stops: gradient2, startPoint: .leading, endPoint: .trailing))
    @State var defaultColor: ColorToken = ColorToken(colorSpace: .sRGB, r: 0.2, g: 0.2, b: 0.4)
    // Here I make a custom binding inorder to handle whether a gradient stop is selected or not
    // If none is selected or if the selection is invalid, then the RGBColorPicker is bound to the
    // default color
    var selectedColor: Binding<ColorToken> {
        Binding(get: {
            guard let selected = self.manager.selected else { return self.defaultColor }
            guard let color = self.manager.gradient.stops.first(where: {$0.color.id == selected}) else { return self.defaultColor }
            return color.color
        }) { newValue in
            guard let selected = self.manager.selected else {
                self.defaultColor = newValue
                return
            }
            guard let stop = self.manager.gradient.stops.enumerated().first(where: {$0.element.id == selected}) else {
                self.defaultColor = newValue
                return
            }
            self.manager.gradient.stops[stop.offset] = .init(color: newValue, location: stop.element.location)
        }
    }
    func add() {
        let newColor = ColorToken(self.selectedColor.wrappedValue)
        self.manager.gradient.stops.append(.init(color: newColor, location: 0.5))
    }
    func delete() {
        guard let selected = self.manager.selected  else { return }
        if self.manager.gradient.stops.count > 1 {
            self.manager.selected = nil
            let new = self.manager.gradient.stops.filter({$0.id != selected})
            
            self.manager.gradient.stops = new
        }
    }
    
    var body: some View {
        ZStack {
            Color(white: 0.2)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                LinearGradientPicker()
                .environmentObject(manager)
                RGBColorPicker(selectedColor)
                HStack {
                    Button(action: delete) {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Button(action: add) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }.frame(height: 30)
            }
            .padding(40)
        }.navigationBarTitle("Linear Gradient Picker")
        
    }
}

// MARK: - Radial
struct SimpleRadialExample: View {
    @ObservedObject var manager: GradientManager = GradientManager(GradientData(name: "My Gradient", stops: gradient1, center: .center, startRadius: 0, endRadius: 100))
    var body: some View {
        ZStack {
            Color(white: 0.2).edgesIgnoringSafeArea(.all)
            RadialGradientPicker()
            .environmentObject(manager)
                .padding(30)
        }
    }
}



struct RadialGradientExample: View {
    @ObservedObject var manager: GradientManager = GradientManager(GradientData(name: "My Gradient", stops: gradient1, center: .center, startRadius: 0, endRadius: 100))
    @State var defaultColor: ColorToken = ColorToken(colorSpace: .sRGB, r: 0.2, g: 0.2, b: 0.4)
    // Here I make a custom binding inorder to handle whether a gradient stop is selected or not
    // If none is selected or if the selection is invalid, then the RGBColorPicker is bound to the
    // default color
    var selectedColor: Binding<ColorToken> {
        Binding(get: {
            guard let selected = self.manager.selected else { return self.defaultColor }
            guard let color = self.manager.gradient.stops.first(where: {$0.color.id == selected}) else { return self.defaultColor }
            return color.color
        }) { newValue in
            guard let selected = self.manager.selected else {
                self.defaultColor = newValue
                return
            }
            guard let stop = self.manager.gradient.stops.enumerated().first(where: {$0.element.id == selected}) else {
                self.defaultColor = newValue
                return
            }
            self.manager.gradient.stops[stop.offset] = .init(color: newValue, location: stop.element.location)
        }
    }
    func add() {
        let newColor = ColorToken(self.selectedColor.wrappedValue)
        self.manager.gradient.stops.append(.init(color: newColor, location: 0.5))
    }
    func delete() {
        guard let selected = self.manager.selected  else { return }
        if self.manager.gradient.stops.count > 1 {
            self.manager.selected = nil
            let new = self.manager.gradient.stops.filter({$0.id != selected})
            
            self.manager.gradient.stops = new
        }
    }
    
    var body: some View {
        ZStack {
            Color(white: 0.2)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                RadialGradientPicker()
                .environmentObject(manager)
                RGBColorPicker(selectedColor)
                HStack {
                    Button(action: delete) {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Button(action: add) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }.frame(height: 30)
            }
            .padding(40)
        }.navigationBarTitle("Radial Gradient Picker")
        
    }
}

// MARK: - Angular


struct SimpleAngularExample: View {
    @ObservedObject var manager: GradientManager = GradientManager(GradientData(name: "My Gradient", stops: rainbow, center: .center, startAngle:  0, endAngle: 0.95))
    var body: some View {
        ZStack {
            Color(white: 0.2).edgesIgnoringSafeArea(.all)
            AngularGradientPicker()
            .environmentObject(manager)
                .padding(30)
        }
    }
}

struct AngularGradientExample: View {
    @ObservedObject var manager: GradientManager = GradientManager(GradientData(name: "My Gradient", stops: rainbow, center: .center, startAngle:  0, endAngle: 0.95))
    @State var defaultColor: ColorToken = ColorToken(colorSpace: .sRGB, r: 0.2, g: 0.2, b: 0.4)
    // Here I make a custom binding inorder to handle whether a gradient stop is selected or not
    // If none is selected or if the selection is invalid, then the RGBColorPicker is bound to the
    // default color
    var selectedColor: Binding<ColorToken> {
        Binding(get: {
            guard let selected = self.manager.selected else { return self.defaultColor }
            guard let color = self.manager.gradient.stops.first(where: {$0.color.id == selected}) else { return self.defaultColor }
            return color.color
        }) { newValue in
            guard let selected = self.manager.selected else {
                self.defaultColor = newValue
                return
            }
            guard let stop = self.manager.gradient.stops.enumerated().first(where: {$0.element.id == selected}) else {
                self.defaultColor = newValue
                return
            }
            self.manager.gradient.stops[stop.offset] = .init(color: newValue, location: stop.element.location)
        }
    }
    func add() {
        let newColor = ColorToken(self.selectedColor.wrappedValue)
        self.manager.gradient.stops.append(.init(color: newColor, location: 0.5))
    }
    func delete() {
        guard let selected = self.manager.selected  else { return }
        if self.manager.gradient.stops.count > 1 {
            self.manager.selected = nil
            let new = self.manager.gradient.stops.filter({$0.id != selected})
            
            self.manager.gradient.stops = new
        }
    }
    
    var body: some View {
        ZStack {
            Color(white: 0.2)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                AngularGradientPicker()
                .environmentObject(manager)
                RGBColorPicker(selectedColor)
                HStack {
                    Button(action: delete) {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Button(action: add) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }.frame(height: 30)
            }
            .padding(40)
        }.navigationBarTitle("Angular Gradient Picker")
    }
}
// MARK: - Full Example 

struct FullGradientPickerExample: View {
    @ObservedObject var manager: GradientManager = GradientManager(.defaultValue)
    @State var defaultColor: ColorToken = ColorToken(colorSpace: .sRGB, r: 0.2, g: 0.2, b: 0.4)
    // Here I make a custom binding inorder to handle whether a gradient stop is selected or not
    // If none is selected or if the selection is invalid, then the RGBColorPicker is bound to the
    // default color
    var selectedColor: Binding<ColorToken> {
        Binding(get: {
            guard let selected = self.manager.selected else { return self.defaultColor }
            guard let color = self.manager.gradient.stops.first(where: {$0.color.id == selected}) else { return self.defaultColor }
            return color.color
        }) { newValue in
            guard let selected = self.manager.selected else {
                self.defaultColor = newValue
                return
            }
            guard let stop = self.manager.gradient.stops.enumerated().first(where: {$0.element.id == selected}) else {
                self.defaultColor = newValue
                return
            }
            self.manager.gradient.stops[stop.offset] = .init(color: newValue, location: stop.element.location)
        }
    }
    func add() {
        let newColor = ColorToken(self.selectedColor.wrappedValue)
        self.manager.gradient.stops.append(.init(color: newColor, location: 0.5))
    }
    func delete() {
        guard let selected = self.manager.selected  else { return }
        if self.manager.gradient.stops.count > 1 {
            self.manager.selected = nil
            let new = self.manager.gradient.stops.filter({$0.id != selected})
            
            self.manager.gradient.stops = new
        }
    }

    var body: some View {
        ZStack {
            Color(white: 0.2)
                .edgesIgnoringSafeArea(.all)
            VStack {
                GradientPicker(_manager)
                RGBColorPicker(selectedColor).padding(40)
                HStack {
                    Button(action: delete) {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Button(action: add) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }.frame(height: 30)
            }
        }.navigationBarTitle("Gradient Picker", displayMode: .inline)
    }
}


