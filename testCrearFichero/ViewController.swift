//
//  ViewController.swift
//  testCrearFichero
//
//  Created by Manuel Citious on 19/1/16.
//  Copyright © 2016 Citious Team. All rights reserved.
//

import UIKit
import SSZipArchive

class ViewController: UIViewController {
    let cabeceraTxt = "# Track file\n# (milliseconds since start) (track type) (track rect x0 y0 x1 y1)"
    let versionTxt = "1"
    let numberOfFrames = 25
    var completeText = ""
    var fileManager = NSFileManager()
    var tmpDir: NSString = NSTemporaryDirectory()
    let fileName = "tracking2.txt"

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        completeText = cabeceraTxt + "\n" + versionTxt + "\n" + "\(numberOfFrames)"
        for(var i=0; i<numberOfFrames; i++){
            completeText += "\n" + "\(i)"
        }
    }
    @IBAction func crearFichero(sender: AnyObject) {
        let path = tmpDir.stringByAppendingPathComponent(fileName)
        //writing
        do {
            try completeText.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
            print("Archivo creado")
        }
        catch let error as NSError{
            print("Error al crear el archivo")
            print(error.localizedDescription)
        }
    }
    
    @IBAction func leerFichero(sender: AnyObject) {
        let path = tmpDir.stringByAppendingPathComponent(fileName)
        //reading
        do {
            let text2 = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            print(text2)
        }
        catch let error as NSError{
            print("Error al leer el archivo")
            print(error.localizedDescription);
        }
    }

    @IBAction func listadoFicheros(sender: AnyObject) {
        do{
            let filesInDirecotry = try fileManager.contentsOfDirectoryAtPath(tmpDir as String)
            for file in filesInDirecotry{
                print(file)
            }
        }catch let error as NSError{
            print("Error al obtener el listado de archivos")
            print(error.localizedDescription);
        }
    }
    @IBAction func comprimirFicheros(sender: AnyObject) {
        let zipPath = tmpDir.stringByAppendingPathComponent("archivo.zip")
        SSZipArchive.createZipFileAtPath(zipPath, withContentsOfDirectory: tmpDir as String)
    }
}

