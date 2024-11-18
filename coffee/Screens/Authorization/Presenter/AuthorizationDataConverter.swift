//
//  AuthorizationDataConverter.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

import UIKit
//import DataConverterUtilites
//import UIComponents

protocol AuthorizationDataConverterInput {
    func convert(with model: String, delegate: AnyObject) -> CollectionViewModel
}

final class AuthorizationDataConverter: AuthorizationDataConverterInput {
    
    private typealias Section = CollectionViewModel.Section
    private typealias Row = CollectionViewModel.Section.Row
    
    func convert(with model: String, delegate: AnyObject) -> CollectionViewModel {
        
        var collectionVM = CollectionViewModel(sections: [])
        
        let topInset = ConstantLayoutSection.calculateTopInsetForCenteredSection(sectionHeight: 200)
        
        let layoutSection = ConstantLayoutSection.registrationAndAuthSection
        layoutSection.contentInsets.top = topInset
        
        var section = Section(rows: [], layout: layoutSection)
        
        guard let presenter = delegate as? AuthorizationPresenter else { return collectionVM }
        
        let loginTextFieldModel = TextFieldCVCell.Model(key: AuthTextFieldType.email.rawValue, title: "e-mail", output: presenter, keyboardType: .email)
        section.rows.append(TextFieldCVCell.createCellConfigurator(with: loginTextFieldModel))
        
        let passwordTextFieldModel = TextFieldCVCell.Model(key: AuthTextFieldType.password.rawValue, title: "Пароль", output: presenter, keyboardType: .password)
        section.rows.append(TextFieldCVCell.createCellConfigurator(with: passwordTextFieldModel))
        
        section.rows.append(ButtonCVCell.createCellConfigurator(with:
                .init(key: ButtonKey.loginButton.rawValue, title: "Войти", output: presenter, style: .filled)))
        
        section.rows.append(ButtonCVCell.createCellConfigurator(with:
                .init(key: ButtonKey.registerButton.rawValue, title: "Зарегистрироваться", output: presenter, style: .textOnly)))
        collectionVM.sections.append(section)
        
        return collectionVM
    }
}
