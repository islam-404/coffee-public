//
//  BaseCollectionView.swift
//  DataConverterUtilites
//
//  Created by islam on 12.09.2024.
//

import UIKit

public class BaseCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    private var viewModel: CollectionViewModel = CollectionViewModel(sections: []) {
        didSet {
            registrarCV?.register(in: viewModel.sections)
        }
    }
    
    
    lazy var sendingData: (() -> [CollectionViewModel.Section]) = { [weak self] in
        
        return self?.viewModel.sections ?? []
    }
    
    private var registrarCV: CollectionViewRegistrar?
    private var customDataSource: DiffableDataSourceCV?
    private var delegateCV: BaseCVDelegate?
    
    public lazy var layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
        guard let self = self else { return nil }
        return self.viewModel.sections[sectionIndex].layout
    }
    

    // MARK: - Init
    init() {
        super.init(frame: .zero, collectionViewLayout: .init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init func
    func setComponents(registrar: CollectionViewRegistrar,
                       dataSource: DiffableDataSourceCV,
                       delegate: BaseCVDelegate) {
        registrarCV = registrar
        customDataSource = dataSource
        delegateCV = delegate
        setupInitialState()
    }

    // MARK: - Setup
    private func setupInitialState() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

        dataSource = customDataSource
        delegate = delegateCV
        setCollectionViewLayout(layout, animated: false)
    }
    
    // MARK: - Data Management
    ///  - Parameters:
    ///   - data: Модель данных для конфигурации
    ///   - isApplySnapshot: отвечает за что чтобы обновить вид
    ///    
    ///    **Внимание**
    /// ```
    /// isApplySnapshot = fasle
    /// ```
    /// Может вызвать ошибку
    public func updateData(data: CollectionViewModel, isApplySnapshot: Bool = true) {
        viewModel = data
        isApplySnapshot ? customDataSource?.applySnapshot() : ()
        
    }

    public func reloadItems(data: CollectionViewModel) {
        viewModel = data
        customDataSource?.reloadItems()
    }
    
    deinit {
        debugPrint(#function, type(of: self))
    }
}
