# Advanced Databases Final Project: House Services Database


## 📚 Course Information
- **Course**: Avanced Databases
- **Semester**: 2025-1
- **Institution**: Universidad Nacional Autónoma de México (UNAM), Facultad de Ingeniería
- **Instructor**: Ing. Jorge Alberto Rodríguez Campos

## 👥 Team Members
- Arias Quintero, Luis Antonio
- Ríos Lira, Gamaliel

---

## 📖 Project Overview
This project is the culmination of the **Advanced Databases** course at the **Universidad Nacional Autónoma de México (UNAM)**. The primary objective was to design and implement a robust database system using **Oracle 23AI** that incorporates advanced database administration techniques and automation scripts.

### 🎯 Case Study: House Services
The database was designed for "House Services" a social network connecting clients and service providers for home maintenance tasks. The system handles:

- **Registration** of providers, including their credentials, offered services, and experience proofs.
- **Client profiles** for businesses and individuals.
- **Service booking, payment, and status tracking**.
- **Reviews and ratings** for completed services.

The project integrates complex data relationships, including:
- Multi-tenant structures with CDB (Container Database) and PDBs (Pluggable Databases).
- Storage and retrieval of multimedia content.
- Partitioning large tables to handle scalability.
- Security measures for sensitive data like banking details.

---

## ⚙️ Key Features

### Database Administration
- **Redo Log Management**: Configured and monitored redo logs for recovery and transaction integrity.
- **Tablespace Management**: Created and optimized tablespaces for efficient data storage and query performance.
- **User Administration**: Designed roles and privileges for database users, ensuring secure and structured access.
- **Pluggable Databases (PDBs)**: Implemented and managed multiple PDBs under a single CDB for multi-tenancy.

### Backup and Recovery
- **Backup Strategies**: Configured regular backups and recovery settings, leveraging Oracle's Fast Recovery Area (FRA).
- **Automated Recovery Testing**: Ensured recovery processes were operational using automated scripts.

### Data Population
- **PL/SQL Scripting**: Developed scripts to populate the database with realistic workload of data, simulating millions of clients and thousands of daily transactions.

### Automation and Scripting
- **Bash Scripting**: Automated database setup tasks, including:
  - Creation of the CDB and PDBs.
  - Configuration of redo logs, tablespaces, and users.
  - Backup and FRA management.

---

## Technical Highlights
- **Database Software**: Oracle Database 23AI
- **Scripting Languages**: PL/SQL, Bash
- **Scalability**: Implemented partitioning for high-traffic tables to ensure performance.
- **Security**:
  - Encryption of sensitive information.
  - Separate entities for storing banking details.
- **Multimedia Storage**: Configured separate tablespaces for multimedia content, supporting photos and potential video integration.

---

## Challenges and Learnings
- **Database Scalability**: Partitioning was crucial to maintain performance with large datasets.
- **Backup and Recovery**: Ensured data integrity through extensive testing of backup strategies.
- **Automation**: Leveraged Bash scripting for efficient setup and management.
