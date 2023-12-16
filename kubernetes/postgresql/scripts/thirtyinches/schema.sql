-- Users table
CREATE TABLE IF NOT EXISTS Users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- -- Plans table
-- CREATE TABLE IF NOT EXISTS Plans (
--     plan_id SERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     description TEXT NOT NULL,
--     price DECIMAL(10, 2) NOT NULL,
--     period_type ENUM('MONTHLY', 'YEARLY') NOT NULL,
--     trial_days INTEGER DEFAULT NULL
-- );

-- -- Subscriptions table
-- CREATE TABLE IF NOT EXISTS Subscriptions (
--     subscription_id SERIAL PRIMARY KEY,
--     user_id INTEGER NOT NULL,
--     plan_id INTEGER NOT NULL,
--     start_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     end_date TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL,
--     status ENUM('active', 'cancelled', 'expired') NOT NULL DEFAULT 'active',
--     payment_method VARCHAR(255) DEFAULT NULL,
--     FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
--     FOREIGN KEY (plan_id) REFERENCES Plans(plan_id) ON DELETE RESTRICT
-- );

-- -- Transactions table
-- CREATE TABLE IF NOT EXISTS Transactions (
--     transaction_id SERIAL PRIMARY KEY,
--     subscription_id INTEGER NOT NULL,
--     amount DECIMAL(10, 2) NOT NULL,
--     payment_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     payment_method VARCHAR(255) DEFAULT NULL,
--     status ENUM('successful', 'failed', 'pending') NOT NULL DEFAULT 'pending',
--     FOREIGN KEY (subscription_id) REFERENCES Subscriptions(subscription_id) ON DELETE CASCADE
-- );

-- -- Add any additional tables or constraints as needed
-- -- Example of adding an index on email for faster lookup
-- CREATE INDEX idx_users_email ON Users(email);