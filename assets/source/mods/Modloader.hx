import sys.io.Process;
import sys.FileSystem;
import sys.io.File;

class ModLoader {
    static function main() {
        var modDir = "mods/";
        
        if (!FileSystem.exists(modDir) || !FileSystem.isDirectory(modDir)) {
            trace("Mod directory not found.");
            return;
        }

        var files = FileSystem.readDirectory(modDir);
        
        for (file in files) {
            var filePath = modDir + file;
            
            if (FileSystem.isFile(filePath) && isExecutable(filePath)) {
                trace("Executing mod: " + file);
                runExecutable(filePath);
            }
        }
    }

    static function isExecutable(path:String):Bool {
        // Basic check: Only allow .exe on Windows or no extension on Unix-like systems
        return path.endsWith(".exe") || (!path.contains(".") && Sys.systemName() != "Windows");
    }

    static function runExecutable(path:String) {
        try {
            var process = new Process(path, []);
            var output = process.stdout.readAll().toString();
            trace("Mod Output: " + output);
            process.close();
        } catch (e:Dynamic) {
            trace("Error executing mod: " + e);
        }
    }
}
