# bashdatacatalog
The bashdatacatalog is a command-line tool that facilitates synchronizing local data collections with a remote data source. With the bashdatacatalog, you can run queries on your local data collections to answer questions like "What files am I missing?" or "What files aren't bitwise identical to remote data?". Queries can include a date range, in which case collections with temporal assets are filtered-out accordingly. The bashdatacatalog can format the results of queries as: a URL download list, a Globus transfer list, an rsync transfer list, or simply a file list.

The bashdatacatalog was written to facilitate downloading input data for users of the [GEOS-Chem](https://geos-chem.seas.harvard.edu/) atmospheric chemistry model. The canonical GEOS-Chem input data repository has >1M files and >100TB of data, and the input data required for a simulation depends on the model version and simulation parameters such as start and end date.

**Note:** Please consider giving the bashdatacatalog a "Star" (:star:) on GitHub. It helps increase visibility. 

## Key Terminology

The `bashdatacatalog` organizes data files with *collections* and *catalogs*.

**collection** - 
A *data collection* is a group of data files. Typically, a collection is a directory with data files in it.

An example of a data collection is a directory with meteorological data files from the [MERRA-2](https://gmao.gsfc.nasa.gov/reanalysis/MERRA-2/) data product. A second example is a directory with emissions data files from the [National Emissions Inventory](https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei). In essence, a collection is a unit representing a group of files.

**catalog** -
A *data catalog* is a CSV file that defines a list of data collections to use. 

A catalog file includes the path to each collection, the URL of the remote data collection, and an enable/disable switch for each collection. An example of a data catalog would be a CSV file that defines the emissions data collections needed for GEOS-Chem version 13.2. Note that most `bashdatacatalog` commands operate on data catalogs, and multiple catalogs can be used in one command.

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
