-- Create Database (if not already done)
CREATE DATABASE IF NOT EXISTS club_management;
USE club_management;

-- User Table
CREATE TABLE User (
    userId VARCHAR(10) PRIMARY KEY,
    fullName VARCHAR(100),
    email VARCHAR(80),
    password VARCHAR(255),
    role ENUM('CHC', 'MPP'),
    department VARCHAR(50),
    isActive BOOLEAN DEFAULT TRUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Clubs Table
CREATE TABLE Clubs (
    clubId INT AUTO_INCREMENT PRIMARY KEY,
    clubName VARCHAR(150),
    category VARCHAR(255),
    logoPath VARCHAR(255),
    establishedYear YEAR,
    status ENUM('active', 'suspended', 'inactive'),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Club_Memberships Table
CREATE TABLE Club_Memberships (
    membershipId INT AUTO_INCREMENT PRIMARY KEY,
    userId VARCHAR(10),
    clubId INT,
    Position ENUM('Pres', 'Vice Pres', 'Secr', 'Treas', 'Member'),
    joinYear YEAR,
    isActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (userId) REFERENCES User(userId),
    FOREIGN KEY (clubId) REFERENCES Clubs(clubId)
);

-- CHC Table
CREATE TABLE CHC (
    chcId VARCHAR(10) PRIMARY KEY,
    userId VARCHAR(10),
    positionYear YEAR,
    FOREIGN KEY (userId) REFERENCES User(userId)
);

-- MPP Table
CREATE TABLE MPP (
    mppId VARCHAR(10) PRIMARY KEY,
    userId VARCHAR(10),
    positionYear YEAR,
    FOREIGN KEY (userId) REFERENCES User(userId)
);

-- EventProposal Table
CREATE TABLE EventProposal (
    proposalId INT AUTO_INCREMENT PRIMARY KEY,
    clubId INT,
    createdBy VARCHAR(10),
    title VARCHAR(200),
    description TEXT,
    proposedDate DATE,
    duration INT,
    estimateParticipant INT,
    estimateBudget DECIMAL(10,2),
    Status ENUM('draft', 'submitted', 'pitching', 'mpp review', 'approved', 'heap approval', 'rejected', 'canceled'),
    conflictScore INT DEFAULT NULL,
    aiSuggestion JSON DEFAULT NULL,
    pitchingId INT DEFAULT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (clubId) REFERENCES Clubs(clubId),
    FOREIGN KEY (createdBy) REFERENCES User(userId)
    -- Note: pitchingId references Pitching_Meeting, added below after that table
);

-- Event Table
CREATE TABLE Event (
    eventId INT AUTO_INCREMENT PRIMARY KEY,
    proposalId INT,
    finalDate DATE,
    Venue VARCHAR(150),
    actualPax INT,
    actualBudget DECIMAL(10,2),
    status ENUM('upcoming', 'ongoing', 'completed', 'canceled'),
    startTime TIME,
    endTime TIME,
    FOREIGN KEY (proposalId) REFERENCES EventProposal(proposalId)
);

-- Resource Table
CREATE TABLE Resource (
    resourceId INT AUTO_INCREMENT PRIMARY KEY,
    resourceName VARCHAR(100),
    Type ENUM('internal', 'external', 'manual'),
    contactPIC VARCHAR(100),
    bookingUrl VARCHAR(255),
    IsActive BOOLEAN
);

-- Resource_Booking Table
CREATE TABLE Resource_Booking (
    bookingId INT AUTO_INCREMENT PRIMARY KEY,
    eventId INT,
    resourceId INT,
    bookingDateFrom DATE,
    bookingDateTo DATE,
    status ENUM('requested', 'confirmed', 'rejected', 'cancelled'),
    Remark TEXT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (eventId) REFERENCES Event(eventId),
    FOREIGN KEY (resourceId) REFERENCES Resource(resourceId)
);

-- Master_Calendar Table
CREATE TABLE Master_Calendar (
    calendarId INT AUTO_INCREMENT PRIMARY KEY,
    eventTitle VARCHAR(200),
    eventDate DATE,
    eventType ENUM('Exam', 'Public Holiday', 'Convocation', 'UMT Official', 'Ramadan', 'Others'),
    description TEXT
);

-- Budget_Item Table
CREATE TABLE Budget_Item (
    itemId INT AUTO_INCREMENT PRIMARY KEY,
    itemName VARCHAR(100),
    amount DECIMAL(10,2),
    isActive BOOLEAN
);

-- Proposal_budget_item Table
CREATE TABLE Proposal_budget_item (
    proposalBudgetId INT AUTO_INCREMENT PRIMARY KEY,
    proposalId INT,
    itemId INT,
    Amount DECIMAL(10,2),
    Remark VARCHAR(255),
    FOREIGN KEY (proposalId) REFERENCES EventProposal(proposalId),
    FOREIGN KEY (itemId) REFERENCES Budget_Item(itemId)
);

-- Approval_History Table
CREATE TABLE Approval_History (
    approvalId INT AUTO_INCREMENT PRIMARY KEY,
    proposalId INT,
    approverId VARCHAR(10),
    approvalLevel ENUM('MPP', 'HEPA'),
    Status ENUM('Approved', 'rejected', 'request revision'),
    Comment TEXT,
    approvedAt TIMESTAMP,
    FOREIGN KEY (proposalId) REFERENCES EventProposal(proposalId),
    FOREIGN KEY (approverId) REFERENCES User(userId)
);

-- Pitching_Meeting Table
CREATE TABLE Pitching_Meeting (
    meetingId VARCHAR(10) PRIMARY KEY,
    proposalId INT,
    meetingDate DATETIME,
    location VARCHAR(100),
    outcome ENUM('Pending', 'pass', 'failed', 'reschedule'),
    remark TEXT,
    FOREIGN KEY (proposalId) REFERENCES EventProposal(proposalId)
);

-- Add foreign key for pitchingId in EventProposal (now that Pitching_Meeting exists)
ALTER TABLE EventProposal ADD FOREIGN KEY (pitchingId) REFERENCES Pitching_Meeting(meetingId);

-- Financial_Claim Table
CREATE TABLE Financial_Claim (
    claimId INT AUTO_INCREMENT PRIMARY KEY,
    eventId INT,
    totAmount DECIMAL(10,2),
    status ENUM('Draft', 'submitted', 'approved', 'rejected'),
    submittedAt TIMESTAMP,
    approvedAt TIMESTAMP,
    approvedBy VARCHAR(10),
    FOREIGN KEY (eventId) REFERENCES Event(eventId),
    FOREIGN KEY (approvedBy) REFERENCES User(userId)
);

-- Receipt Table
CREATE TABLE Receipt (
    receiptId INT AUTO_INCREMENT PRIMARY KEY,
    claimId INT,
    receiptPath VARCHAR(255),
    Amount DECIMAL(10,2),
    Description VARCHAR(200),
    FOREIGN KEY (claimId) REFERENCES Financial_Claim(claimId)
);

-- Event_Reports Table
CREATE TABLE Event_Reports (
    reportId INT AUTO_INCREMENT PRIMARY KEY,
    eventId INT,
    reportPath VARCHAR(255),
    actualExpense DECIMAL(10,2),
    attendance INT,
    issues TEXT,
    submittedAt TIMESTAMP,
    status ENUM('Draft', 'submitted', 'accepted', 'missing'),
    FOREIGN KEY (eventId) REFERENCES Event(eventId)
);

-- AGM_Report Table
CREATE TABLE AGM_Report (
    agmId INT AUTO_INCREMENT PRIMARY KEY,
    clubId INT,
    reportYear YEAR,
    reportPath VARCHAR(255),
    submittedAt TIMESTAMP,
    status ENUM('Submitted', 'accepted', 'missing'),
    FOREIGN KEY (clubId) REFERENCES Clubs(clubId)
);

-- Audit_Logs Table
CREATE TABLE Audit_Logs (
    logId INT AUTO_INCREMENT PRIMARY KEY,
    userId VARCHAR(10),  -- Note: Dictionary says "Int", but references User.userId (VARCHAR(10))
    Action VARCHAR(100),
    Description TEXT,
    ipAddress VARCHAR(45),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES User(userId)
);
