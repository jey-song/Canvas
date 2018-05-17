//
//  CanvasLayer.swift
//  Canvas
//
//  Created by Adeola Uthman on 2/10/18.
//

import Foundation

/** A single layer that can be drawn on. The Canvas can have multiple layers which can be rearranged to have different drawings appear on top of or below others. */
public class CanvasLayer: NSObject, Codable {
    
    /************************
     *                      *
     *       VARIABLES      *
     *                      *
     ************************/
    
    // -- PRIVATE VARS --
    
    /** The canvas that this layer is on. */
    internal var canvas: Canvas!
    
    /** The next node to be drawn on the screen, whether that be a curve, a line, or a shape. */
    internal var nextNode: Node?
    
    /** The (possibly nil) node that is selected and being moved. */
    internal var selectNode: Node?
    
    /** The image that the user is drawing on. */
    internal var drawImage: UIImage?
    
    /** The background drawing in case the user wants to import an image. */
    internal var backgroundImage: UIImage?
    
    /** All of the nodes on this layer. */
    var nodeArray: [Node]!
    
    /** The array of shape layers (drawings). */
    var shapeLayers: [CAShapeLayer]!
    
    
    // -- PUBLIC VARS --
    
    /** Whether or not this layer is visible. True by default. */
    public var isVisible: Bool
    
    /** Whether or not this layer allows drawing. True by default. */
    public var allowsDrawing: Bool
    
    /** The opacity of everything on this layer. */
    public var opacity: CGFloat {
        didSet {
            if backgroundImage != nil { backgroundImage = backgroundImage?.withOpacity(opacity) }
            drawImage = drawImage?.withOpacity(opacity)
            for node in nodeArray {
                var c = node.brush.color
                c = c.withAlphaComponent(opacity)
                node.brush.color = c
            }
            self.updateLayer(redraw: false)
            canvas.setNeedsDisplay()
        }
    }
    
    /** A name for this layer (optional). */
    public var name: String?
    
    
    // -- PUBLIC COMPUTED VARS --
    
    /** Returns the number of nodes on this layer. */
    public var nodeCount: Int { return self.nodeArray.count }
    
    
    
    
    
    
    
    
    
    /************************
     *                      *
     *         INIT         *
     *                      *
     ************************/
    
    public required init?(coder aDecoder: NSCoder) {
        canvas = aDecoder.decodeObject(forKey: "canvas_canvasLayer_canvas") as! Canvas
        nextNode = aDecoder.decodeObject(forKey: "canvas_canvasLayer_nextNode") as? Node
        drawImage = aDecoder.decodeObject(forKey: "canvas_canvasLayer_drawImage") as? UIImage
        backgroundImage = aDecoder.decodeObject(forKey: "canvas_canvasLayer_backgroundImage") as? UIImage
        nodeArray = aDecoder.decodeObject(forKey: "canvas_canvasLayer_nodeArray") as! [Node]
        isVisible = aDecoder.decodeBool(forKey: "canvas_canvasLayer_isVisible")
        allowsDrawing = aDecoder.decodeBool(forKey: "canvas_canvasLayer_allowsDrawing")
        opacity = CGFloat(aDecoder.decodeFloat(forKey: "canvas_canvasLayer_opacity"))
        name = aDecoder.decodeObject(forKey: "canvas_canvasLayer_name") as? String
        shapeLayers = []
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CanvasLayerCodingKeys.self)
        canvas = try container.decode(Canvas.self, forKey: CanvasLayerCodingKeys.canvasLayerCanvas)
        nextNode = try container.decode(Node.self, forKey: CanvasLayerCodingKeys.canvasLayerNextNode)
        
        let data1 = try container.decode(Data.self, forKey: CanvasLayerCodingKeys.canvasLayerDrawImage)
        let data2 = try container.decode(Data.self, forKey: CanvasLayerCodingKeys.canvasLayerBackgroundImage)
        drawImage = UIImage(data: data1)
        backgroundImage = UIImage(data: data2)
        
