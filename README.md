# QuickBite 🍔 — Food Delivery Database System

A complete relational database design for a food delivery platform (similar to Swiggy/Zomato), built as a DBMS course project. Includes DDL schema, sample data, and analytical SQL queries.

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Database Schema](#database-schema)
- [File Structure](#file-structure)
- [Setup Instructions](#setup-instructions)
- [Sample Queries](#sample-queries)
- [ER Diagram](#er-diagram)

---

## Project Overview

**QuickBite** models a real-world food delivery system with:

- 👤 User registration, authentication, and address management
- 🍽️ Restaurants, menus, categories, and cuisine types
- 🛒 Cart and order management with order status tracking
- 🚴 Delivery partner assignment and live delivery tracking
- 💳 Payment processing (UPI, Card, Cash, Wallet, NetBanking)
- 🎟️ Coupon and discount system
- ⭐ Reviews for restaurants and delivery partners
- 💰 Wallet with top-up and transaction history
- 🔔 Notifications, complaints, and refund management

---

## Tech Stack

![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

- **Database:** MySQL 8.0+
- **Language:** SQL (DDL + DML)
- **Tables:** 20
- **Sample Records:** ~200 rows across all tables

---

## Database Schema

| Table | Description |
|---|---|
| `Address` | Physical addresses shared across users and restaurants |
| `User` | Registered customer accounts |
| `User_Address` | Many-to-many: users can have multiple saved addresses |
| `Restaurant` | Restaurant listings with hours, rating, and FSSAI license |
| `Cuisine` | Cuisine types offered per restaurant |
| `Menu_Category` | Food/drink category groupings per restaurant |
| `Menu_Item` | Individual menu items with nutritional info and pricing |
| `Coupon` | Promotional coupon codes with usage limits and validity |
| `Discount` | Discount records applied to specific orders (via coupons) |
| `Cart` | Active shopping carts per user |
| `Cart_Item` | Items inside a cart with quantity |
| `Orders` | Placed orders with status, total, and delivery address |
| `Order_Status_Log` | Audit trail of every status change for an order |
| `Order_Item` | Snapshot of items + prices at the time of order |
| `Delivery_Partner` | Delivery agent profiles with vehicle and rating info |
| `Delivery` | Delivery assignment with pickup/drop timestamps |
| `Payment` | Payment transaction records per order |
| `Review` | User reviews for restaurants or delivery partners |
| `Wallet` | User wallet balances |
| `Wallet_Transaction` | CREDIT/DEBIT entries for every wallet movement |
| `Wallet_Topup` | Top-up specific details (payment mode, reference) |
| `Notification` | In-app notifications pushed to users |
| `Cancellation` | Order cancellation records with reason and penalty |
| `Complaint` | Support complaints raised against orders |
| `Refund` | Refund records linked to complaints and wallet |

---

## File Structure

```
QuickBite/
│
├── DDL_Script.sql          # CREATE TABLE statements + indexes (run this first)
├── Insertion_Script.sql    # Sample data INSERT statements (run this second)
├── Queries.sql             # 18 analytical SQL queries
├── setup.sql               # One-shot setup: runs DDL + Insertion automatically
│
├── Quick-Bite_F12.pdf                       # ER Diagram
└── Quick-Bite_Relational_final_version_FF1.pdf   # Relational Schema
```

---

## Setup Instructions

### Prerequisites
- MySQL 8.0 or higher installed
- MySQL command-line client or MySQL Workbench

### Option 1 — One Command (Recommended)

```bash
mysql -u root -p < setup.sql
```

### Option 2 — Step by Step

**Step 1:** Create the database and tables

```bash
mysql -u root -p < DDL_Script.sql
```

**Step 2:** Insert sample data

```bash
mysql -u root -p < Insertion_Script.sql
```

**Step 3:** Run analytical queries (optional)

```bash
mysql -u root -p QuickBite < Queries.sql
```

### Option 3 — MySQL Workbench

1. Open MySQL Workbench and connect to your server
2. Open `DDL_Script.sql` → Run (⚡)
3. Open `Insertion_Script.sql` → Run (⚡)
4. Open `Queries.sql` → Run individual queries as needed

---

## Sample Queries

The `Queries.sql` file contains **18 analytical queries**, including:

| # | Query |
|---|---|
| Q1 | Menu items per category with price stats |
| Q2 | Most used payment method by revenue |
| Q3 | Orders by users with low wallet balance |
| Q4 | Total revenue per restaurant |
| Q5 | Top 5 rated restaurants |
| Q6 | Average delivery time per delivery partner |
| Q7 | Pending complaints with user contact details |
| Q8 | High-value users by total spend |
| Q9 | Refund summary by status |
| Q10 | Top 5 most ordered menu items |
| Q11 | Monthly revenue trend |
| Q12 | Veg vs Non-Veg order split |
| Q13 | City-wise order distribution |
| Q14 | Coupon usage percentage |
| Q15 | Users with unread notifications |
| Q16 | Live order status timeline |
| Q17 | Available delivery partners in a city |
| Q18 | Cancelled orders with refund status |

---

## ER Diagram

See `Quick-Bite_F12.pdf` for the full Entity-Relationship diagram and `Quick-Bite_Relational_final_version_FF1.pdf` for the relational schema.

**Key relationships:**
- A `User` can have multiple `Address` entries via `User_Address`
- A `Restaurant` belongs to one `Address` and has many `Menu_Item` entries
- An `Order` is placed by a `User`, delivered to an `Address`, and may use a `Discount`
- Every `Order` has an `Order_Status_Log` audit trail
- A `Delivery` links an `Order` to a `Delivery_Partner`
- A `Refund` is triggered by a `Complaint` and credited to a user's `Wallet`

---

## Project Info

- **Course:** Database Management Systems (DBMS)
- **Database:** QuickBite (food delivery platform)
- **Tables:** 25 | **Sample Rows:** ~200
