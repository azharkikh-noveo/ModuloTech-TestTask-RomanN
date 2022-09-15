//
//  UIControlPublisher.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit
import Combine


// MARK: - Subscription

/// A custom subscription to capture UIControl target events.
fileprivate final class UIControlSubscription<S: Subscriber, C: UIControl>: Subscription
where S.Input == C {
    
    private var subscriber: S?
    
    private let control: C
    
    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
    
    fileprivate init(subscriber: S, control: C, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }
    
    fileprivate func request(_ demand: Subscribers.Demand) {
        
    }
    
    fileprivate func cancel() {
        subscriber = nil
    }
    
}


// MARK: - Publisher

/// A custom `Publisher` to work with our custom `UIControlSubscription`.
public struct UIControlPublisher<C: UIControl>: Publisher {
    
    public typealias Output = C
    
    public typealias Failure = Never
    
    private let control: C
    
    private let controlEvents: UIControl.Event
    
    public init(control: C, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }
    
    public func receive<S: Subscriber>(subscriber: S)
    where S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
        
        let subscription = UIControlSubscription(
            subscriber: subscriber,
            control: control,
            event: controlEvents
        )
        
        subscriber.receive(subscription: subscription)
        
    }
    
}


// MARK: - UIControl extension

/// Suplementary protocol.
public protocol UIControlPublisherProtocol {
    
}

extension UIControlPublisherProtocol where Self: UIControl {
    
    /// Publisher for a UIControl event.
    public func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, events: events)
    }
    
}

extension UIControl: UIControlPublisherProtocol {
    
}
