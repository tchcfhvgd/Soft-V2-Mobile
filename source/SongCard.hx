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
    public var data:MetadataFile;

    public function new(x:Float, y:Float, meta:MetadataFile) 
    {
        super(x, y);

        data = meta;

        text = new FlxText(x + 30, y + 80, 0, "", 24).setFormat(Paths.font("DK Inky Fingers.otf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.antialiasing = ClientPrefs.globalAntialiasing;
        text.text = formString();
        
        var bg = new FlxSprite(x, y + 60).loadGraphic(Paths.image('credit_card', 'shared'));

        add(bg);
        add(text);
    }

    public function formString():String
    {
        return 'Song: ${data.song.name}\nArtist: ${data.song.artist}';
    }

    public function display() {
        var initX:Float = this.x;

        FlxTween.tween(this, {x: initX + this.width}, 1, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween) {
            FlxTween.tween(this, {x: initX}, 1, {ease: FlxEase.cubeInOut, startDelay: 4, onComplete: function(twn:FlxTween) {
                this.destroy();
            }});
        }});
    }
}