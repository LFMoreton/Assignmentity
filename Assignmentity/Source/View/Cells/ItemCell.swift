//
//  ItemCell.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

public class ItemCell: UITableViewCell {

    private lazy var itemView: ItemView = {
        let view = ItemView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension ItemCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(itemView)
    }

    public func setupConstraints() {
        itemView.bindFrameToSuperviewBounds()
    }

    public func additionalSetup() { }
}

extension ItemCell: Fillable {
    public func fill(data: Any) {
        itemView.fill(data: data)
        selectionStyle = .none
    }
}
