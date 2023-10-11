#!/bin/sh
#script for lock screen
# man i3lock-color to see options

background=#96AFC360
foreground=#FFFFFFB0
alert=#FF393BA0
verify=#8169D4A0
transparant=#00000000

if [[ "$1" = "ring" ]]; then
    yoffset=300
    xoffset=330

    i3lock-color \
        -i ~/nixos/home/shared/wallpaper/screen-saver/rebecca_good_ending_snowflake_50_blur.png \
        -e \
        --color="#00000000" \
        --force-clock \
        --indicator \
        --radius="120" \
        --inside-color="$transparant" \
        --ring-color="$background" \
        --insidever-color="$transparant" \
        --ringver-color="$verify" \
        --insidewrong-color="$transparant" \
        --ringwrong-color="$alert" \
        --bshl-color="$alert" \
        --date-str="%d-%m-%Y" \
        --time-str="%I:%M %p" \
        --greeter-text="Welcome!" \
        --verif-text="" \
        --wrong-text="" \
        --noinput-text="" \
        --layout-color="$foreground" \
        --time-color="$foreground" \
        --date-color="$foreground" \
        --greeter-color="$foreground" \
        --time-pos="$xoffset:$yoffset-20" \
        --date-pos="$xoffset:$yoffset" \
        --greeter-pos="$xoffset:$yoffset+50" \
        --ind-pos="$xoffset:$yoffset" \
        --bar-color="$background" \
        --keyhl-color="$foreground"
fi

if [[ "$1" = "bar" ]]; then
    xoffset=250
    yoffset=200

    i3lock-color \
        -i ~/nixos/home/shared/wallpaper/screen-saver/rebecca_good_ending_snowflake_50_blur.png \
        -e \
        --color="#00000000" \
        --force-clock \
        --bar-indicator \
        --date-str="%d-%m-%Y" \
        --time-str="%I:%M %p" \
        --greeter-text="Welcome!" \
        --layout-color="$foreground" \
        --time-color="$foreground" \
        --date-color="$foreground" \
        --greeter-color="$foreground" \
        --time-pos="$xoffset+120:$yoffset+50" \
        --date-pos="$xoffset+120:$yoffset+70" \
        --greeter-pos="$xoffset+120:$yoffset+140" \
        --bar-pos="$xoffset:$yoffset" \
        --bar-orientation="vertical" \
        --bar-color="$background" \
        --bar-total-width="170" \
        --keyhl-color="$foreground" \
        --bshl-color="$alert" \
        --ringver-color="$verify" \
        --ringwrong-color="$alert" \
        --verif-text="" \
        --wrong-text="" \
        --noinput-text=""

fi
