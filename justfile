server := 'pi@plexpi.local'

ssh command="":
    ssh {{server}} {{command}}

off:
    ssh {{server}} sudo poweroff

restart:
    ssh {{server}} sudo reboot

copy in out:
    scp {{in}} pi@plexpi.local:{{out}}

upgrade:
    ssh {{server}} sudo apt-get update && sudo apt-get upgrade -y

hostname:
    ssh {{server}} hostname -I
