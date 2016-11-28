//
//  TagView.swift
//  TagsControl
//
//  Created by liujianlin on 2016/11/28.
//  Copyright © 2016年 fcgeek. All rights reserved.
//

import UIKit

class TagView: UIView {
    //MARK: - 属性定义
    var didClose = { }
    
    //MARK: - 生命周期
    init(withText text: String) {
        super.init(frame: CGRect.zero)
        let height:CGFloat = 26
        let width = text.widthWithConstrainedHeight(height, font: label.font)+34
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        backgroundColor = UIColor(red: 164/255,  green: 198/255, blue: 236/255, alpha: 1)
//        layer.masksToBounds = true
        layer.cornerRadius = 4
        label.text = text
        addSubview(label)
        addSubview(closeButton)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func closeAction() {
        self.didClose()
    }
    
    //MAKR: - 自定义方法
    private func setupConstraints() {
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(13)
            make.centerY.equalTo(self)
        }
        closeButton.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(self)
            make.width.equalTo(30)
        }
    }
    
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var closeButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: UIControlState())
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()

}
