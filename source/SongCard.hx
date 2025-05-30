package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import Metadata.MetadataFile;

using StringTools;
using flixel.util.FlxSpriteUtil;

class SongCard extends FlxSpriteGroup 
{
    var text:FlxText;
    var bg:FlxSprite;
    var padding:Float = 10;
    public var data:MetadataFile;

    public function new(x:Float, y:Float, meta:MetadataFile) 
    {
        super(x, y);

        data = meta;

        text = new FlxText(x + padding, y + padding).setFormat(Paths.font("DK Inky Fingers.otf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.antialiasing = ClientPrefs.globalAntialiasing;
        text.text = formString();
        
        bg = new FlxSprite().makeGraphic(Std.int(text.width + (padding * 2)), Std.int(text.height + (padding * 2)), FlxColor.BLACK);
        bg.alpha = 0.8;

        add(bg);
        add(text);
    }

    public function formString():String
    {
        return 'Song: ${data.song.name.join}\nArtists: ${data.song.artist}';
    }

    public function display() {
        var initX:Float = this.x;

        FlxTween.tween(this, {x: initX + this.width}, 0.65, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween) {
            FlxTween.tween(this, {x: initX}, 0.65, {ease: FlxEase.cubeInOut, startDelay: 24, onComplete: function(twn:FlxTween) {
                this.destroy();
            }});
        }});
    }
}