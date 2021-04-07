## Infrastructure Data Model (IDM)
The IDM, constructed similarly to [Observations Data Model](https://doi.org/10.1029/2007WR006392) (established by [CUAHSI](https://www.cuahsi.org/), is a SQL server database that uses relational tables to organize disparate types of data, as well as minimize database size and maximize data retrieval speed. The [Villanova Center for Resilient Water Systems (VCRWS)](https://www1.villanova.edu/university/engineering/faculty-research/Resilient-Water-Systems.html) has created this database to experiment with the organization of their data for deeper and more comprehensive spatio-temporal analysis. The relational format allows for an interface in which time series of dissimilar data from a range of projects can be retrieved and compared; however, the IDM has added additional tables to build on the [ODM structure](https://github.com/ODM2/ODM2) to focus on stormwater infrastructure data.


### IDM SQL Implementation
The SQL implementation of the IDM is available here in this repository at:

[IDM](https://github.com/VCRWS/IDM) <br />
&nbsp;&nbsp;└ [src](https://github.com/VCRWS/IDM) <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└ [IDM.sql](https://github.com/VCRWS/IDM/blob/main/src/IDM.sql)


### Core Schema
Below is the core schema for the IDM. The core of the IDM is based heavily on the ODM. It departs from the original model by adding the following capabilities:

* **Detection limit system (DetectionLimit/DetectionLevel):** where the concentration of an analyte or variable of interest can be flagged as falling below the  acceptable threshold of detection by the lab instrumentation. CUAHSI’s ODM has a series of sensor codes which could be used to identify if a value had a detection limit. Here we added a new column that stores the actual limit itself, as well as the sensor code.

* **Event type (EventType):** base flow and storm flow indicators, the difference between these two environmental conditions has drastic impacts on water quality indicators and watershed health.

* **Sample location (SampleLocations):** to differentiate between duplicate variables measured at a given site, typically for comparison purposes across space. Sample locations can be thought of as “sub-sites” in that they are simply a spatial extension of the original site codes.

* **Sample type (SampleType):** to differentiate between how the sample was collected.  This allows for data to be categorized as grab, composite, continuous, or autosample.  Multiple autosample options exist to account for  duplicates. This data serves to aid in longterm data reuse to identify potential sources of discrepancy associated with  new sampling methods.

* **Data Logs and User Permissions:** For keeping track of data uploaded to the IDM via the [VCRWS Database webpage](https://vcrws.villanova.edu) and managing users of the VCRWS Database.


![IDM Diagram](documentation/IDM_diagram.png)
