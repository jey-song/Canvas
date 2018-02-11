//
//  ViewController.swift
//  Canvas
//
//  Created by authman2 on 01/12/2018.
//  Copyright (c) 2018 authman2. All rights reserved.
//

import UIKit
import Canvas

class ViewController: UIViewController, CanvasDelegate {
    
    /************************
     *                      *
     *       VARIABLES      *
     *                      *
     ************************/
    
    lazy var canvasView: Canvas = {
        let a = Canvas()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.delegate = self
        
        return a
    }()
    
    
    
    
    lazy var colorBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Change Brush (Random)", for: .normal)
        a.backgroundColor = UIColor.gray
        
        return a
    }()
    
    lazy var undoBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Undo", for: .normal)
        a.backgroundColor = UIColor.gray
        
        return a
    }()
    
    lazy var redoBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Redo", for: .normal)
        a.backgroundColor = UIColor.gray
        
        return a
    }()
    
    lazy var addLayerBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Add Layer", for: .normal)
        a.backgroundColor = UIColor.gray
        
        return a
    }()
    
    lazy var switchLayerBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Switch Layer (Random)", for: .normal)
        a.backgroundColor = UIColor.gray
        
        return a
    }()
    
    
    
    
    
    
    
    
    
    
    /************************
     *                      *
     *         INIT         *
     *                      *
     ************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        view.addSubview(canvasView)
        //        view.addSubview(colorBtn)
        //        view.addSubview(undoBtn)
        //        view.addSubview(redoBtn)
        //        view.addSubview(addLayerBtn)
        //        view.addSubview(switchLayerBtn)
        
        setupLayout()
    }
    
    
    
    
    /************************
     *                      *
     *       FUNCTIONS      *
     *                      *
     ************************/
    
    func didBeginDrawing(_ canvas: Canvas) {
        
    }
    
    func isDrawing(_ canvas: Canvas) {
        
    }
    
    func didEndDrawing(_ canvas: Canvas) {
        canvas.currentTool = CanvasTool.eraser
    }
    
    
    
    
    
    /************************
     *                      *
     *        LAYOUT        *
     *                      *
     ************************/
    
    func setupLayout() {
        canvasView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        //
        //        colorBtn.topAnchor.constraint(equalTo: canvasView.bottomAnchor).isActive = true
        //        colorBtn.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        //        colorBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor).isActive = true
        //        colorBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //
        //        undoBtn.topAnchor.constraint(equalTo: colorBtn.bottomAnchor).isActive = true
        //        undoBtn.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        //        undoBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor).isActive = true
        //        undoBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //
        //        redoBtn.topAnchor.constraint(equalTo: undoBtn.bottomAnchor).isActive = true
        //        redoBtn.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        //        redoBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor).isActive = true
        //        redoBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //
        //        addLayerBtn.topAnchor.constraint(equalTo: redoBtn.bottomAnchor).isActive = true
        //        addLayerBtn.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        //        addLayerBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor).isActive = true
        //        addLayerBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //
        //        switchLayerBtn.topAnchor.constraint(equalTo: addLayerBtn.bottomAnchor).isActive = true
        //        switchLayerBtn.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        //        switchLayerBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor).isActive = true
        //        switchLayerBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    
}

