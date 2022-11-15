import SceneKit
import UIKit
import PlaygroundSupport

// MARK: - Helper methods

func makePentagon(radius: Float) -> [SCNVector3] {
	var vertices: [SCNVector3] = []

	var angle: Float = .pi / 2
	let deltaAngle = (2 * .pi) / Float(5)
	for _ in 0..<5 {
		let vertexCoord = SIMD3<Float>(radius * cos(angle),
									   radius * sin(angle),
									   0)

		let vertex = SCNVector3(vertexCoord)

		vertices.append(vertex)
		angle += deltaAngle
	}

	vertices.append(SCNVector3(SIMD3<Float>(0, 0, 0)))
	return vertices
}

func makeConeWithPentagonAtTheBase(radius: Float, height: Float) -> [SCNVector3] {
	var pentagonVertices = makePentagon(radius: radius)
	pentagonVertices.append(SCNVector3(SIMD3<Float>(0, 0, height)))
	return pentagonVertices
}

let sceneSize = CGSize(width: 600, height: 600)
let sceneFrame = CGRect(origin: .zero, size: sceneSize)
var sceneView = SCNView(frame: sceneFrame)
var scene = SCNScene()

sceneView.scene = scene
sceneView.backgroundColor = UIColor.gray

PlaygroundPage.current.liveView = sceneView

// MARK: - Lab 1

//sceneView.allowsCameraControl = false
//var cameraNode = SCNNode()
//cameraNode.camera = SCNCamera()
//cameraNode.position = SCNVector3(20, 20, 20)
//cameraNode.look(at: SCNVector3(0, 0, 0))
//scene.rootNode.addChildNode(cameraNode)
//
//let indices: [UInt16] = [
//	0, 1, 5,
//	1, 2, 5,
//	2, 3, 5,
//	3, 4, 5,
//	4, 0, 5,
//]
//
//let vertices = makePentagon(radius: 15)
//let positionSource = SCNGeometrySource(vertices: vertices)
//let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
//
//let colors: [SCNVector3] = [SCNVector3(0.3, 0.2, 0.4),
//							SCNVector3(0.1, 0.44, 0.5),
//							SCNVector3(0.8, 0.1, 0.6),
//							SCNVector3(0.3, 0.4, 0.6),
//							SCNVector3(0.1, 0.2, 0.1),
//]
//
//let normals = Array(repeating: SCNVector3(0, 0, 1), count: 6)
//
//let normalSource = SCNGeometrySource(normals: normals)
//let colorData = NSData(bytes: colors, length: MemoryLayout<SCNVector3>.size * colors.count) as Data
//let colorSource = SCNGeometrySource(data: colorData,
//									semantic: SCNGeometrySource.Semantic.color,
//									vectorCount:colors.count,
//									usesFloatComponents: true,
//									componentsPerVector: 3,
//									bytesPerComponent: MemoryLayout<Float>.size,
//									dataOffset: 0,
//									dataStride: MemoryLayout<SCNVector3>.size)
//
//
//let light = SCNLight()
//light.type = .ambient
//light.color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
//
//cameraNode.light = light
//let geometry = SCNGeometry(sources: [positionSource, colorSource], elements: [element])
//let node = SCNNode(geometry: geometry)
//scene.rootNode.addChildNode(node)


// MARK: - Lab 2 && 3

sceneView.allowsCameraControl = true

var cameraNode = SCNNode()
cameraNode.camera = SCNCamera()
cameraNode.position = SCNVector3(10, 10, 10)
cameraNode.look(at: SCNVector3(0, 0, 0))
scene.rootNode.addChildNode(cameraNode)

let indices: [UInt16] = [
	0, 1, 5,
	1, 2, 5,
	2, 3, 5,
	3, 4, 5,
	4, 0, 5,
	0, 6, 1,
	1, 6, 2,
	2, 6, 3,
	3, 6, 4,
	4, 6, 0,
]

let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)

// Vertices

let vertices = makeConeWithPentagonAtTheBase(radius: 3, height: 5)
let positionSource = SCNGeometrySource(vertices: vertices)

// Normals

var normals = Array(repeating: SCNVector3(0, 0, 1), count: 7)
let normalSource = SCNGeometrySource(normals: normals)

// UV Coords

let uvCoords: [SIMD2<Float>] = [
	SIMD2<Float>(1/12, 0),
	SIMD2<Float>(0, 0.5),
	SIMD2<Float>(1/12, 1),
	SIMD2<Float>(1/6, 0.5),

	SIMD2<Float>(3/12, 0),
	SIMD2<Float>(1/6, 0.5),
	SIMD2<Float>(3/12, 1),
	SIMD2<Float>(2/6, 0.5),

	SIMD2<Float>(5/12, 0),
	SIMD2<Float>(2/6, 0.5),
	SIMD2<Float>(5/12, 1),
	SIMD2<Float>(3/6, 0.5),
]

let uvCoordsData = NSData(bytes: uvCoords, length: MemoryLayout<SIMD2<Float>>.size * uvCoords.count) as Data
let uvCoordsSource = SCNGeometrySource(data: uvCoordsData,
									   semantic: SCNGeometrySource.Semantic.texcoord,
									   vectorCount: uvCoords.count,
									   usesFloatComponents: true,
									   componentsPerVector: 2,
									   bytesPerComponent: MemoryLayout<Float>.size,
									   dataOffset: 0,
									   dataStride: MemoryLayout<SIMD2<Float>>.size)

// Colors
let colors: [SCNVector3] = [SCNVector3(0.3, 0.2, 0.4),
							SCNVector3(0.1, 0.44, 0.5),
							SCNVector3(0.8, 0.1, 0.6),
							SCNVector3(0.3, 0.4, 0.6),
							SCNVector3(0.1, 0.2, 0.1),
							SCNVector3(0.6, 0.23, 0.85)
]

let colorData = NSData(bytes: colors, length: MemoryLayout<SCNVector3>.size * colors.count) as Data
let colorSource = SCNGeometrySource(data: colorData,
									semantic: SCNGeometrySource.Semantic.color,
									vectorCount:colors.count,
									usesFloatComponents: true,
									componentsPerVector: 3,
									bytesPerComponent: MemoryLayout<Float>.size,
									dataOffset: 0,
									dataStride: MemoryLayout<SCNVector3>.size)

let light = SCNLight()
light.type = .directional
light.color = UIColor.white

cameraNode.light = light

let geometry = SCNGeometry(sources: [positionSource,
									 normalSource,
									 //colorSource,
									 uvCoordsSource], elements: [element])
let node = SCNNode(geometry: geometry)
let material = SCNMaterial()

material.diffuse.contents = #imageLiteral(resourceName: "num.png")
geometry.materials = [material]
material.lightingModel = .physicallyBased
scene.rootNode.addChildNode(node)


//let cube = SCNBox(width: 20, height: 20, length: 20, chamferRadius: 0.01)
//let material = SCNMaterial()
//
//material.diffuse.contents = #imageLiteral(resourceName: "metal.jpeg")
//cube.materials = [material]
//
//let node2 = SCNNode()
//
//node2.position = SCNVector3(x:0 , y: 0.1, z: -0.5)
//node2.geometry = cube
//scene.rootNode.addChildNode(node2)
