
<img width="904" alt="image" src="https://github.com/user-attachments/assets/6595d35f-6a0b-4ed8-87eb-e024794c1f56
" />
<img width="874" alt="image" src="https://github.com/user-attachments/assets/ab9f8833-d32f-4d3e-9582-5072115d1592
" />

<img width="898" alt="image" src="https://github.com/user-attachments/assets/370f0c63-ad4b-4f18-9b60-0d28a45ecc35
" />

<img width="910" alt="image" src="https://github.com/user-attachments/assets/c0e85bad-3b6d-4568-a277-2680788d4662
" />

<img width="897" alt="image" src="https://github.com/user-attachments/assets/5c6bef45-07e2-4b6a-b26c-57f1b6ff9af1
" />

<img width="895" alt="image" src="https://github.com/user-attachments/assets/05062e12-2849-493f-b993-79d8f72b81fe
" />

<img width="951" alt="image" src="https://github.com/user-attachments/assets/a95ce540-6bf7-4a3d-9dc8-6e236dd0c011
" />
<img width="951" alt="image" src="https://github.com/user-attachments/assets/94f6027a-5161-4d93-a161-924e4c1049ff
" />
<img width="951" alt="image" src="https://github.com/user-attachments/assets/0901404d-02ac-4168-b5db-dcd09d3da0b7
" />
<img width="951" alt="image" src="https://github.com/user-attachments/assets/4ad2a95a-c496-4bb3-984f-f7570c14fa5f
" />
<img width="951" alt="image" src="https://github.com/user-attachments/assets/923c044e-4681-4ee7-9b5a-85459b39bb57
" />
<img width="951" alt="image" src="https://github.com/user-attachments/assets/5ab0439d-e056-4ac1-bf66-5ffb94f462a7
" />
![image](https://github.com/user-attachments/assets/376bc7c3-2ff9-4139-899d-45dba3be9af7)

<br/>
<br/>

-- Create Database
CREATE DATABASE AdmissionSystem;
USE AdmissionSystem;

-- Create the registration table
CREATE TABLE registration (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each registration
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    mobile_number VARCHAR(15) NOT NULL,
    address TEXT NOT NULL,
    course_selection VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Create the login table
CREATE TABLE login (
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    captcha_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (email),
    FOREIGN KEY (email) REFERENCES registration(email) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
Save the folder on webapps on tomacate server then connect the database to project using root and password after that Run this program on localhost:8080
