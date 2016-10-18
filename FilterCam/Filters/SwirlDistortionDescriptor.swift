//
//  SwirlDistortionDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/8/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//


import Foundation
import GPUImage


class SwirlDistortionDescriptor: FilterDescriptorInterface {
    
    
    
    let key = "SwirlDistortion"
    let title = "Swirl Distortion"
    
    var filter: BasicOperation?  = nil
    let filterGroup: OperationGroup? = nil
    
    let numParameters = 2
    let parameterConfiguration = [ParameterSettings(title:"angle", minimumValue:0.0, maximumValue:6.0, initialValue:1.0, isRGB:false),
                                  ParameterSettings(title:"radius", minimumValue:0.0, maximumValue:1.0, initialValue:0.25, isRGB:false)]
    
    
    let filterOperationType = FilterOperationType.singleInput
    
    private var lclFilter:SwirlDistortion = SwirlDistortion() // the actual filter
    private var stash_angle: Float
    private var stash_radius: Float
    
    
    init(){
        filter = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.angle = parameterConfiguration[0].initialValue
        lclFilter.radius = parameterConfiguration[1].initialValue
        stash_angle = lclFilter.angle
        stash_radius = lclFilter.radius
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    func getParameter(index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.angle
        case 2:
            return lclFilter.radius
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.angle = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        case 2:
            lclFilter.radius = value
            log.debug("\(parameterConfiguration[1].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(index:Int, color:UIColor) {}
    
    
    func stashParameters() {
        stash_angle = lclFilter.angle
        stash_radius = lclFilter.radius
    }
    
    func restoreParameters(){
        lclFilter.angle = stash_angle
        lclFilter.radius = stash_radius
    }
}