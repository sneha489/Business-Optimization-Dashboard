# Power BI Dashboard

## Overview

This Power BI dashboard is part of the **Business Optimization Dashboard**
project. It analyzes inventory and business performance data and presents
key business metrics through an interactive dashboard.

## Dashboard Pages

### Page 1 — Demand & Availability

This page presents key inventory-related metrics:

- Average Demand per Day
- Average Availability per Day
- Total Supply Shortage

### Page 2 — Profit & Loss

This page presents business performance metrics:

- Total Profit
- Total Loss
- Average Daily Loss

## Data Preparation

The data was prepared using SQL and combined with product information using
`LEFT JOIN` operations.

Power Query was used to transform and prepare the data for visualization
in Power BI.

## Data Modeling

The Power BI report contains:

- Inventory and availability data
- Product information
- A Measures Table
- DAX measures for KPI calculations

## DAX Measures

DAX was used to create calculated business metrics, including:

- Average Demand per Day
- Average Availability per Day
- Total Supply Shortage
- Total Profit
- Total Loss
- Average Daily Loss

## Dashboard Preview

### Page 1 — Demand & Availability

![Dashboard Page 1](screenshots/dashboard-page-1.png)

### Page 2 — Profit & Loss

![Dashboard Page 2](screenshots/dashboard-page-2.png)

### Data Model

![Data Model](screenshots/data-model.png)

## Tools & Technologies

- Power BI Desktop
- Power Query
- DAX
- SQL Server
- MySQL
- MySQL Workbench

## Project File

The original Power BI `.pbix` file is included in this folder.

A Power BI Service link is not currently included, so the screenshots above
are provided as a preview of the completed dashboard.