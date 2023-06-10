//
//  GeneralTagsViewModel.swift
//  Smile
//
//  Created by Tango on 2022/11/5.
//  Copyright © 2022 Azir. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol GeneralTagsViewModelType {
    var input: GeneralTagsViewModelInput { get }
    var output: GeneralTagsViewModelOutput { get }
}

protocol GeneralTagsViewModelInput {
    func updateStyle(_ tagTitles: [String])
}

protocol GeneralTagsViewModelOutput {
    var tagTitles: [String] { get }
    var reloadSignal: Signal<Void, Never> { get }
}

class GeneralTagsViewModel: GeneralTagsViewModelType {
    var input: GeneralTagsViewModelInput { self }
    var output: GeneralTagsViewModelOutput { self }
    
    // Input
    func updateStyle(_ tagTitles: [String]) {
        self.tagTitles = tagTitles
        reloadProperty.value = ()
    }
    
    // Output
    var tagTitles: [String] = []
    var reloadSignal: Signal<Void, Never>
    
    private var reloadProperty = MutableProperty<Void>(())
    
    init() {
        reloadSignal = reloadProperty.signal
    }
}

extension GeneralTagsViewModel: GeneralTagsViewModelInput {}
extension GeneralTagsViewModel: GeneralTagsViewModelOutput {}

