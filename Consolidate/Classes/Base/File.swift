//
//  File.swift
//  Consolidate
//
//  Created by Conrad Koh on 19/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public protocol FileDelegate{
    func FileSaveCallback(result:String);
    func FileErrorOccurred(error:String);
}

public class File{
    //==============================================
    //Delegates
    //==============================================
    public var delegate:FileDelegate?;
    
    //==============================================
    //Variables
    //==============================================
    private var _content:[String];
    private let _path:String;
    private let _directory:String;
    private let _name:String;
    
    //==============================================
    //System Variables
    //==============================================
    private let _fileManager = NSFileManager.defaultManager();
    
    //==============================================
    //Constructors/Initialization
    //==============================================
    
    public init(withFilename fileName:String){
        _content = [String]();
        _name = fileName;
        
        //
        let basePaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        _directory = basePaths[0];
        _path = _directory + "/" + _name;
        
    }
    
    //==============================================
    //Private Methods
    //==============================================
    private func FileExists() -> Bool{
        if(_fileManager.fileExistsAtPath(_path)){
            return true;
        }
        else{
            return false;
        }
    }
    
    private func BundleExists() -> Bool{
        let rangeOfFileExtension = _path.rangeOfString(".plist");
        let name = _path.substringToIndex((rangeOfFileExtension?.startIndex)!);
        let fileFromBundle = NSBundle.mainBundle().pathForResource(name, ofType: "plist");
        if(_fileManager.fileExistsAtPath(fileFromBundle!)){
            return true;
        }
        else{
            return false;
        }
    }
    
    private func WriteContentsToFile(){
        //assumes that file exists at path
        let array = NSMutableArray();
        for line in _content{
            array.addObject(line);
        }
        array.writeToFile(_path, atomically: true);
    }
    
    private func LoadFileContent(){
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
    
    public func SetFileContent(content:[String]){
        _content = content;
    }
    
    public func Save(){
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
    
    public class Constants{
        public static let SAVE_SUCCEEDED = "Save succeeded";
        public static let LOAD_SUCCEEDED = "Load succeeded";
        public static let ERROR_FILEDOESNOTEXIST = "Error: File does not exist";
        public static let ERROR_FILEMISSINGFROMBUNDLE = "Error: Try adding %s to bundle";
    }
}