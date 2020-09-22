//
//  ImageDetailView.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 21/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//


import UIKit
import Kingfisher

class ImageDetailView: UIView {
    let detailImageView = UIImageView()
    let backgroundView = UIView()
    var originalImageView: UIImageView?
    var zoomView = UIScrollView()
    var tapgesture: UIGestureRecognizer?
    func showDetail(_ imageView: UIImageView, url: URL?, viewContainer: UIView) {
        self.originalImageView = imageView
        
        
        
        setupBackground()
        setupImageDetail(imageView, url: url, viewContainer: viewContainer)

        
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = detailImageView.frame.size.height / scale
        zoomRect.size.width = detailImageView.frame.size.width / scale
        let newCenter = detailImageView.convert(center, from: detailImageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    private func setupImageDetail(_ imageView: UIImageView, url: URL?, viewContainer: UIView) {
        imageView.alpha = 0
        
        detailImageView.kf.setImage(with: url) { [weak self] (result) in
            switch result {
            case .success(_):
                let originalFrame = viewContainer.convert(imageView.frame, to: nil)
                self?.detailImageView.frame = originalFrame
                self?.detailImageView.isUserInteractionEnabled = true
                self?.detailImageView.contentMode = .scaleAspectFit
                self?.detailImageView.clipsToBounds = true
                self?.animateTransition()
                self?.setupZoomView()
                self?.setUpDoubleTapHandler()
                self?.addBackButton()
            case .failure:
                break
            }
        }
        
    }
    
    private func setupBackground() {
        backgroundView.frame = frame
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        addSubview(backgroundView)
    }
    private func setUpDoubleTapHandler() {
        tapgesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        detailImageView.addGestureRecognizer(tapgesture ?? UIGestureRecognizer())
    }
    
    private func setupZoomView() {
        zoomView.frame = frame
        zoomView.delegate = self
        zoomView.minimumZoomScale = 1.0
        zoomView.maximumZoomScale = 2.0
        zoomView.addSubview(detailImageView)
        addSubview(zoomView)
    }
    
    private func animateTransition() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.detailImageView.frame =  CGRect(x: 0,
                                                 y: self.frame.height * 0.2 / 2,
                                                 width: self.frame.width,
                                                 height: self.frame.height * 0.8)
            
            self.backgroundView.alpha = 1
        }) { _ in

        }
    }
    
    private func addBackButton() {
        let backButton = UIButton()
        let backColor = UIColor.white
        let backImage = UIImage(named: "backIconLight")
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = backColor
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func handleDoubleTap() {
        if zoomView.zoomScale == 1.0 {
            let rect = zoomRectForScale(2.0, center: tapgesture?.location(in: detailImageView) ?? CGPoint())
            zoomView.zoom(to: rect, animated: true)
        } else {
            zoomView.setZoomScale(1.0, animated: true)
        }
    }
    
    @objc func dismissView() {
        if let originalFrame = originalImageView?.frame {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.zoomView.setZoomScale(1.0, animated: true)
                self.detailImageView.frame = originalFrame
                self.backgroundView.alpha = 0
            }) { (completed) in
                self.detailImageView.removeFromSuperview()
            
                self.removeFromSuperview()
                self.originalImageView?.alpha = 1
            }
        } else {
            self.removeFromSuperview()
        }
    }
}

extension ImageDetailView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.detailImageView
    }
    

}

