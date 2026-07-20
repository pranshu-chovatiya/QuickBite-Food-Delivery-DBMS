-- ============================================================
--  QuickBite — Full Database Setup Script
--
--  This file sets up the entire QuickBite database in one shot.
--  Run this file to create the schema and load all sample data.
--
--  Usage:
--      mysql -u root -p < setup.sql
--
--  Or in MySQL Workbench / CLI:
--      SOURCE /path/to/setup.sql;
-- ============================================================

-- Step 1: Create schema (tables + indexes)
SOURCE DDL_Script.sql;

-- Step 2: Insert sample data
SOURCE Insertion_Script.sql;

-- Done!
SELECT 'QuickBite database setup complete.' AS Status;
