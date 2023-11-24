CREATE TABLE IF NOT EXISTS scan (
      id TEXT NOT NULL PRIMARY KEY, 
      scanType TEXT NOT NULL,
      createdAt TEXT NOT NULL,
      isAdmin INTEGER NOT NULL,
      qrData TEXT NOT NULL
      );