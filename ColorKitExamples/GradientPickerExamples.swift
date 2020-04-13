//
//  GradientPickerExamples.swift
//  ColorKitExamples
//
//  Created by Kieran Brown on 4/13/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import ColorKit

// MARK: - Linear
struct LinearGradientExample: View {
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
struct RadialGradientExample: View {
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
struct AngularGradientExample: View {
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


