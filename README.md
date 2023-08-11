# Data Products CI/CD
I have been asked several times how to version Starburst Data Products and how to deploy them across stages (from DEV to TEST to PROD for example).
This repository demonstrates how this process can look like and how you can use Starburst Enterprise Data Products in a CI/CD fashion.

## What are Data Products (technically)
First of all, the question of what a data product actually is. I don't mean the conceptual level, but the technical level in Starburst.
A Data Product is a collection of datasets that are the result of their SELECT statements. Or, in other words, a Data Product is a collection of SELECT statements.
In addition, a Data Product also includes metadata. Some of these are mandatory and others are optional.

### Metadata

**Mandatory Metadata:**
- Name - the name of the data product
- Catalog - the catalog where the data product will be accessible
- Domain - the domain the data product belongs to
- Summary - a short summary of the data product
- Owner - the responsible person for this data product

**Optional Metadata:**
- Description - more detailed description of the data product (in Markdown)
- tags - a list of tags that belong to the data product
- links - Hyperlinks to other assets related to the data product

### Datasets
A data set is a SELECT statement associated with a name and optionally a summary.
Further you can add descriptions to the individual columns.

## Architecture / Idea
My idea to align the Data Products with CI/CD, taking into account both versioning and staging, 
is to track these elements in text files in Git and roll them out via pipelines.
In this example, I will use GitHub for versioning and GitHub Actions for rolling out.

Within the Git project there is a folder for each Data Product, which ideally has the name of the Data Product and a domains.yaml file to describe the domains.
The top-level structure looks like this, however you can add further files like a readme for example:

```bash
├── my-data-product
├── another-data-product
├── domains.yaml             (mandatory)
```

The structure of the Data Product itself looks like this:

```bash
├── datasets
│   ├── dataset_name.sql      (mandatory)
│   ├── another_dataset.sql
│   └── another_dataset.yaml  (optional)
├── samples                   (optional)
│   ├── A Sample.sql
│   └── Another cool Sample.sql
├── metadata.yaml             (mandatory)
└── readme.md                 (mandatory)
```

With this split, the metadata is cleanly separated from the data and the most important elements can be tracked.
The readme.md maps the description. It is not part of the metadata.yaml because it can be more extensive and may change more frequently than the other metadata.
While in Starburst Enterprise the description is optional, this is an opinionated design that enforces the description

In the GitHub Action, the JSON payload for the Data Products REST API is to be built from these files and then sent to the API.

## Misc
If Data Products are only to be rolled out via the CI/CD process, then the permissions on Starburst side should be set so that only a technical user can create Data Products and this can then be used by the GitHub Actions.
