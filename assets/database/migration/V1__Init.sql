CREATE TABLE IF NOT EXISTS scan (
      id TEXT PRIMARY KEY,
      scanType TEXT NOT NULL,
      createdAt TEXT NOT NULL
      );
CREATE TABLE IF NOT EXISTS email (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      addressEmail TEXT,
      body TEXT,
      subjectEmail TEXT,
      scanId TEXT NOT NULL,
      FOREIGN KEY (scanId) REFERENCES scan (id) ON DELETE CASCADE 
      );
CREATE TABLE IF NOT EXISTS phone (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      numberPhone TEXT,
      scanId TEXT NOT NULL,
      FOREIGN KEY (scanId) REFERENCES scan (id) ON DELETE CASCADE
      );
CREATE TABLE IF NOT EXISTS sms (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      phoneNumber TEXT NOT NULL,
      messageSms TEXT,
      scanId TEXT NOT NULL,
      FOREIGN KEY (scanId) REFERENCES scan (id) ON DELETE CASCADE
      );
CREATE TABLE IF NOT EXISTS urlBookmark (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      urlBookmark TEXT NOT NULL,
      title TEXT,
      scanId TEXT NOT NULL,
      FOREIGN KEY (scanId) REFERENCES scan (id) ON DELETE CASCADE
      );
CREATE TABLE IF NOT EXISTS wifi (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      passwordWifi TEXT,
      ssid TEXT,
      encryptionType TEXT,
      scanId TEXT NOT NULL,
      FOREIGN KEY (scanId) REFERENCES scan (id) ON DELETE CASCADE
      );