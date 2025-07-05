# SQL Project: October Loyalty Points Analysis

This project involves SQL-based analysis of player activity data on a gaming platform, focusing on **Loyalty Points**, **Deposits**, and **Gameplay** during October.

## 📊 Project Overview

We performed detailed SQL analysis to:
- Compute player-wise loyalty points across various dates and slots.
- Rank players based on overall loyalty points earned during the month.
- Calculate aggregate and per-user deposit statistics.
- Identify top players and propose fair reward distributions.
- Evaluate and suggest improvements to the loyalty points formula.

## 🧮 Key Insights

### 1. Loyalty Points Analysis
- **Top-performing dates and slots** include:
  - **2nd October (Slot S1)**: 1.56M players, top user: `989`
  - **16th October (Slot S2)**: 1.68M players, top user: `663`
  - **18th October (Slot S1)**: 2.29M players, top user: `663`
  - **26th October (Slot S2)**: 1.03M players, top user: `920`

### 2. Player Ranking
- Players were ranked using:
  - Total loyalty points (primary)
  - Number of games played (tie-breaker)

### 3. Average Metrics
- **Average deposit amount**: ₹5,492.18
- **Average monthly deposit per user**: ₹104,669.65
- **Average games played per user**: 355.26

### 4. Leaderboard Recommendation
- A ₹50,000 bonus pool is proposed to be **distributed proportionally** among the **top 50 players**, incentivizing engagement across deposits, withdrawals, and gameplay.

## 🧠 Suggestions for Loyalty Formula

Current formula:
- Rewards deposits more than holding.
- Rewards withdrawals more than holding.
- No time-based loyalty component.

Proposed improvement:
> Add a **"stake in days" multiplier** to reward long-term, consistent users.  
`Loyalty Points += 0.05 * (stake in days)`

---

## 📁 Files Included
- `ABC_Report.pdf`: Full analysis and business insights report.
- `ABC_script.sql`: (SQL queries file)

## 🔧 Tech Stack
- SQL (MYSQL)
- Excel (for data review)

## 📬 Contact
For questions or collaborations, reach out via LinkedIn or email.