        nodeArray = try container.decode([Node].self, forKey: CanvasLayerCodingKeys.canvasLayerNodeArray)
        isVisible = try container.decode(Bool.self, forKey: CanvasLayerCodingKeys.canvasLayerIsVisible)
        allowsDrawing = try container.decode(Bool.self, forKey: CanvasLayerCodingKeys.canvasLayerAllowsDrawing)
        opacity = CGFloat(try container.decode(Float.self, forKey: CanvasLayerCodingKeys.canvasLayerOpacity))
        name = try container.decode(String.self, forKey: CanvasLayerCodingKeys.canvasLayerName)
        shapeLayers = []
    }
    
    public init(canvas: Canvas) {
        nextNode = nil
        drawImage = UIImage()
        backgroundImage = nil
        nodeArray = []
        isVisible = true
        allowsDrawing = true
        name = nil
        shapeLayers = []
        self.canvas = canvas
        opacity = 1
    }
    
    
    
    
    /************************
     *                      *
     *       FUNCTIONS      *
     *                      *
     ************************/

    /** Returns a UIImage that is a combination of the background image and the drawing image. */
    internal func mergedWithBackground() -> UIImage {
        if backgroundImage == nil { return (drawImage ?? UIImage()) }
        return (backgroundImage ?? UIImage()) + (drawImage ?? UIImage())
    }
    
    
    /** Clears the drawing on this layer. */
    public func clear() {
        backgroundImage = nil
        drawImage = UIImage()
        nodeArray = []
        self.updateLayer(redraw: true)
        canvas.setNeedsDisplay()
    }
    
    
    /** Sets the image that is used to display the drawing nodes. */
    public func setDrawImage(image: UIImage, update: Bool = false) {
        self.drawImage = image
        if update == true {
            updateLayer(redraw: true)
            canvas.setNeedsDisplay()
        }
    }
    
    /** Sets the background image. */
    public func setBackgroundImage(image: UIImage?, update: Bool = false) {
        self.backgroundImage = image
        if update == true {
            updateLayer(redraw: true)
            canvas.setNeedsDisplay()
        }
    }
    
    /** Sets the nodes on this layer. */
    public func setNodes(nodes: [Node], update: Bool = false) {
        self.nodeArray = nodes
        if update == true {
            updateLayer(redraw: true)
            canvas.setNeedsDisplay()
        }
    }
    
    
    /** Returns all the nodes on this layer. */
    public func getNodes() -> [Node] {
        return self.nodeArray
    }
    
    
    /** Returns the background image of this layer. */
    public func getBackgroundImage() -> UIImage? {
        if let bg = backgroundImage { return bg }
        else { return nil }
    }
    
    
    /** Returns the drawing image. */
    public func getDrawingImage() -> UIImage {
        if let bg = drawImage { return bg }
        else { return UIImage() }
    }
    
    
    /** Takes an array of nodes as input and draws them all on this layer. */
    public func drawFrom(nodes: [Node], appending: Bool = false, background: UIImage? = nil) {
        if appending == false { self.nodeArray = nodes }
        else { self.nodeArray.append(contentsOf: nodes) }
        self.backgroundImage = background
        
        updateLayer(redraw: true)
        canvas.setNeedsDisplay()
    }
    
    
    /** Adds a node to the node array and updates the layer. */
    func addNode(node: Node) {
        self.nodeArray.append(node)
        
        updateLayer(redraw: true)
        canvas.setNeedsDisplay()
    }
    
    
    
    
    
    /************************
     *                      *
     *        DRAWING       *
     *                      *
     ************************/
    
    public func drawSVG(node: Node) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = node.path
        shapeLayer.strokeColor = canvas.currentBrush.color.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        shapeLayer.lineWidth = canvas.currentBrush.thickness
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.miterLimit = canvas.currentBrush.miter
        shapeLayers.append(shapeLayer)
    
        canvas.setNeedsDisplay()
    }
    
    
    public func draw() {
        // If there is no background image, draw at CGPoint.zero, otherwise inside frame.
        if backgroundImage == nil {
            self.drawImage?.draw(in: canvas.frame)
            self.nextNode?.draw()
        } else {
            self.backgroundImage?.draw(in: canvas.frame)
            self.drawImage?.draw(in: canvas.frame)
            self.nextNode?.draw()
        }
    }
    
    
    internal func updateLayer(redraw: Bool) {
        UIGraphicsBeginImageContextWithOptions(canvas.frame.size, false, 0)
        
        if redraw {
            drawImage = nil
            
            if backgroundImage != nil { backgroundImage?.draw(in: canvas.frame) }
            for node in nodeArray { node.draw() }
            
        } else {
            
            if backgroundImage != nil { backgroundImage?.draw(in: canvas.frame) }
            drawImage?.draw(in: canvas.frame)
            nextNode?.draw()
            
        }
        
        drawImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    
    
    
    
    /************************
     *                      *
     *        TOUCHES       *
     *                      *
     ************************/
    
    /** Handles a touch on this layer when it comes to selecting nodes. */
    func onTouch(touch: UITouch) {
        guard let selNode = selectNode else { return }
        let loc = touch.location(in: canvas)
        if !selNode.contains(point: loc) {
            selectNode = nil
            return
        }
    }
    
    /** Handles movement events on a node. */
    func onMove(touch: UITouch) {
        guard let selNode = selectNode else { return }
        
        selNode.moveNode(touch: touch, canvas: canvas)
        
        self.updateLayer(redraw: true)
        canvas.setNeedsDisplay()
        
        canvas.delegate?.didMoveNode(on: canvas, movedNode: selNode)
    }
    
    /** Handles when a touch is released. */
    func onRelease(point: CGPoint) {
        let loc = point
        
        // If you are not currently selecting a node, select one.
        if selectNode == nil {
            for node in nodeArray {
                if node.allowsSelection == false { continue }
                if node is EraserNode { continue }
                if node.contains(point: loc) {
                    selectNode = node
                    canvas.delegate?.didSelectNode(on: canvas, selectedNode: node)
                    break
                }
            }
        }
        // If you have a node selected and no node is pressed, unselect.
        else {
            for node in nodeArray {
                if node.allowsSelection == false { continue }
                if node is EraserNode { continue }
                if node.contains(point: loc) {
                    selectNode = node
                    return
                }
            }
            selectNode = nil
        }
    }
    
    
    
    

    
    
    /************************
     *                      *
     *         OTHER        *
     *                      *
     ************************/
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(canvas, forKey: "canvas_canvasLayer_canvas")
        aCoder.encode(nextNode, forKey: "canvas_canvasLayer_nextNode")
        aCoder.encode(drawImage, forKey: "canvas_canvasLayer_drawImage")
        aCoder.encode(backgroundImage, forKey: "canvas_canvasLayer_backgroundImage")
        aCoder.encode(nodeArray, forKey: "canvas_canvasLayer_nodeArray")
        aCoder.encode(isVisible, forKey: "canvas_canvasLayer_isVisible")
        aCoder.encode(allowsDrawing, forKey: "canvas_canvasLayer_allowsDrawing")
        aCoder.encode(opacity, forKey: "canvas_canvasLayer_opacity")
        aCoder.encode(name, forKey: "canvas_canvasLayer_name")
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CanvasLayerCodingKeys.self)
        try container.encode(canvas, forKey: CanvasLayerCodingKeys.canvasLayerCanvas)
        try container.encode(nextNode, forKey: CanvasLayerCodingKeys.canvasLayerNextNode)
        if let data = UIImagePNGRepresentation(drawImage ?? UIImage()) {
            try container.encode(data, forKey: CanvasLayerCodingKeys.canvasLayerDrawImage)
        }
        if let data = UIImagePNGRepresentation(backgroundImage ?? UIImage()) {
            try container.encode(data, forKey: CanvasLayerCodingKeys.canvasLayerBackgroundImage)
        }
        try container.encode(nodeArray, forKey: CanvasLayerCodingKeys.canvasLayerNodeArray)
        try container.encode(isVisible, forKey: CanvasLayerCodingKeys.canvasLayerIsVisible)
        try container.encode(allowsDrawing, forKey: CanvasLayerCodingKeys.canvasLayerAllowsDrawing)
        try container.encode(opacity, forKey: CanvasLayerCodingKeys.canvasLayerOpacity)
        try container.encode(name, forKey: CanvasLayerCodingKeys.canvasLayerName)
    }
    
    
    
}
