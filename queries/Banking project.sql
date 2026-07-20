-- Display all customers---
SELECT * FROM customers;
-- Display all accounts --
SELECT * FROM accounts;
-- Display all accounts --
SELECT * FROM bank_transactions;
-- Display all accounts --
SELECT *
FROM accounts
WHERE account_type = 'Savings';
-- Show all Current accounts --
SELECT *
FROM accounts
WHERE account_type = 'Current';
-- Find all customers from Hyderabad --
SELECT *
FROM customers
WHERE city = 'Hyderabad';
-- Display all Deposit transactions --
SELECT *
FROM bank_transactions
WHERE transaction_type = 'Deposit';
-- Display all Withdrawal transactions --
SELECT *
FROM bank_transactions
WHERE transaction_type = 'Withdrawal';
-- Find transactions greater than ₹10,000 --
SELECT *
FROM bank_transactions
WHERE amount > 10000;
-- Sort transactions by amount (highest first) --
SELECT *
FROM bank_transactions
ORDER BY amount DESC;
-- Aggregate Functions --
SELECT COUNT(*) AS Total_Customers
FROM customers;      							   -- total customers --
SELECT COUNT(*) AS Total_Accounts
FROM accounts;     									  -- total acc --
SELECT COUNT(*) AS Total_Transactions
FROM bank_transactions; 							  -- total trans --
SELECT SUM(amount) AS Total_Amount
FROM bank_transactions; 							 -- total transc amt --
SELECT AVG(amount) AS Average_Amount
FROM bank_transactions;    							  -- avg amt --
SELECT MAX(amount) AS Highest_Transaction
FROM bank_transactions;  							-- highest trans --
SELECT MIN(amount) AS Lowest_Transaction
FROM bank_transactions;     						 -- lowest trans --
SELECT SUM(amount)
FROM bank_transactions
WHERE transaction_type='Deposit';                 -- total deposits --
SELECT SUM(amount)
FROM bank_transactions
WHERE transaction_type='Withdrawal';				-- total withdrawals --
SELECT AVG(current_balance)
FROM accounts;										-- avg acc bal --

SELECT city,
COUNT(*) AS Total
FROM customers
GROUP BY city;					-- Number of customers by city--
SELECT account_type,
COUNT(*)
FROM accounts
GROUP BY account_type;				-- Number of accounts by account type --
SELECT branch,
SUM(current_balance)
FROM accounts
GROUP BY branch;					-- Total account balance by branch --
SELECT transaction_type,
SUM(amount)
FROM bank_transactions
GROUP BY transaction_type;				-- Total transaction amount by type --
SELECT transaction_type,
AVG(amount)
FROM bank_transactions
GROUP BY transaction_type; 				-- Average transaction amount by type--
SELECT account_id,
COUNT(*)
FROM bank_transactions
GROUP BY account_id;					-- Number of transactions per account--
SELECT account_id,
MAX(amount)
FROM bank_transactions
GROUP BY account_id;				-- Maximum transaction per account--
SELECT account_id,
MIN(amount)
FROM bank_transactions				-- Minimum transaction per account--
GROUP BY account_id;SELECT account_id,
SUM(amount)
FROM bank_transactions
WHERE transaction_type='Deposit'
GROUP BY account_id;				-- Total deposits per account--
SELECT account_id,
SUM(amount)
FROM bank_transactions
WHERE transaction_type='Withdrawal'
GROUP BY account_id;					-- Total withdrawals per account--



-- Display customer names with account detail--
SELECT c.customer_name,
a.account_id,
a.account_type,
a.current_balance
FROM customers c
JOIN accounts a
ON c.customer_id=a.customer_id;

-- isplay customer names with transaction details--
SELECT c.customer_name,
b.transaction_date,
b.transaction_type,
b.amount
FROM customers c
JOIN accounts a
ON c.customer_id=a.customer_id
JOIN bank_transactions b
ON a.account_id=b.account_id;


-- Show customers and their branch--
SELECT customer_name,
branch
FROM customers c
JOIN accounts a
ON c.customer_id=a.customer_id;


-- Find total transactions for each customer--
SELECT c.customer_name,
COUNT(*) AS Total_Transactions
FROM customers c
JOIN accounts a
ON c.customer_id=a.customer_id
JOIN bank_transactions b
ON a.account_id=b.account_id
GROUP BY c.customer_name;



-- Total amount transacted by each customer --
SELECT c.customer_name,
SUM(b.amount) AS Total
FROM customers c
JOIN accounts a
ON c.customer_id=a.customer_id
JOIN bank_transactions b
ON a.account_id=b.account_id
GROUP BY c.customer_name;


-- Customer with the highest balance.--
SELECT c.customer_name,
a.current_balance
FROM customers c
JOIN accounts a
ON c.customer_id=a.customer_id
ORDER BY a.current_balance DESC
LIMIT 1;



-- Customer with the highest total transaction amount--
SELECT c.customer_name,
SUM(b.amount) AS Total_Amount
FROM customers c
JOIN accounts a
ON c.customer_id=a.customer_id
JOIN bank_transactions b
ON a.account_id=b.account_id
GROUP BY c.customer_name
ORDER BY Total_Amount DESC
LIMIT 1;



-- Top 5 customers by transaction amount --
SELECT c.customer_name,
SUM(b.amount) AS Total
FROM customers c
JOIN accounts a
ON c.customer_id=a.customer_id
JOIN bank_transactions b
ON a.account_id=b.account_id
GROUP BY c.customer_name
ORDER BY Total DESC
LIMIT 5;



-- Find the latest transaction for every account--
SELECT account_id,
transaction_date,
amount
FROM (
    SELECT account_id,
           transaction_date,
           amount,
           ROW_NUMBER() OVER(
               PARTITION BY account_id
               ORDER BY transaction_date DESC
           ) AS rn
    FROM bank_transactions
) t
WHERE rn = 1;