-- ایجاد دیتابیس
CREATE DATABASE IF NOT EXISTS surveydb;
USE surveydb;

-- جدول کاربران
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- جدول نظرسنجی‌ها
CREATE TABLE surveys (
    survey_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    question TEXT NOT NULL,
    status ENUM('active', 'closed') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    adminid INT,
    FOREIGN KEY (adminid) REFERENCES users(user_id) ON DELETE CASCADE
);

-- جدول گزینه‌ها
CREATE TABLE options (
    option_id INT AUTO_INCREMENT PRIMARY KEY,
    option_text VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    surveyid INT,
    FOREIGN KEY (surveyid) REFERENCES surveys(survey_id) ON DELETE CASCADE
);

-- جدول رأی‌ها
CREATE TABLE votes (
    vote_id INT AUTO_INCREMENT PRIMARY KEY,
    surveyid INT,
    optionid INT,
    userid INT NULL,
    ip_address VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (surveyid) REFERENCES surveys(survey_id) ON DELETE CASCADE,
    FOREIGN KEY (optionid) REFERENCES options(option_id) ON DELETE CASCADE,
    FOREIGN KEY (userid) REFERENCES users(user_id) ON DELETE SET NULL
);