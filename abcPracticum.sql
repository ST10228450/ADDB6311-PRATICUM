ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE TABLE instructor
(    ins_id	        varchar2(5)        not null    primary key,
    ins_fname	            varchar2(20)       not null,
  ins_sname			    varchar2(20)       not null,
  ins_contact   varchar2(12)	   not null,
  ins_level     varchar2(5)	   not null
);

Create table CUSTOMER
(
  cust_id	        varchar2(5)        not null    primary key,
  cust_fname	            varchar2(20)       not null,
  cust_sname			    varchar2(20)       not null,
  cust_address   varchar2(30)	   not null,
  cust_contact       	varchar2(12)       not null
);

create table dive
(   dive_id	        varchar2(5)        not null    primary key,
    dive_name	            varchar2(40)       not null,
    dive_duration 			    varchar2(15)       not null,
    dive_location   varchar2(20)	   not null,
    dive_exp_level     varchar2(5)	   not null,
    dive_cost VARCHAR2(8) not null
);




create table  diveEvent
(   dive_event_id	        varchar2(10)        not null    primary key,
    dive_date	            DATE,
    dive_participants 			    varchar2(5)       not null,
    ins_id	         varchar2(5)        not null,
					   CONSTRAINT ins_id
                       FOREIGN KEY (ins_id)
                       REFERENCES instructor(ins_id),
    cust_id	         varchar2(5)        not null,
					   CONSTRAINT cust_id
                       FOREIGN KEY (cust_id)
                       REFERENCES CUSTOMER(cust_id),
    dive_id	         varchar2(5)        not null,
					   CONSTRAINT dive_id
                       FOREIGN KEY (dive_id)
                       REFERENCES dive(dive_id)
);



insert all
    into instructor VALUES('101','James','Willis','0843569851','7')
    into instructor VALUES('102','Sam','Wait','0763698521','2')
    into instructor VALUES('103','Sally','Gumede','0786598521','8')
    into instructor VALUES('104','Bob','Du Preez','0796369857','3')
    into instructor VALUES('105','Simon','Jones','0826598741','9')
SELECT * FROM DUAL;    
select * from dive

insert all 
    into customer VALUES('C115',	'Heinrich',	'Willis',	'3 Main Road',	'0821253659')
    into customer VALUES('C116',	'David','Watson',	'13 Cape Road',	'0769658547')
    into customer VALUES('C117',	'Waldo','Smith',	'3 Mountain Road',	'0863256574')
    into customer VALUES('C118',	'Alex',	'Hanson',	'8 Circle Road',	'0762356587')
    into customer VALUES('C119',	'Kuhle','Bitterhout',	'15 Main Road',	'0821235258')
    into customer VALUES('C120',	'Thando','Zolani',	'88 Summer Road',	'0847541254')
    into customer VALUES('C121',	'Philip','Jackson',	'3 Long Road',	'0745556658')
    into customer VALUES('C122',	'Sarah','Jones',	'7 Sea Road',	'0814745745')
    into customer VALUES('C123',	'Catherine','Howard',	'31 Lake Side Road',	'0822232521')
SELECT * FROM DUAL;      
    
insert all
    into dive VALUES('550',	'Shark Dive', 	'3 hours', 	'Shark Point', 	'8',	'500')
    into dive VALUES('551',	'Coral Dive', 	'1 hour', 	'Break Point', 	'7',	'300')
    into dive VALUES('552',	'Wave Crescent',	'2 hours', 	'Ship wreck ally', 	'3',	'800')
    into dive VALUES('553',	'Underwater Exploration', 	'1 hour', 	'Coral ally', 	'2',	'250')
    into dive VALUES('554',	'Underwater Adventure',	'3 hours', 	'Sandy Beach', 	'3',	'750')
    into dive VALUES('555',	'Deep Blue Ocean',	'30 minutes', 	'Lazy Waves', 	'2',	'120')
    into dive VALUES('556',	'Rough Seas', 	'1 hour', 	'Pipe', 	'9',	'700')
    into dive VALUES('557',	'White Water', 	'2 hours', 	'Drifts', 	'5',	'200')
    into dive VALUES('558',	'Current Adventure',	'2 hours', 	'Rock Lands', 	'3',	'150')
