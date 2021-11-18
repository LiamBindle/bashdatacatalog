# bashdatacatalog
The bashdatacatalog is a command-line tool for keeping inventory of data files. You can use the bashdatacatalog to synchronize a local copy of data collections with remote data collections. The bashdatacatalog was written to facilitate downloading input data for users of the GEOS-Chem atmospheric chemistry model, which has >1M files and >100TB of available input data.

With the bashdatacatalog you can run queries like "list all the files I'm missing", or "list all my files that are not bitwise identical to the remote data". You can also filter the results according to date ranges, which in words would be something like "list all the files I'm missing, and the time span I'm interested in is 2018-01-03 to 2018-07-21".

## Key Terminology

The `bashdatacatalog` uses the *collections* and *catalogs* to organize data files. 

**collection** - 
*A data collection is a group of data files. Typically, a collection is a directory with data files in it.*

An example of a data collection is a directory with meteorological data files from the MERRA-2 data product. A second example is a directory with emissions data files from the National Emissions Inventory. In essence, a collection is the unit representing a group of files.


**catalog** -
*A data catalog* is a CSV file that defines a list of data collections to use.* 

This includes the path to each collection, the URL to the remote copy of the data collection, and an enable/disable switch for turning collections on or off. An example of a data catalog would be a CSV file that defines the emissions data collections needed for GEOS-Chem version 13.2.1. Note that most `bashdatacatalog` commands operate on data catalogs, and multiple catalogs can be used in one command.

## Installation

Run this command to launch the installer:
```console
bash <(curl -s https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/utils/install.sh)
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

## Updating

You can automatically update, at any time, by running the `self-update` command:

```console
bashdatacatalog self-update
```

## Instructions

The Wiki includes targetted instructions for using the bashdatacatalog. See

- [Instructions for GEOS-Chem Users](https://github.com/LiamBindle/bashdatacatalog/wiki/Instructions-for-GEOS-Chem-Users) - instructions for downloading GEOS-Chem input data with the bashdatacatalog
- [Instructions for Data Providers](https://github.com/LiamBindle/bashdatacatalog/wiki/Instructions-for-Data-Providers) - instructions for maintaining data collections for the bashdatacatalog



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

Before you can run `bashdatacatalog` commands, you need to fetch the metadata for the collections: 
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
$ bashdatacatalog catalog1.csv list-missing  # Shows nothing because all the files are downloaded
$
```

## Cheat sheet

Here is a quick overview of the most useful commands (note that `my_catalog1.csv` is a placeholder for your catalog's file name):

| Command | Description |
|:---|:---|
| `bashdatacatalog --help` | Shows the usage of `bashdatacatalog` |
| `bashdatacatalog my_catalog.csv fetch` | Update collection metadata |
| `bashdatacatalog my_catalog.csv list-missing` | Lists missing files |
| `bashdatacatalog my_catalog.csv list-missing url` | URL list of missing files |
| `bashdatacatalog my_catalog.csv list-invalid` | Lists files with bad checksums |
| `bashdatacatalog my_catalog.csv list-invalid url` | URL list of files with bad checksums |
| `bashdatacatalog my_catalog.csv list-assets` | List all the files |

All `list-*` commands have three optional arguments: the list format, the starting date for temporal assets, and the ending date for temporal assets. The supported list formats are:
- `relative` &mdash; relative paths to the files
- `absolute` &mdash; absolute paths to the files
- `url` &mdash; URLs for each file
- `rsync` &mdash; transfer list for use with `rsync --file-from=`
- `globus=/foo1,/foo2` &mdash; transfer list for use with `globus --batch`

The start/end date for temporal assets should be ISO 8601 dates. For example

```console
$ bashdatacatalog my_catalog.csv list-missing url 2018-01-01 2019-01-01  # lists missing files for 2018
```

All commands can be run on multiple catalogs at the same time. For example

```console
$ bashdatacatalog my_catalog1.csv my_catalog2.csv list-assets  # lists all the files in both catalogs
```
