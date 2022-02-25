# bashdatacatalog
The bashdatacatalog is a command-line tool that facilitates synchronizing local data collections with a remote data source. With the bashdatacatalog, you can run queries on your local data collections to answer questions like "What files am I missing?" or "What files aren't bitwise identical to remote data?". Queries can include a date range, in which case collections with temporal assets are filtered-out accordingly. The bashdatacatalog can format the results of queries as: a URL download list, a Globus transfer list, an rsync transfer list, or simply a file list.

The bashdatacatalog was written to facilitate downloading input data for users of the [GEOS-Chem](https://geos-chem.seas.harvard.edu/) atmospheric chemistry model. The canonical GEOS-Chem input data repository has >1 M files and >100 TB of data, and the input data required for a simulation depends on the model version and simulation parameters such as start and end date.

_Note: Consider giving the bashdatacatalog a Star :star: if you find it useful. This increase visibility and helps justify maintaining this repository._

## Key Terminology

Data is organized with _collections_ and _catalogs_.

_collection_ - A *data collection* is a data directory. A data collection may have any number of files, any types of files, and have subdirectories.

_catalog_ - A file that groups data colleciton together, and includes some details about the collections. A catalog file includes (1) the local paths to data collections, (2) the URLs of the data sources, and (3) boolean flags to enable/disable data collections.

## Installation

The following command launches the bashdatacatalog installer. Follow the prompts. The defaults are usually okay (hit enter).
```console
bash <(curl -s https://raw.githubusercontent.com/LiamBindle/bashdatacatalog/main/utils/install.sh)
```

Ater restarting your terminal, you should be able to run `bashdatacatalog`.

### Updating

To update the bashdatacatalog run the following command.

```console
bashdatacatalog self-update
```

## Example

## Alternatives

Alternative data catalogging systems exist, notably [STAC](https://stacspec.org/) and [Intake](https://intake.readthedocs.io/en/latest/index.html). The bashdatacatalog could be thought of as a stepping stone towards more capable catalogging tools like these. The value proposition of the bashdatacatalog is it's the simplest way to set up a static data catalog. The design goals of the bashdatacatalog were:
1. No dependencies (other than bash and ubiquitous utilities like curl)
2. No coding required
3. Easy to implement in unmanaged data repositories
4. Easy to maintain operationally (automatically maintanable data collections)