SELECT * FROM DUAL;  
select * from diveevent;
insert ALL 
    INTO diveevent VALUES('de_101',	'15-Jul-17',	'5',	'103',	'C115',	'558')
    INTO diveevent VALUES('de_102',	'16-Jul-17',	'7',	'102',	'C117',	'555')
    INTO diveevent VALUES('de_103',	'18-Jul-17',	'8',	'104',	'C118',	'552')
    INTO diveevent VALUES('de_104',	'19-Jul-17',	'3',	'101',	'C119',	'551')
    INTO diveevent VALUES('de_105',	'21-Jul-17',	'5',	'104',	'C121',	'558')
    INTO diveevent VALUES('de_106',	'22-Jul-17',	'8',	'105',	'C120',	'556')
    INTO diveevent VALUES('de_107',	'25-Jul-17',	'10',	'105',	'C115',	'554')
    INTO diveevent VALUES('de_108',	'27-Jul-17',	'5',	'101',	'C122',	'552')
    INTO diveevent VALUES('de_109',	'28-Jul-17',	'3',	'102',	'C123',	'553')
SELECT * FROM DUAL;

--question 2--
--Create the administrator role
CREATE ROLE admin WITH LOGIN SUPERUSER CREATEDB CREATEROLE INHERIT;

-- Create a user and assign the administrator role
CREATE USER admin_user WITH PASSWORD 'admin_password';
GRANT admin TO admin_user;

CREATE ROLE general WITH LOGIN;
GRANT CONNECT ON DATABASE my_database TO general;
GRANT USAGE ON SCHEMA public TO general;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO general;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO general;
CREATE USER general_user WITH PASSWORD 'general_password';
GRANT general TO general_user;

--QUESTION 3--
SELECT 
i.ins_fname||','||i.ins_sname as INSTRUCTOR,
c.cust_fname||','||c.cust_sname as CUSTOMER,
d.dive_location,
de.dive_participants
from instructor i
join diveEvent de on i.ins_id = de.ins_id
join dive d on de.dive_id = d.dive_id
join customer c on de.cust_id = c.cust_id
where dive_participants Between 8 and 10;

--question 4--
SET SERVEROUTPUT ON;
DECLARE 
v_dive_name dive.dive_name%TYPE;
v_dive_date diveEvent.dive_date%TYPE;
v_dive_participants diveEvent.dive_participants%TYPE;
cursor c1
IS
select
d.dive_name,
de.dive_date,
de.dive_participants
from dive d
join diveEvent de on d.dive_id = de.dive_id
where dive_participants >= 10;
BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_dive_name,v_dive_date,v_dive_participants;
EXIT WHEN c1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('DIVE NAME:'||v_dive_name);
DBMS_OUTPUT.PUT_LINE('DIVE DATE:'||v_dive_date);
DBMS_OUTPUT.PUT_LINE('PARTICIPANTS:'||v_dive_participants);
DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END LOOP;
CLOSE c1;
END;
/

--QUESTION 5--
DECLARE

CURSOR dive_cursor IS
SELECT c.cust_fname||','||c.cust_sname, d.dive_name,de.dive_participants
FROM DiveEvent de 
join customer c on c.cust_id = de.cust_id
join dive d on de.dive_id = d.dive_id
WHERE dive_cost >500;

v_full_name Customer.cust_fname%TYPE;
v_dive_name dive.dive_name%TYPE;
v_dive_participants diveEvent.dive_participants%TYPE;
v_status NUMBER;
BEGIN
OPEN dive_cursor;
LOOP
FETCH dive_cursor INTO v_full_name, v_dive_name, v_dive_participants;
EXIT WHEN dive_cursor%NOTFOUND;
IF v_dive_participants <= 4 THEN
v_status := 1;
ELSIF v_dive_participants BETWEEN 5 AND 7 THEN
v_status := 2;
ELSE
v_status := 3;
END IF;
DBMS_OUTPUT.PUT_LINE('CUSTOMER:'||v_full_name);
DBMS_OUTPUT.PUT_LINE('DIVE NAME:'||v_dive_name);
DBMS_OUTPUT.PUT_LINE('PARTICIPANTS:'||v_dive_participants);
DBMS_OUTPUT.PUT_LINE('STATUS: '||v_status||' '||'instructors required');
DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END LOOP;
CLOSE dive_cursor;
END;
/
--question 6--
CREATE VIEW Vw_Dive_Event AS
select 
de.ins_id,
de.cust_id,
c.cust_address,
d.dive_duration,
de.dive_date
from diveEvent de 
join customer c on de.cust_id = c.cust_id
join dive d on de.dive_id = d.dive_id
where dive_date < TO_DATE('19-Jul-17','DD-MM-YY');
select * from Vw_Dive_Event;

--QUESTION 7--
CREATE OR REPLACE TRIGGER New_Dive_Event
BEFORE INSERT OR UPDATE ON DiveEvent
FOR EACH ROW
BEGIN
IF :NEW.dive_participants <= 0 OR :NEW.dive_participants > 20 THEN
RAISE_APPLICATION_ERROR(-20001, 'Invalid number of participants. It must be between 1 and 20.');
END IF;
END;
/
--Test case 1: Attempt to insert with 0 participants
INSERT INTO DiveEvent VALUES(110,'27-Jul-2023',0,54,'C121', 3);
INSERT INTO DiveEvent VALUES(999,'27-Jul-2023',24,86,'C197', 5);

