//
//  TagsView.swift
//  TagsControl
//
//  Created by liujianlin on 2016/11/28.
//  Copyright © 2016年 fcgeek. All rights reserved.
//

import UIKit

class TagsView: UIScrollView {
    
    private let tagContainerView = UIView()
    private var tagWidth:CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
        showsHorizontalScrollIndicator = false
        addSubview(textField)
        addSubview(tagContainerView)
        tagContainerView.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.centerY.equalTo(self)
            make.height.equalTo(frame.height)
            make.width.equalTo(tagWidth)
        }
        textField.snp.makeConstraints { (make) in
            make.leading.equalTo(tagContainerView.snp.trailing)
            make.centerY.equalTo(self)
            make.height.equalTo(frame.height)
            make.width.equalTo(frame.width)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if tagContainerView.frame.height==frame.height { return }
        tagContainerView.snp.updateConstraints { (make) in
            make.height.equalTo(frame.height)
        }
        textField.snp.updateConstraints { (make) in
            make.height.equalTo(frame.height)
            make.width.equalTo(frame.width-32)
        }
    }
    
    func addTag(withText text: String) {
        textField.text = ""
        let tagView = TagView(withText: text)
        tagView.alpha = 0
        tagView.didClose = { [unowned self] in
            self.remove(withTagView: tagView)
        }
        let lastTagView = tagContainerView.subviews.last
        tagContainerView.addSubview(tagView)
        tagView.snp.makeConstraints { (make) in
            make.size.equalTo(tagView.frame.size)
            make.centerY.equalTo(tagContainerView)
            if let lastTag = lastTagView {
                make.leading.equalTo(lastTag.snp.trailing).offset(3)

            } else {
                make.leading.equalTo(tagContainerView).offset(3)
            }
        }
        tagWidth += tagView.frame.width+3
        tagContainerView.snp.updateConstraints { (make) in
            make.width.equalTo(tagWidth)
        }
        UIView.animate(withDuration: 0.3, animations: {
            tagView.alpha = 1
        })
        contentSize = CGSize(width: frame.width+tagWidth, height: frame.height)
        if tagWidth > frame.width*3/4 {
            setContentOffset(CGPoint(x: tagWidth-frame.width*3/4, y: 0), animated: true)
        }
    }
    
    func remove(withTagView tagView: TagView) {
        tagWidth -= tagView.frame.width+3
        tagContainerView.snp.updateConstraints { (make) in
            make.width.equalTo(tagWidth)
        }
        UIView.animate(withDuration: 0.3, animations: {
            tagView.alpha = 0
            self.layoutIfNeeded()
        }, completion: { _ in
            tagView.removeFromSuperview()
        })
        if tagWidth > frame.width*3/4 {
            setContentOffset(CGPoint(x: tagWidth-frame.width*3/4, y: 0), animated: true)
        } else {
            setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
    func removeLastTag() {
        guard let lastTag = tagContainerView.subviews.last as? TagView else {
            return
        }
        remove(withTagView: lastTag)
    }
    
    //MARK: - setter
    var tags = [String]() {
        didSet {
            tags.forEach { (tag) in
                addTag(withText: tag)
            }
        }
    }
    
    //MARK: - getter
    private lazy var textField:UITextField = {
        let textfield = UITextField()
        textfield.layer.cornerRadius = 4
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.tintColor = UIColor.red
        textfield.delegate = self
        textfield.returnKeyType = .search
        return textfield
    }()
}

extension TagsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty {
            return false
        }
        addTag(withText: textField.text!)
        return true
    }
}
