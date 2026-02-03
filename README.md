# SP500DataAnalysis
Brief analysis of the past 5 years of S&amp;P 500 stock data.

## Motivation
This project was made out of interest, I aimed to learn more about both data analysis in python and the market.

## Included in This Repository
This repository includes the jupyter-notebook that I used to create and ETL (Extract, Transform, Load) pipeline which takes S&P 500 stock data from the yfinance Python library and cleans it via Pandas. Using the cleaned data, we calculate a value for β (volatility relative to benchmark) and ⍺ (annual return compared to benchmark). The benchmark referred to here is the S&P 500. This is then uploaded to a PostgreSQL server for further exploration via SQL.
<br><br>
In this setup, the PostgreSQL server connected to is hosted locally. As I am on MacOS, I connected to a remote DB via Neon to allow for connection to Power BI through Parallels. If you wish to use the script this can be changed as needed. <br><br>
Also included is 'analysis.sql' which provides queries to return data fitting specific characteristics that may be of interest. Additionally there is the data dashboard which I created on Power BI.
