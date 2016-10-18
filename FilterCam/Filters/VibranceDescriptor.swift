//
//  VibranceDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/4/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


class VibranceDescriptor: FilterDescriptorInterface {
    
    
    let key = "Vibrance"
    let title = "Vibrance"
    
    var filter: BasicOperation?  = nil
    let filterGroup: OperationGroup? = nil
    
    let numParameters = 1
    let parameterConfiguration = [ParameterSettings(title:"vibrance", minimumValue:-1.2, maximumValue:1.2, initialValue:0.0, isRGB:false)]
    
    
    let filterOperationType = FilterOperationType.singleInput
    
    private var lclFilter:Vibrance = Vibrance() // the actual filter
    private var stash_vibrance: Float
    
    
    init(){
        filter = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.vibrance = parameterConfiguration[0].initialValue
        stash_vibrance = lclFilter.vibrance
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    
    func getParameter(index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.vibrance
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.vibrance = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(index:Int, color:UIColor) {}
    
    
    func stashParameters(){
        stash_vibrance = lclFilter.vibrance
    }
    
    func restoreParameters(){
        lclFilter.vibrance = stash_vibrance
    }
}