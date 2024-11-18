//
//  PinSectionCollectionView.swift
//  DataConverterUtilites
//
//  Created by islam on 14.09.2024.
//

//import UIKit
//
//struct PinCVModel: Equatable {
//
//    let indexSection: Int
////    let height: CGFloat
//    let typePin: TypePin
//    
//    enum TypePin {
//        case top
//        case bottom
//        
//        case topOnly
//        case bottomOnly
//    }
//}
//
//final class CollectionViewPinSection: BaseCollectionView {
//    
//    // MARK: - Views
//    private lazy var pinCV = BaseCollectionView()
//    private var scrollViewMain: UIScrollView = UIScrollView()
//    private var scrollViewPinCV: UIScrollView = UIScrollView()
//
//    // MARK: - Properties
//    private var indexPinSection: Int?
//    private var isPinned: Bool = false {
//        didSet {
//            updatePinVisibility()
//        }
//    }
//    private var pinCVModel: PinCVModel?
//    var didScroll: ((_ scrollView: UIScrollView) -> Void)?
//    var isPinnedSection: ((_ isPinned: Bool) -> Void)?
//    
////    override var viewModel: CollectionViewModel {
////        didSet {
////            if let index = indexPinSection, let section = viewModel.sections[safe: index] {
////                pinCV.updateData(data: CollectionViewModel(sections: [section]))
////            }
////        }
////    }
//
//    // MARK: - Setup Pin Section
//    func setPinSection(_ pinCVModel: PinCVModel) {
//        guard let superview else { return }
//        
//        self.pinCVModel = pinCVModel
//        pinCV.backgroundColor = .white
//        
//        superview.addSubview(pinCV)
//        setupPinCVConstraints(for: pinCVModel)
//        
//        indexPinSection = pinCVModel.indexSection
//        pinCV.bounces = false
//        
//        syncScrollViews()
//        setupPinVisibilityHandling()
//    }
//
//    // MARK: - Handle Pin Constraints
//    private func setupPinCVConstraints(for model: PinCVModel) {
//        switch model.typePin {
//        case .top, .topOnly:
//            pinCV.snp.makeConstraints { make in
//                make.top.equalTo(superview!.safeAreaLayoutGuide)
//                make.left.right.equalToSuperview()
//                make.height.equalTo(model.height)
//            }
//        case .bottom, .bottomOnly:
//            pinCV.snp.makeConstraints { make in
//                make.bottom.equalTo(superview!.safeAreaLayoutGuide)
//                make.left.right.equalToSuperview()
//                make.height.equalTo(model.height)
//            }
//        }
//        pinCV.isHidden = true
//    }
//
//    // MARK: - Synchronize Scroll Views
//    private func syncScrollViews() {
//        pinCV.willDisplayCVCell { [weak self] cell, _ in
//            guard let scrollView = cell.superview as? UIScrollView else { return }
//            self?.scrollViewPinCV = scrollView
//        }
//
//        willDisplayCVCell { [weak self] cell, indexPath in
//            guard let self = self else { return }
//            if indexPath.section == self.indexPinSection, let scrollView = cell.superview as? UIScrollView {
//                self.scrollViewMain = scrollView
//            }
//        }
//        customDataSource.didScroll = handleScroll
//    }
//
//    // MARK: - Update Pin Visibility
//    private func updatePinVisibility() {
//        pinCV.isHidden = !isPinned
//        if isPinned {
//            scrollViewPinCV.setContentOffset(scrollViewMain.contentOffset, animated: false)
//        } else {
//            scrollViewMain.setContentOffset(scrollViewPinCV.contentOffset, animated: false)
//        }
//        isPinnedSection?(isPinned)
//    }
//
//    // MARK: - Scroll Handling for Pin
//    private var handleScroll: ((_ scrollView: UIScrollView) -> Void) {
//        return { [weak self] scrollView in
//            guard let self = self, let pinCVModel = self.pinCVModel, let index = self.indexPinSection else { return }
//            
//            let shouldPin: Bool
//            
//            switch pinCVModel.typePin {
//            case .top:
//                shouldPin = self.shouldPinSection(scrollView, for: index, offsetY: scrollView.contentOffset.y)
//            case .bottom:
//                shouldPin = self.shouldPinSection(scrollView, for: index, offsetY: scrollView.contentOffset.y + scrollView.bounds.height - pinCVModel.height)
//            case .topOnly, .bottomOnly:
//                shouldPin = true
//            }
//            
//            if shouldPin != self.isPinned {
//                self.isPinned.toggle()
//            }
//            self.didScroll?(scrollView)
//        }
//    }
//
//    // MARK: - Calculate Pinning Condition
//    private func shouldPinSection(_ scrollView: UIScrollView, for index: Int, offsetY: CGFloat) -> Bool {
//        guard let cell = visibleCells.first(where: { $0.reuseIdentifier == viewModel.sections[safe: index]?.rows.first?.cellType }) else { return false }
//        return cell.frame.origin.y <= offsetY
//    }
//
//    // MARK: - View Model Update
////    override func updateData(data: CollectionViewModel) {
////        super.updateData(data: data)
////        if let index = indexPinSection {
////            pinCV.updateData(data: CollectionViewModel(sections: [viewModel.sections[safe: index]].compactMap { $0 }))
////            pinCV.isHidden = !isPinned
////        }
////    }
//
//    // MARK: - Retrieve Cell from Pin Section
////    func getCellForIndexSection(index: Int) -> UICollectionViewCell? {
////        let indexPath = IndexPath(row: index, section: 0)
////        return isPinned ? pinCV.cellForItem(at: indexPath) : cellForItem(at: IndexPath(row: index, section: indexPinSection ?? 0))
////    }
//}
//
//extension Collection {
//    subscript (safe index: Index) -> Iterator.Element? {
//        return indices.contains(index) ? self[index] : nil
//    }
//}