--Question 8 --
CREATE OR REPLACE PROCEDURE sp_Customer_Details (
    p_CUST_ID CUSTOMER.CUST_ID%TYPE,
    p_DIVE_DATE diveEvent.DIVE_DATE%TYPE
) IS
    v_customer_name VARCHAR2(100);
    v_dive_name VARCHAR2(100);
BEGIN
    SELECT c.CUST_FNAME || ' ' || c.CUST_SNAME, d.DIVE_NAME
    INTO v_customer_name, v_dive_name
    FROM diveEvent de
    JOIN CUSTOMER c ON de.CUST_ID = c.CUST_ID
    JOIN DIVE d ON de.DIVE_ID = d.DIVE_ID
    WHERE de.CUST_ID = p_CUST_ID
    AND de.DIVE_DATE = p_DIVE_DATE;
   
    DBMS_OUTPUT.PUT_LINE('CUSTOMER DETAILS: ' || v_customer_name || ' booked for the ' || v_dive_name || ' on ' || TO_CHAR(p_DIVE_DATE, 'DD/MON/YYYY') || '.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No booking found for customer ID ' || p_CUST_ID || ' on ' || TO_CHAR(p_DIVE_DATE, 'DD/MON/YYYY') || '.');
END;
/
BEGIN
sp_Customer_Details('C115', TO_DATE('15-JUL-2017', 'DD-MON-YYYY'));
END;
/
BEGIN
sp_Customer_Details('C999', TO_DATE('01-JAN-2020', 'DD-MON-YYYY'));
END;
/
--Question 9--
CREATE OR REPLACE FUNCTION fn_CompanyRevenue (
    p_INS_ID IN INSTRUCTOR.INS_ID%TYPE,
    p_START_DATE IN DATE,
    p_END_DATE IN DATE
) RETURN NUMBER
IS
    v_total_revenue NUMBER := 0;
BEGIN
    SELECT SUM(d.DIVE_COST * de.DIVE_PARTICIPANTS)
    INTO v_total_revenue
    FROM diveEvent de
    JOIN DIVE d ON de.DIVE_ID = d.DIVE_ID
    WHERE de.INS_ID = p_INS_ID
    AND de.DIVE_DATE BETWEEN p_START_DATE AND p_END_DATE;
    RETURN v_total_revenue;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN -1;
END;
/
DECLARE
    v_revenue NUMBER;
BEGIN
    v_revenue := fn_CompanyRevenue(101, TO_DATE('01-JAN-2017', 'DD-MON-YYYY'), TO_DATE('31-DEC-2017', 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Total Revenue: ' || v_revenue);
END;
/
--QUESTION 10--
--GUI FOR sp_Customer_Details--
// main.cpp
#include <QApplication>
#include <QWidget>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QMessageBox>
#include <QtSql>
#include <QDebug>
#include <QVBoxLayout>

class MainWindow : public QWidget {
    Q_OBJECT
    
public:
    MainWindow(QWidget *parent = nullptr) : QWidget(parent) {
        setupUI();
    }

private slots:
    void showCustomerDetails() {
        QString cust_id = custIdLineEdit->text();
        QString dive_date = diveDateLineEdit->text();

        QSqlDatabase db = QSqlDatabase::addDatabase("QOCI");
        db.setHostName("your_host");
        db.setDatabaseName("your_service_name");
        db.setUserName("your_username");
        db.setPassword("your_password");

        if (!db.open()) {
            QMessageBox::critical(this, "Database Error", db.lastError().text());
            return;
        }

        QSqlQuery query;
        query.prepare("BEGIN sp_Customer_Details(:cust_id, TO_DATE(:dive_date, 'DD-MON-YYYY')); END;");
        query.bindValue(":cust_id", cust_id);
        query.bindValue(":dive_date", dive_date);

        if (!query.exec()) {
            QMessageBox::critical(this, "Query Error", query.lastError().text());
            return;
        }

        // Display the result using QMessageBox
        query.next(); // Assuming the procedure outputs to DBMS_OUTPUT.PUT_LINE
        QString message = query.lastError().isValid() ? "No booking found for customer ID " + cust_id + " on " + dive_date + "."
                                                      : "Procedure executed successfully.";
        QMessageBox::information(this, "Procedure Result", message);

        db.close();
    }

private:
    QLabel *custIdLabel;
    QLineEdit *custIdLineEdit;
    QLabel *diveDateLabel;
    QLineEdit *diveDateLineEdit;
    QPushButton *showDetailsButton;

    void setupUI() {
        QVBoxLayout *layout = new QVBoxLayout(this);

        custIdLabel = new QLabel("Customer ID:", this);
        custIdLineEdit = new QLineEdit(this);

        diveDateLabel = new QLabel("Dive Date (DD-MON-YYYY):", this);
        diveDateLineEdit = new QLineEdit(this);

        showDetailsButton = new QPushButton("Show Customer Details", this);
        connect(showDetailsButton, &QPushButton::clicked, this, &MainWindow::showCustomerDetails);

        layout->addWidget(custIdLabel);
        layout->addWidget(custIdLineEdit);
        layout->addWidget(diveDateLabel);
        layout->addWidget(diveDateLineEdit);
        layout->addWidget(showDetailsButton);

        setLayout(layout);
        setWindowTitle("Customer Details Viewer");
    }
};

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);

    MainWindow window;
    window.show();

    return app.exec();
}


