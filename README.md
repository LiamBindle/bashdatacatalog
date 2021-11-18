# bashdatacatalog
The bashdatacatalog is a command-line tool that facilitates synchronizing local data collections with a remote data source. With the bashdatacatalog, you can run queries on your local data collections to answer questions like "What files am I missing?" or "What files aren't bitwise identical to remote data?". Queries can include a date range, in which case collections with temporal assets are filtered-out accordingly. The bashdatacatalog can format the results of queries as: a URL download list, a Globus transfer list, an rsync transfer list, or simply a file list.

The bashdatacatalog was written to facilitate downloading input data for users of the [GEOS-Chem](https://geos-chem.seas.harvard.edu/) atmospheric chemistry model. The canonical GEOS-Chem input data repository has >1M files and >100TB of data, and the input data required for a simulation depends on the model version and simulation parameters such as start and end date.

Alternative data catalogging systems exist, notably [STAC](https://stacspec.org/) and [Intake](https://intake.readthedocs.io/en/latest/index.html). The bashdatacatalog could be thought of as a stepping stone towards more capable catalogging tools like these. The value proposition of the bashdatacatalog is it's the simplest way to set up a static data catalog. The design goals of the bashdatacatalog were:
1. No dependencies (other than bash and ubiquitous utilities like curl)
2. No coding required
3. Easy to implement in unmanaged data repositories
4. Easy to maintain operationally (automatically maintanable data collections)

**Note:** Please consider giving the bashdatacatalog a "Star" (:star:) on GitHub. It helps increase visibility. 

## Key Terminology

The `bashdatacatalog` organizes data files with *collections* and *catalogs*.

**collection** - 
A *data collection* is a group of data files. Typically, a collection is a directory with data files in it.

An example of a data collection is a directory with meteorological data files from the [MERRA-2](https://gmao.gsfc.nasa.gov/reanalysis/MERRA-2/) data product. A second example is a directory with emissions data files from the [National Emissions Inventory](https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei). In essence, a collection is a unit representing a group of files.

**catalog** -
A *data catalog* is a CSV file that defines a list of data collections to use. 

A catalog file includes the path to each collection, the URL of the remote data collection, and an enable/disable switch for each collection. An example of a data catalog would be a CSV file that defines the emissions data collections needed for GEOS-Chem version 13.2. Note that most `bashdatacatalog` commands operate on data catalogs, and multiple catalogs can be used in one command.

## Usage Instructions

Detailed instructions for using the bashdatacatalog can be found in the Wiki:
- [Instructions for GEOS-Chem Users](https://github.com/LiamBindle/bashdatacatalog/wiki/Instructions-for-GEOS-Chem-Users) - instructions for downloading GEOS-Chem input data with the bashdatacatalog
- [Command Cheat Sheet](https://github.com/LiamBindle/bashdatacatalog/wiki/Command-Cheat-Sheet) - cheat sheet with useful commands
- [Instructions for Data Providers](https://github.com/LiamBindle/bashdatacatalog/wiki/Instructions-for-Data-Providers) - instructions for maintaining data collections

## Installation

The following command launches the bashdatacatalog installer:
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

### Updating

To update the bashdatacatalog run the following command.

```console
bashdatacatalog self-update
```

## Usage Demo

The following is an example of using `bashdatacatalog` to download sample data from the sample catalog file [catalog1.csv](https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/catalog1.csv). Here is what that catalog file looks like:

|Path to collection|Canonical collection (URL)                                                          |Enabled|Notes|
|------------------|--------------------------------------------------------------------------------------|-------|-----|
|collection1/      |https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection1/|1      |     |
|collection2/      |https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/collection2/|1      |     |

A catalog is a table where each row specifies a data collection. A row consists of: the relative path to the data collection, the URL of the remote data collection, a enable/disable switch, and a place to include notes about the collection. Take note that `catalog1.csv` has two collections.

Download the catalog file. This is the catalog file that you will run queries on.
```console
$ wget https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/catalog1.csv
```

Before you can run queries on the catalog, you need to fetch the metadata for every collection in `catalog1.csv`:
```console
$ bashdatacatalog catalog1.csv fetch
```

Now that you have fetched the metadata, you can run queries on `catalog1.csv`. For example, here is a query that lists all the files that are currently missing locally:
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

The following query gives you a URL list for the missing files: 
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

URL lists are compatible with the `--input-file` argument in wget. For example,
```console
$ bashdatacatalog catalog1.csv list-missing url > download_list.txt  # Generate URL list
$ wget -nH -x --cut-dirs=4 --input-file=download_list.txt            # Download all the files
```

You can rerun the `list-missing` command to check that all the files are downloaded:
```console
$ bashdatacatalog catalog1.csv list-missing  # Shows nothing because all the files are downloaded
$
```
