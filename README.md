# s2-datacat


## How to install

Run the following command to launch the installer (you can run it anywhere, it will ask you where you want it to install to):
```console
$ bash <(curl -s https://raw.githubusercontent.com/LiamBindle/s2-datacat/master/utils/install.sh)
```

Follow the prompts. The defaults should be okay (hit enter):

```
> Enter install prefix [/home/liambindle]: 
Downloading ...
Cloning into '.s2-datacat'...
remote: Enumerating objects: 77, done.
remote: Counting objects: 100% (77/77), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 77 (delta 23), reused 70 (delta 16), pack-reused 0
Receiving objects: 100% (77/77), 10.37 KiB | 5.19 MiB/s, done.
Resolving deltas: 100% (23/23), done.
> Do you want to add this installation to your $PATH? [Y/n]: 
> Enter your environment file [/home/liambindle/.bashrc]: 
export PATH=$PATH:/home/liambindle/.s2-datacat
Installation complete.
```

## How to update

You can automatically update, at any time, by running the `self-update` command:

```console
$ datacat self-update
```

