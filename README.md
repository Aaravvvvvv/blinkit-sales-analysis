# Blinkit Sales Analysis

## Overview
End-to-end sales analysis of Blinkit quick commerce operations
using MySQL, Excel and Power BI to identify revenue drivers,
profitability gaps, delivery performance issues and customer
behaviour patterns.

## Business Problem
- Which products and categories drive the most revenue and profit?
- Where are the operational inefficiencies in delivery?
- How do different customer segments behave?

## Tools Used
- MySQL — data querying and analysis
- Excel — pivot tables and charts
- Power BI — interactive dashboard

## Dataset
Blinkit Sales Dataset from Kaggle
- 1,061 orders
- 268 products across 11 categories
- 5,030 customers across 4 segments
- 4 connected tables

## Key Findings
- Dairy & Breakfast leads revenue at ₹1,46,792 but Pet Care
  is more profitable at 35% margin vs 20%
- 30% of orders face delivery delays — critical risk for a
  quick commerce brand
- Vitamins alone contributes 6.7% of total revenue
- Revenue grew from ₹62,353 in March 2023 to consistently
  ₹1,20,000 per month by 2024
- New customers spend nearly as much as Premium customers
  suggesting segmentation strategy needs redesign

## Business Recommendations
See blinkit_recommendations.pdf for 4 detailed recommendations

## SQL Analysis
13 queries including JOINs across 4 tables and window
functions — RANK, running totals, cumulative percentages,
segment contribution analysis

## Dashboard
Interactive Power BI dashboard with 6 visuals and
category level slicer
