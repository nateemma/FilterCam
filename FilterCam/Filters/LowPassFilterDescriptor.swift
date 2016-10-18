//
//  LowPassFilterDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/4/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


class LowPassFilterDescriptor: FilterDescriptorInterface {
    
    
    let key = "LowPassFilter"
    let title = "Low Pass Filter"
    
    let filter: BasicOperation?  = nil
    var filterGroup: OperationGroup? = nil
    
    let numParameters = 1
    let parameterConfiguration = [ParameterSettings(title:"strength", minimumValue:0.0, maximumValue:1.0, initialValue:0.5, isRGB:false)]
    
    
    let filterOperationType = FilterOperationType.singleInput
    
    private var lclFilter:LowPassFilter = LowPassFilter() // the actual filter
    private var stash_strength: Float
    
    
    init(){
        filterGroup = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.strength = parameterConfiguration[0].initialValue
        stash_strength = lclFilter.strength
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    
    func getParameter(index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.strength
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.strength = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(index:Int, color:UIColor) {}
    
    
    func stashParameters(){
        stash_strength = lclFilter.strength
    }
    
    func restoreParameters(){
        lclFilter.strength = stash_strength
    }
}