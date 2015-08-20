use strict;
use warnings;
use utf8;
use lib "vendor/lib/perl5";
use Imager;
use Data::Dump 'dump';

my $lua = do { local $/; <DATA> };
sub lua_to_perl {
    my $code = shift || "";
    my $areaCoords;
    $code =~ s/local /my \$/g;
    $code =~ s/ = / => /g;
    return eval "$code";
}

my $basedata = lua_to_perl($lua);

for my $key (sort keys %$basedata) {
    my $info = $basedata->{$key}{info};
    dump $basedata->{$key};
    show_layer("$key.jpg", $info);
}

sub show_layer {
    my ($filename, $info) = @_;
    my $img = Imager->new;
       $img->read(file => $filename) or die;
    
    for my $coord (values %$info) {
        $img->box(
            xmin => $img->getwidth() * $coord->{x1},
            xmax => $img->getwidth() * $coord->{x2},
            ymin => $img->getheight() * $coord->{y1},
            ymax => $img->getheight() * $coord->{y2},
            color => Imager::Color->new(0, 255, 0, 0.1),
        );
    }

    $img->write(file => "_$filename.png", type => 'png') or die;
}

__DATA__
local areaCoords = {
    ID443 = {
        area = "Warsong Gulch",
        info = {
            topLeft     = { label = "Ally %s", x1 = 0.453, x2 = 0.57, y1 = 0.08, y2 = 0.3 },
            bottomLeft  = { label = "Horde %s", x1 = 0.44, x2 = 0.56, y1 = 0.73, y2 = 0.95 },
        }
    },
    ID461 = {
        area = "Arathi Basin",
        info = {
            topLeft     = { label = "St %s", x1 = 0.33, x2 = 0.4, y1 = 0.24, y2 = 0.319 },
            topRight    = { label = "%s GM", x1 = 0.53, x2 = 0.6, y1 = 0.27, y2 = 0.37 },
            middleLeft  = { label = "AB %s", x1 = 0.432, x2 = 0.49, y1 = 0.38, y2 = 0.49 },
            bottomLeft  = { label = "LM %s", x1 = 0.37, x2 = 0.44, y1 = 0.540, y2 = 0.65 },
            bottomRight = { label = "%s Farm", x1 = 0.55, x2 = 0.62, y1 = 0.558, y2 = 0.638 },
        }
    },
    ID482 = {
        area = "Eye of the Storm",
        info = {
            topLeft     = { label = "MT %s", x1 = 0.38, x2 = 0.419, y1 = 0.395, y2 = 0.446 },
            topRight    = { label = "%s DR", x1 = 0.55, x2 = 0.582, y1 = 0.382, y2 = 0.44 },
            middleLeft  = { label = "Mid %s", x1 = 0.465, x2 = 0.5, y1 = 0.44, y2 = 0.54 },
            bottomLeft  = { label = "FRR %s", x1 = 0.39, x2 = 0.425, y1 = 0.558, y2 = 0.61 },
            bottomRight = { label = "%s BET", x1 = 0.546, x2 = 0.58, y1 = 0.55, y2 = 0.6 },
        }
    },
    ID626 = {
        area = "Twin Peaks",
        info = {
            topLeft     = { label = "Ally %s", x1 = 0.545, x2 = 0.65, y1 = 0.1, y2 = 0.29 },
            bottomLeft  = { label = "Horde %s", x1 = 0.43, x2 = 0.55, y1 = 0.74, y2 = 0.94 },
        }
    },
    ID736 = {
        area = "Battle for Gilneas",
        info = {
            topLeft     = { label = "Mine %s", x1 = 0.58, x2 = 0.652, y1 = 0.368, y2 = 0.452 },
            bottomLeft  = { label = "LH %s", x1 = 0.317, x2 = 0.395, y1 = 0.58, y2 = 0.68 },
            bottomRight = { label = "%s WW", x1 = 0.59, x2 = 0.66, y1 = 0.64, y2 = 0.76 },
        }
    },
    ID856 = {
        area = "Temple of Kotmogu",
        info = {
            topLeft     = { label = "Purple %s", x1 = 0.359, x2 = 0.43, y1 = 0.36, y2 = 0.464 },
            topRight    = { label = "%s Orange", x1 = 0.545, x2 = 0.620, y1 = 0.36, y2 = 0.464 },
            bottomLeft  = { label = "Green %s", x1 = 0.359, x2 = 0.43, y1 = 0.6, y2 = 0.702 },
            bottomRight = { label = "%s Blue", x1 = 0.545, x2 = 0.620, y1 = 0.6, y2 = 0.702 },
        }
    },
    ID860 = {
        area = "Silvershard Mines",
        info = {
            topLeft     = { label = "Earth %s", x1 = 0.15, x2 = 0.35, y1 = 0.28, y2 = 0.47 },
            topRight    = { label = "%s Top", x1 = 0.67, x2 = 0.8, y1 = 0.15, y2 = 0.33 },
            bottomLeft  = { label = "Water %s", x1 = 0.35, x2 = 0.482, y1 = 0.55, y2 = 0.9 },
            bottomRight = { label = "%s Lava", x1 = 0.63, x2 = 0.75, y1 = 0.55, y2 = 0.84 },
        }
    },
    ID935 = {
        area = "Deepwind Gorge",
        info = {
            topLeft     = { label = "Panda %s", x1 = 0.54, x2 = 0.63, y1 = 0.08, y2 = 0.206 },
            middleLeft  = { label = "Mid %s", x1 = 0.476, x2 = 0.581, y1 = 0.417, y2 = 0.568 },
            bottomLeft  = { label = "Goblin %s", x1 = 0.41, x2 = 0.5, y1 = 0.784, y2 = 0.9 },
        }
    },
}

