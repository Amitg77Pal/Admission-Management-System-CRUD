![image](https://github.com/user-attachments/assets/b8d1f9d8-3f34-4e65-b0d5-e3450677378a)
![image](https://github.com/user-attachments/assets/852ddeb9-9757-437f-ab20-6105faee87b9)
![image](https://github.com/user-attachments/assets/9aa93f1e-aa89-4f5c-acc6-482126b1fa10)
![image](https://github.com/user-attachments/assets/e3e264dc-d9c7-47a7-ad53-7e1eb815f6e4)
![image](https://github.com/user-attachments/assets/afec8b3a-9ac5-44b5-8add-5f2f8a730d9d)
![image](https://github.com/user-attachments/assets/e17f9413-5fcb-4167-a657-326f6760f115)
![image](https://github.com/user-attachments/assets/d5cf9e27-cdff-4336-9648-eb1ac7e80cb1)
![image](https://github.com/user-attachments/assets/180244bd-9d0e-4da7-a3c9-f7cac529f8d9)
![image](https://github.com/user-attachments/assets/28d8be74-631c-4145-b691-f56b256b564a)
![image](https://github.com/user-attachments/assets/da3547e3-103f-4e34-88b6-1fb7a6bb7f97)
![image](https://github.com/user-attachments/assets/5bdce6bd-5fb0-46f4-a36d-096b71aaaa85)
![image](https://github.com/user-attachments/assets/376bc7c3-2ff9-4139-899d-45dba3be9af7)

<br/>
<br/>

-- Create Database
<br/>
CREATE DATABASE AdmissionSystem;
<br/>
USE AdmissionSystem;
<br/>

-- Create the registration table
<br/>
CREATE TABLE registration (
<br/>
    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each registration
    <br/>
    name VARCHAR(100) NOT NULL,
    <br/>
    dob DATE NOT NULL,
    <br/>
    email VARCHAR(255) NOT NULL UNIQUE,
    <br/>
    mobile_number VARCHAR(15) NOT NULL,
    <br/>
    address TEXT NOT NULL,
    <br/>
    course_selection VARCHAR(100) NOT NULL,
    <br/>
    password VARCHAR(255) NOT NULL
    <br/>
);
<br/>

-- Create the login table
<br/>
CREATE TABLE login (
<br/>
    email VARCHAR(255) NOT NULL,
    <br/>
    password VARCHAR(255) NOT NULL,
    <br/>
    captcha_code VARCHAR(10) NOT NULL,
    <br/>
    PRIMARY KEY (email),
    <br/>
    FOREIGN KEY (email) REFERENCES registration(email) 
    <br/>
        ON DELETE CASCADE 
        <br/>
        ON UPDATE CASCADE
        <br/>
);
<br/>
Save the folder on webapps on tomacate server then connect the database to project using root and password after that Run this program on localhost:8080
