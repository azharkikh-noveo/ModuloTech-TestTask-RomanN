//
//  BaseViewModel.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation
import Combine


/// Base class for the view controller view-models.
public class BaseViewModel: NSObject {
    
    
    /// Storage for the subscriptions.
    public var disposeBag: Set<AnyCancellable> = []
    
    /// Creates an instance of a view-model.
    public override init() {
        super.init()
    }
    
    /// Should be called after the respective method of assigned view controller.
    public func onViewDidLoad() {
        
    }
    
    /// Should be called after the respective method of assigned view controller.
    public func onViewWillAppear() {
        
    }
    
    /// Should be called after the respective method of assigned view controller.
    public func onViewDidAppear() {
        
    }
    
    /// Should be called after the respective method of assigned view controller.
    public func onViewWillDisappear() {
        
    }
    
    /// Should be called after the respective method of assigned view controller.
    public func onViewDidDisappear() {
        
    }
    
}
