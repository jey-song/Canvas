//
//  ViewController.swift
//  Canvas
//
//  Created by authman2 on 01/12/2018.
//  Copyright (c) 2018 authman2. All rights reserved.
//

import UIKit
import Canvas

class ViewController: UIViewController, CanvasEvents, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /************************
     *                      *
     *       VARIABLES      *
     *                      *
     ************************/
    
    /** The background holder for the canvas so that it can have a white background. */
    lazy var canvasView: UIView = {
        let a = UIView()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.backgroundColor = .brown
        
        return a
    }()
    
    
    /** The actual canvas, which has a clear background. */
    lazy var canvas: Canvas = {
        let a = Canvas(createDefaultLayer: true)
        a.translatesAutoresizingMaskIntoConstraints = false
        a.backgroundColor = .white
        a.delegate = self
        
        return a
    }()
    
    
    
    
    lazy var colorBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Change Brush (Random)", for: .normal)
        a.backgroundColor = UIColor.gray
        a.addTarget(self, action: #selector(newColor), for: .touchUpInside)
        
        return a
    }()
    
    lazy var toolBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Change Tool (Random)", for: .normal)
        a.backgroundColor = UIColor.lightGray
        a.addTarget(self, action: #selector(newTool), for: .touchUpInside)
        
        return a
    }()
    
    lazy var undoBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Undo", for: .normal)
        a.backgroundColor = UIColor.lightGray
        a.addTarget(self, action: #selector(undo), for: .touchUpInside)
        
        return a
    }()
    
    lazy var redoBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Redo", for: .normal)
        a.backgroundColor = UIColor.gray
        a.addTarget(self, action: #selector(redo), for: .touchUpInside)
        
        return a
    }()
    
    lazy var clearBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Clear", for: .normal)
        a.backgroundColor = UIColor.gray
        a.addTarget(self, action: #selector(clear), for: .touchUpInside)
        
        return a
    }()
    
    lazy var addLayerBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Add Layer", for: .normal)
        a.backgroundColor = UIColor.lightGray
        a.addTarget(self, action: #selector(addLayer), for: .touchUpInside)
        
        return a
    }()
    
    lazy var switchLayerBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Switch Layer (Random)", for: .normal)
        a.backgroundColor = UIColor.gray
        a.addTarget(self, action: #selector(switchLayer), for: .touchUpInside)
        
        return a
    }()
    
    lazy var importBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Import Image", for: .normal)
        a.backgroundColor = UIColor.gray
        a.addTarget(self, action: #selector(importImage), for: .touchUpInside)
        
        return a
    }()
    
    lazy var exportBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Export Image", for: .normal)
        a.backgroundColor = UIColor.lightGray
        a.addTarget(self, action: #selector(exportImage), for: .touchUpInside)
        
        return a
    }()
    
    lazy var selectBtn: UIButton = {
        let a = UIButton()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.setTitle("Select Tool", for: .normal)
        a.backgroundColor = UIColor.lightGray
        a.addTarget(self, action: #selector(selectTool), for: .touchUpInside)
        
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
        canvasView.addSubview(canvas)
        view.addSubview(canvasView)
        view.addSubview(colorBtn)
        view.addSubview(undoBtn)
        view.addSubview(redoBtn)
        view.addSubview(clearBtn)
        view.addSubview(addLayerBtn)
        view.addSubview(switchLayerBtn)
        view.addSubview(toolBtn)
        view.addSubview(importBtn)
        view.addSubview(exportBtn)
        view.addSubview(selectBtn)
        
        setupLayout()
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(zoom(sender:)))
        view.addGestureRecognizer(pinch)
    }
    
    
    
    
    /************************
     *                      *
     *        DELEGATE      *
     *                      *
     ************************/
    
    func willBeginDrawing(on canvas: Canvas) {
        
    }
    
    func isDrawing(on canvas: Canvas) {
        
    }
    
    func didFinishDrawing(on canvas: Canvas) {
//        canvas.currentTool = .paint
        canvas.currentBrush.opacity = 0.4
        print("Switched to eraser")
    }
    
    func didSampleColor(on canvas: Canvas, sampledColor color: UIColor) {
        print("Sampled color: \(color.rgba)")
    }
    
    func didPaintNodes(on canvas: Canvas, nodes: [Node], strokeColor: UIColor, fillColor: UIColor?) {
        print("Painted nodes: \(nodes) with color: \(strokeColor.rgba)")
    }
    
    
    
    /************************
     *                      *
     *       FUNCTIONS      *
     *                      *
     ************************/
    
    @objc func newColor() {
        
    }
    
    @objc func newTool() {
        
    }
    
    @objc func selectTool() {
        
    }
    
    @objc func undo() {
        
    }
    
    @objc func redo() {
        
    }
    
    @objc func clear() {
        
    }
    
    @objc func addLayer() {
        alert(title: "New Layer", message: "Added a new layer to the canvas.")
    }
    
    @objc func switchLayer() {
        
    }
    
    @objc func importImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker: UIImagePickerController = {
                let a = UIImagePickerController()
                a.delegate = self
                a.sourceType = .photoLibrary
                a.allowsEditing = false
                return a
            }()
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func exportImage() {
        
        // Alert export success.
        alert(title: "Exported!", message: "Your drawing has been saved to the photo album.")
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        self.show(alert, sender: self)
    }
    
    
    
    /************************
     *                      *
     *        LAYOUT        *
     *                      *
     ************************/
    
    @objc func zoom(sender: UIPinchGestureRecognizer) {
        let transform = canvas.transform.scaledBy(x: sender.scale, y: sender.scale)
        canvas.transform = transform
        sender.scale = 1.0
    }
    
    
    func setupLayout() {
        canvasView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        
        canvas.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        canvas.topAnchor.constraint(equalTo: canvasView.topAnchor).isActive = true
        canvas.widthAnchor.constraint(equalTo: canvasView.widthAnchor).isActive = true
        canvas.heightAnchor.constraint(equalTo: canvasView.heightAnchor).isActive = true
        
        colorBtn.topAnchor.constraint(equalTo: canvasView.bottomAnchor).isActive = true
        colorBtn.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor).isActive = true
        colorBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        colorBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true

        undoBtn.topAnchor.constraint(equalTo: colorBtn.bottomAnchor).isActive = true
        undoBtn.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor).isActive = true
        undoBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        undoBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true

        redoBtn.topAnchor.constraint(equalTo: undoBtn.bottomAnchor).isActive = true
        redoBtn.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor).isActive = true
        redoBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        redoBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true

        addLayerBtn.topAnchor.constraint(equalTo: redoBtn.bottomAnchor).isActive = true
        addLayerBtn.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor).isActive = true
        addLayerBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        addLayerBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true

        switchLayerBtn.topAnchor.constraint(equalTo: addLayerBtn.bottomAnchor).isActive = true
        switchLayerBtn.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor).isActive = true
        switchLayerBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        switchLayerBtn.heightAnchor.constraint(equalToConstant: 67).isActive = true
        
        toolBtn.topAnchor.constraint(equalTo: canvasView.bottomAnchor).isActive = true
        toolBtn.leadingAnchor.constraint(equalTo: colorBtn.trailingAnchor).isActive = true
        toolBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        toolBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        importBtn.topAnchor.constraint(equalTo: toolBtn.bottomAnchor).isActive = true
        importBtn.leadingAnchor.constraint(equalTo: colorBtn.trailingAnchor).isActive = true
        importBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        importBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        exportBtn.topAnchor.constraint(equalTo: importBtn.bottomAnchor).isActive = true
        exportBtn.leadingAnchor.constraint(equalTo: colorBtn.trailingAnchor).isActive = true
        exportBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        exportBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        clearBtn.topAnchor.constraint(equalTo: exportBtn.bottomAnchor).isActive = true
        clearBtn.leadingAnchor.constraint(equalTo: colorBtn.trailingAnchor).isActive = true
        clearBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        clearBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        selectBtn.topAnchor.constraint(equalTo: clearBtn.bottomAnchor).isActive = true
        selectBtn.leadingAnchor.constraint(equalTo: colorBtn.trailingAnchor).isActive = true
        selectBtn.widthAnchor.constraint(equalTo: canvasView.widthAnchor, multiplier: 0.5).isActive = true
        selectBtn.heightAnchor.constraint(equalToConstant: 67).isActive = true
    }
    
    
}

