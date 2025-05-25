package;

import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

typedef MetadataFile = {
    var song:MetadataCard;
}

typedef MetadataCard = {
    var name:Null<String>;
    var artist:Null<String>;
    var pause:Null<String>;
}

class Metadata 
{
    public static function get(song:String):MetadataFile
    {
        try {
            var rawJson = null;

            var formattedSong:String = Paths.formatToSongPath(song);
            var path:String = formattedSong + '/meta';

            #if MODS_ALLOWED
            var moddyFile:String = Paths.modsJson(path);
            if(FileSystem.exists(moddyFile)) {
                rawJson = File.getContent(moddyFile).trim();
            }
            #end

            if(rawJson == null) {
                #if sys
                rawJson = File.getContent(Paths.json(path)).trim();
                #else
                rawJson = Assets.getText(Paths.json(path)).trim();
                #end	
            }

            while (!rawJson.endsWith("}"))
            {
                rawJson = rawJson.substr(0, rawJson.length - 1);
                // LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
            }

            return cast Json.parse(rawJson);
        }

        catch(e) {
            return null;
        }
    }
}