--GUI FOR fn_CompanyRevenue--
// main.cpp 

#include <QApplication> 

#include <QWidget> 

#include <QLabel> 

#include <QLineEdit> 

#include <QPushButton> 

#include <QMessageBox> 

#include <QtSql> 

#include <QDebug> 

#include <QVBoxLayout> 

  

class MainWindow : public QWidget { 

    Q_OBJECT 

     

public: 

    MainWindow(QWidget *parent = nullptr) : QWidget(parent) { 

        setupUI(); 

    } 

  

private slots: 

    void calculateRevenue() { 

        int ins_id = insIdLineEdit->text().toInt(); 

        QString start_date = startDateLineEdit->text(); 

        QString end_date = endDateLineEdit->text(); 

  

        QSqlDatabase db = QSqlDatabase::addDatabase("QOCI"); 

        db.setHostName("your_host"); 

        db.setDatabaseName("your_service_name"); 

        db.setUserName("your_username"); 

        db.setPassword("your_password"); 

  

        if (!db.open()) { 

            QMessageBox::critical(this, "Database Error", db.lastError().text()); 

            return; 

        } 

  

        QSqlQuery query; 

        query.prepare("BEGIN :result := fn_CompanyRevenue(:ins_id, TO_DATE(:start_date, 'DD-MON-YYYY'), TO_DATE(:end_date, 'DD-MON-YYYY')); END;"); 

        query.bindValue(":result", QVariant::Double); 

        query.bindValue(":ins_id", ins_id); 

        query.bindValue(":start_date", start_date); 

        query.bindValue(":end_date", end_date); 

  

        if (!query.exec()) { 

            QMessageBox::critical(this, "Query Error", query.lastError().text()); 

            return; 

        } 

  

        query.next(); 

        double total_revenue = query.value(0).toDouble(); 

        resultLabel->setText("Total Revenue: " + QString::number(total_revenue)); 

  

        db.close(); 

    } 

  

private: 

    QLabel *insIdLabel; 

    QLineEdit *insIdLineEdit; 

    QLabel *startDateLabel; 

    QLineEdit *startDateLineEdit; 

    QLabel *endDateLabel; 

    QLineEdit *endDateLineEdit; 

    QPushButton *calculateButton; 

    QLabel *resultLabel; 

  

    void setupUI() { 

        QVBoxLayout *layout = new QVBoxLayout(this); 

  

        insIdLabel = new QLabel("Instructor ID:", this); 

        insIdLineEdit = new QLineEdit(this); 

  

        startDateLabel = new QLabel("Start Date (DD-MON-YYYY):", this); 

        startDateLineEdit = new QLineEdit(this); 

  

        endDateLabel = new QLabel("End Date (DD-MON-YYYY):", this); 

        endDateLineEdit = new QLineEdit(this); 

  

        calculateButton = new QPushButton("Calculate Revenue", this); 

        connect(calculateButton, &QPushButton::clicked, this, &MainWindow::calculateRevenue); 

  

        resultLabel = new QLabel(this); 

  

        layout->addWidget(insIdLabel); 

        layout->addWidget(insIdLineEdit); 

        layout->addWidget(startDateLabel); 

        layout->addWidget(startDateLineEdit); 

        layout->addWidget(endDateLabel); 

        layout->addWidget(endDateLineEdit); 

        layout->addWidget(calculateButton); 

        layout->addWidget(resultLabel); 

  

        setLayout(layout); 

        setWindowTitle("Company Revenue Calculator"); 

    } 

}; 

  

int main(int argc, char *argv[]) { 

    QApplication app(argc, argv); 

  

    MainWindow window; 

    window.show(); 

  

    return app.exec(); 

} 







    
    


 				
			
 				




	 				










    






                       
    