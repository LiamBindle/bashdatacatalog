# bashdatacatalog


## How to install

Run this command to launch the installer:
```console
bash <(curl -s https://raw.githubusercontent.com/LiamBindle/s2-datacat/master/utils/install.sh)
```

Follow the prompts. The defaults should be okay (hit enter):

```
> Enter install prefix [/home/liambindle]: 
Downloading ...
Cloning into '.bashdatacatalog'...
remote: Enumerating objects: 77, done.
remote: Counting objects: 100% (77/77), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 77 (delta 23), reused 70 (delta 16), pack-reused 0
Receiving objects: 100% (77/77), 10.37 KiB | 5.19 MiB/s, done.
Resolving deltas: 100% (23/23), done.
> Do you want to add this installation to your $PATH? [Y/n]: 
> Enter your environment file [/home/liambindle/.bashrc]: 
USER ACTION: You should manually add '/home/liambindle/.bashdatacatalog' to $PATH in your environment set up.
Installation complete.
```

Ater restarting your terminal you should be able to run `bashdatacatalog` commands.

## How to update

You can automatically update, at any time, by running the `self-update` command:

```console
bashdatacatalog self-update
```


## Demo

The following is an example of using `bashdatacatalog` to download some data collections. A "collection" is a group of files (data). A "catalog" is a CSV file that specifies collections for an application.

In this example we will download the collections specified by the [catalog1.csv](https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/catalog1.csv) catalog file:

|Path to collection|Canonical collection (URL)                                                          |Enabled|Notes|
|------------------|--------------------------------------------------------------------------------------|-------|-----|
|collection1/      |https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection1/|1      |     |
|collection2/      |https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/|1      |     |

A catalog is a table with the path, provider URL, enable/disable switch, and notes for every collection in the catalog. You can see this catalog has two collections.

To begin, download the catalog file:
```console
$ wget https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/catalog1.csv
```

Before you can run `bashdatacatalog` commands you need to fetch the metadata for the collections: 
```console
$ bashdatacatalog catalog1.csv fetch
```

Now you can run `bashdatacatalog` commands. For example, list all the files that are missing on the local file system:
```console
$ bashdatacatalog catalog1.csv list-missing
./collection1/file1
./collection1/file2
./collection1/file3
./collection1/sub1/subfile1
./collection1/sub1/subfile2
./collection1/sub1/subfile3
./collection2/2018/file-20181005
./collection2/2018/file-20181105
./collection2/2018/file-20181205
./collection2/2019/file-20190203
./collection2/2019/file-20190403
./collection2/2019/file-20190803
./collection2/file1
./collection2/file2
./collection2/file3
```

The following command gives you a URL list for all the missing files: 
```console
$ bashdatacatalog catalog1.csv list-missing url
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection1/file1
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection1/file2
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection1/file3
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection1/sub1/subfile1
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection1/sub1/subfile2
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection1/sub1/subfile3
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/2018/file-20181005
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/2018/file-20181105
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/2018/file-20181205
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/2019/file-20190203
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/2019/file-20190403
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/2019/file-20190803
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/file1
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/file2
https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/file3
```

A URL list like this is compatible with the `--input-file` argument in wget. For example,
```console
$ bashdatacatalog catalog1.csv list-missing url > download_list.txt  # Generate URL list
$ wget -nH -x --cut-dirs=4 --input-file=download_list.txt            # Download all the files
```

You can rerun the `list-missing` command to check that all the files are downloaded:
```console
$ bashdatacatalog catalog1.csv list-missing
$
```
