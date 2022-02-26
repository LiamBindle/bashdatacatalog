# bashdatacatalog
The bashdatacatalog is a command-line tool that facilitates synchronizing local data collections with a remote data source. With the bashdatacatalog, you can run queries on your local data collections to answer questions like "What files am I missing?" or "What files aren't bitwise identical to remote data?". Queries can include a date range, in which case collections with temporal assets are filtered-out accordingly. The bashdatacatalog can format the results of queries as: a URL download list, a Globus transfer list, an rsync transfer list, or simply a file list.

The bashdatacatalog was written to facilitate downloading input data for users of the [GEOS-Chem](https://geos-chem.seas.harvard.edu/) atmospheric chemistry model. The canonical GEOS-Chem input data repository has >1 M files and >100 TB of data, and the input data required for a simulation depends on the model version and simulation parameters such as start and end date.

_Note: Consider giving the bashdatacatalog a Star :star: if you find it useful. This increase visibility and helps justify maintaining this repository._

## 📋 Key Terminology

Data is organized with _collections_ and _catalogs_.

_collection_ - A *data collection* is a data directory. A data collection may have any number of files, any types of files, and have subdirectories.

_catalog_ - A file that groups data colleciton together, and includes some details about the collections. A catalog file includes (1) the local paths to data collections, (2) the URLs of the data sources, and (3) boolean flags to enable/disable data collections.

## 💿 Install

You can install the bashdatacatalog with the following command. Follow the prompts and restart your terminal.

```console
$ bash <(curl -s https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/install.sh)
```

_Note: This command upgrades the bashdatacatalog if it's already installed._


## 🎉 Example Usage

1. Download a catalog file:

    ```console
    $ curl https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/sandbox/catalog1.csv -o catalog1.csv
    ```

2. Fetch collection metadata:
    ```console
    $ bashdatacatalog-fetch catalog1.csv
    ```

3. Run listing queries (e.g., download all missing files with 4 parallel downloads):
    ```console
    $ bashdatacatalog-list -am -f xargs-curl catalog1.csv | xargs -P 4 curl
    ```
## 💡 Documentation

See the Wiki for instructions: https://github.com/LiamBindle/bashdatacatalog/wiki.
