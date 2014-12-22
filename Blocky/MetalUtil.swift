//
//  MetalUtil.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-21.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import UIKit
import Metal

func imageToTexture(image: UIImage, device: MTLDevice) -> MTLTexture {
	let bytesPerPixel = 8 * 4
	let bytesPerComponent = 4
	let bitsPerComponent = bytesPerComponent * 8
	let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
	
	let imageRef = image.CGImage
	let imageWidth = CGImageGetWidth(imageRef)
	let imageHeight = CGImageGetHeight(imageRef)
	let bytesPerRow = bytesPerPixel * Int(imageWidth)
	var rawData = [UInt8](count: Int(imageWidth * imageHeight * 4), repeatedValue: 0)
	let bitmapInfo = CGBitmapInfo(CGBitmapInfo.ByteOrder32Big.rawValue | CGImageAlphaInfo.PremultipliedLast.rawValue)
	let context = CGBitmapContextCreate(&rawData, UInt(imageWidth), UInt(imageHeight), UInt(bitsPerComponent),
		UInt(bytesPerRow), rgbColorSpace, bitmapInfo)
	CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(imageWidth), CGFloat(imageHeight)), imageRef)
	
	let textureDescriptor = MTLTextureDescriptor.texture2DDescriptorWithPixelFormat(MTLPixelFormat.RGBA8Unorm, width: Int(imageWidth), height: Int(imageHeight), mipmapped: true)
	let texture = device.newTextureWithDescriptor(textureDescriptor)
	let region = MTLRegionMake2D(0, 0, Int(imageWidth), Int(imageHeight))
	texture.replaceRegion(region, mipmapLevel: 0, withBytes: &rawData, bytesPerRow: Int(bytesPerRow))
	
	return texture
}

func imageOfTextureSize(inTexture: MTLTexture, device: MTLDevice) -> MTLTexture {
	let textureDescriptor = MTLTextureDescriptor.texture2DDescriptorWithPixelFormat(inTexture.pixelFormat, width: inTexture.width, height: inTexture.height, mipmapped: false)
	let texture = device.newTextureWithDescriptor(textureDescriptor)
	
	return texture
}

func textureToImage(texture: MTLTexture, device: MTLDevice) -> UIImage {
	let imageSize = CGSize(width: texture.width, height: texture.height)
	let bytesPerPixel: UInt = 8 * 4
	let bytesPerComponent = 4
	let bytesPerRow: UInt = bytesPerPixel * UInt(imageSize.width)
	let bitsPerPixel = bytesPerPixel * 4
	let bitsPerComponent = bytesPerComponent * 8
	let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
	
	let imageByteCount = Int(imageSize.width * imageSize.height * 4)
	//let bytesPerRow = bytesPerPixel * UInt(imageSize.width)
	var imageBytes = [UInt8](count: imageByteCount, repeatedValue: 0)
	let region = MTLRegionMake2D(0, 0, Int(imageSize.width), Int(imageSize.height))
	texture.getBytes(&imageBytes, bytesPerRow: Int(bytesPerRow), fromRegion: region, mipmapLevel: 0)
	
	let providerRef = CGDataProviderCreateWithCFData(
		NSData(bytes: &imageBytes, length: imageBytes.count * sizeof(UInt8))
	)
	let bitmapInfo = CGBitmapInfo(CGBitmapInfo.ByteOrder32Big.rawValue | CGImageAlphaInfo.PremultipliedLast.rawValue)
	let renderingIntent = kCGRenderingIntentDefault
	let imageRef = CGImageCreate(UInt(imageSize.width), UInt(imageSize.height), UInt(bitsPerComponent), bitsPerPixel, bytesPerRow, rgbColorSpace, bitmapInfo, providerRef, nil, false, renderingIntent)
	
	return UIImage(CGImage: imageRef)!
}
