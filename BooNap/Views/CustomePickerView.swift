//
//  CustomePickerView.swift
//  BooNap
//
//  Created by jamil raai on 10.11.21.
//

import SwiftUI
import UIKit


struct CustomPicker: UIViewRepresentable {
    var dataArrays : Array<Int>
    @Binding var selections: Int

    //makeCoordinator()
    func makeCoordinator() -> CustomPicker.Coordinator {
        return CustomPicker.Coordinator(self)
    }

    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<CustomPicker>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }

    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<CustomPicker>) {
    }

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: CustomPicker
        init(_ pickerView: CustomPicker) {
            self.parent = pickerView
        }

        //Number Of Components:
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        //Number Of Rows In Component:
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return parent.dataArrays.count
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return UIScreen.main.bounds.width / 2 - 10
        }

        //Row height:
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 60
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selections =  self.parent.dataArrays[row]
        }

        //View for Row
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2 - 10, height: 60))

            let pickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
            if (parent.dataArrays[row] < 10) {
                pickerLabel.text = "0" + String(parent.dataArrays[row])
            } else {
                pickerLabel.text = String(parent.dataArrays[row])
            }
            pickerLabel.font = UIFont(name: "RoundedMplus1c-Medium", size: 60)
            pickerLabel.textColor = UIColor(Color("TextColor"))
            pickerLabel.textAlignment = .center

            view.addSubview(pickerLabel)

            return view
        }
    }
}
