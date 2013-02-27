package utils{

	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.Capabilities;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class Utilities
	{
		[Bindable]
		public var isCompressionSelected:Boolean=false;

		
		
		public var javaBinPath:String="";
		//public var freeMindPath:String="";
		
		public var freeMindPath:String;
		
		[Bindable]
		/**
		 * Process is used to carry out sas processes as a native process by executing Sas.exe.
		 * This is made public to help tracking the native process end and carry out specific task on the process end.
		 * */
		public var process:NativeProcess;
		
		public function Utilities()
		{
		}
		
		/**
		 *Saves file in to local file system
		 */
		public function saveFile(data:String, filePath:String):void
		{
			var file:File=File.desktopDirectory.resolvePath(filePath);
			var pstream:FileStream=new FileStream();
			pstream.open(file, FileMode.WRITE);
			pstream.writeUTFBytes(data);
			pstream.close();
		}
		
		/**
		 *Creates a directory or a folder.
		 */
		public function createFolder(filePath:String):void
		{
			var dir:File=File.applicationDirectory.resolvePath(filePath);
			dir.createDirectory()
		}

		
		/**
		 * Reads file content from application  directory and returns as a string.
		 * @param filePath : file path in application directory.
		 * @return file contents as string.
		 * 
		 */
		public function readApplicationFile(filePath:String):String {
			var file:File=File.applicationDirectory.resolvePath(filePath);
			var fileData:String="";
			if (file.exists)
			{
				var fileStream:FileStream=new FileStream();
				fileStream.open(file, FileMode.READ);
				fileData=fileStream.readUTFBytes(fileStream.bytesAvailable);
				fileStream.close();
			}
			return fileData;
		}
		
		/**
		 *Deletes folder from local file system if present.
		 */
		public function deleteFolder(filePath:String):void
		{
			var dir:File=File.desktopDirectory.resolvePath(filePath);
			if (filePath == "")
			{
				return;
			}
			if (dir.exists)
			{
				dir.deleteDirectory(true);
			}
			else
			{
				return;
			}
		}
		
		/**
		 * Description: Deletes file from local file system.
		 * Author     : Vijaya.Reddy
		 * Date       : Nov 8th 2012
		 * param      : file path
		 * return     : void
		 * */
		public function deleteFile(filePath:String):void
		{
			var file:File=File.desktopDirectory.resolvePath(filePath);
			if (filePath == "")
			{
				return;
			}
			if (file.exists)
			{
				try
				{
					file.deleteFile();	
				}catch(e:Error)
				{
					trace(e.message);	
				}
				
			}
			else
			{
				return;
			}
		}
		
		/**
		 *Reads file content from local file system and returns as a string.
		 */
		public function readFile(filePath:String):String{
			var file:File=File.desktopDirectory.resolvePath(filePath);
			var dataRead:String="";
			if (file.exists)
			{
				var pstream:FileStream=new FileStream();
				pstream.open(file, FileMode.READ);
				dataRead=pstream.readUTFBytes(pstream.bytesAvailable);
				pstream.close();
			}
			return dataRead;
		}
		
		
		public function handleError(evt:Event):void{
			trace(evt);
			trace(process.standardError.readUTFBytes(process.standardError.bytesAvailable))
		}
		/**
		 @Description:check whether file exist or not
		 @Author: Nikitha
		 @Date: 11 Nov 2012
		 @param: IndexChangeEvent
		 @return: void
		 @Modified by:None
		 @Modified on:None
		 @Change Description:None
		 */
		public function fileExists(filePath:String):Boolean
		{
			var file:File=File.desktopDirectory.resolvePath(filePath);
			if (file.exists)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		/**
		 @Description:whether file exist or not
		 @Author: Nikitha
		 @Date: 11 Nov 2012
		 @param: IndexChangeEvent
		 @return: void
		 @Modified by:None
		 @Modified on:None
		 @Change Description:None
		 */
		public function doesFileExist(filePath:String, extnList:ArrayCollection):Boolean
		{			
			for(var extnCount:int=0; extnCount<extnList.length; extnCount++)
			{
				var file:File=File.desktopDirectory.resolvePath(filePath + extnList.getItemAt(extnCount));
				if (file.exists)
				{
					return true;
				}
			}
			return false;
		}
		/**
		 @Description:Returns the folder location where  sas-code files reside
		 @Author: Nikitha
		 @Date: 11 Nov 2012
		 @param: IndexChangeEvent
		 @return: void
		 @Modified by:None
		 @Modified on:None
		 @Change Description:None
		 */
		public function templatePath():String
		{
			var pathName:String="com\\musigma\\muPDNA\\templates";
			var file:File=File.applicationDirectory.resolvePath(pathName);
			var filepath:String=file.nativePath;
			return filepath;
		}
		public function replaceBackSlashToForwardSlash(originalString:String,seperator:String):String
		{
			var pattern:RegExp=/\\/g;
			var replacedString:String=originalString.replace(pattern,seperator);			
			return replacedString;
		}
	}
}