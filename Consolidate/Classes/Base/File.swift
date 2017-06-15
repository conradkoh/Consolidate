//
//  File.swift
//  Consolidate
//
//  Created by Conrad Koh on 19/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public protocol FileDelegate{
    func FileSaveCallback(_ result:String);
    func FileErrorOccurred(_ error:String);
}

open class File{
    //==============================================
    //Delegates
    //==============================================
    open var delegate:FileDelegate?;
    
    //==============================================
    //Variables
    //==============================================
    fileprivate var _content:[String];
    fileprivate let _path:String;
    fileprivate let _directory:String;
    fileprivate let _name:String;
    
    //==============================================
    //System Variables
    //==============================================
    fileprivate let _fileManager = FileManager.default;
    
    //==============================================
    //Constructors/Initialization
    //==============================================
    
    public init(withFilename fileName:String){
        _content = [String]();
        _name = fileName;
        
        //
        let basePaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        _directory = basePaths[0];
        _path = _directory + "/" + _name;
        
    }
    
    //==============================================
    //Private Methods
    //==============================================
    fileprivate func FileExists() -> Bool{
        if(_fileManager.fileExists(atPath: _path)){
            return true;
        }
        else{
            return false;
        }
    }
    
    fileprivate func BundleExists() -> Bool{
        let rangeOfFileExtension = _path.range(of: ".plist");
        let name = _path.substring(to: (rangeOfFileExtension?.lowerBound)!);
        let fileFromBundle = Bundle.main.path(forResource: name, ofType: "plist");
        if(_fileManager.fileExists(atPath: fileFromBundle!)){
            return true;
        }
        else{
            return false;
        }
    }
    
    fileprivate func WriteContentsToFile(){
        //assumes that file exists at path
        let array = NSMutableArray();
        for line in _content{
            array.add(line);
        }
        array.write(toFile: _path, atomically: true);
    }
    
    fileprivate func LoadFileContent(){
        _content = [String]();
        let fileExists = FileExists();
        var shouldLoad = true;
        if(!fileExists && !BundleExists()){
            shouldLoad = false;
            delegate?.FileErrorOccurred(Constants.ERROR_FILEMISSINGFROMBUNDLE);
        }
        
        if(shouldLoad){
            let array = NSMutableArray.init(contentsOfFile: _path);
            
            if(array != nil){
                for item in array!{
                    let line = item as? String;
                    if (line != nil){
                        _content.append(line!);
                    }
                }
            }
        }
        else{
            delegate?.FileErrorOccurred(Constants.ERROR_FILEDOESNOTEXIST);
        }
    }
    
    //==============================================
    //Public Methods
    //==============================================
    
    open func SetFileContent(_ content:[String]){
        _content = content;
    }
    
    open func Save(){
        let fileExists = FileExists();
        var status:String;
        if(fileExists){
            self.WriteContentsToFile();
            status = Constants.SAVE_SUCCEEDED;
        }
        else{
            status = Constants.ERROR_FILEDOESNOTEXIST;
        }
        delegate?.FileSaveCallback(status);
    }
    
    open class Constants{
        open static let SAVE_SUCCEEDED = "Save succeeded";
        open static let LOAD_SUCCEEDED = "Load succeeded";
        open static let ERROR_FILEDOESNOTEXIST = "Error: File does not exist";
        open static let ERROR_FILEMISSINGFROMBUNDLE = "Error: Try adding %s to bundle";
    }
}
