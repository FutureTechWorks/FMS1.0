from flask import Flask,request
from flask import render_template
import pyodbc

app = Flask(__name__)

server = '(localdb)\MSSQLLocalDB'
database = 'FMS'
username = ''
password = ''
connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

try:
    cursor = connection.cursor()
    cursor.execute("SELECT 1")
    print("Connection established successfully.")
except:
    print("Connection failed.")

@app.route('/')
@app.route('/Home')
def Home():
    return render_template('Index.html')

@app.route('/FeePendingStudents',methods=["GET","POST"])
def FeePendingStudents():
    if request.method=="POST":
        ClassInput = request.form['Class']
        SectionInput = request.form['Section']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_GetFeePendingStudents'
        cursor.execute("EXEC " + procedure_name + " ?, ?", ClassInput, SectionInput)
        data = cursor.fetchall()
        #print(data)
        return render_template('StudentList.html',data=data)
    return render_template('FeePendingStudents.html')

@app.route('/FeeCompletedStudents',methods=["GET","POST"])
def FeeCompletedStudents():
    if request.method=="POST":
        ClassInput = request.form['Class']
        SectionInput = request.form['Section']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_GetNoFeeDueStudents'
        cursor.execute("EXEC " + procedure_name + " ?, ?", ClassInput, SectionInput)
        data = cursor.fetchall()
        #print(data)
        return render_template('StudentList.html',data=data)
    return render_template('FeeCompletedStudents.html')

@app.route('/TotalFeeCollected',methods=["GET","POST"])
def TotalFeeCollected():
    procedure_name = 'FMS_GetTotalFeeDetails'
    cursor.execute("EXEC " + procedure_name)
    data = cursor.fetchall()
    #print(data)
    return render_template('TotalFeeCollected.html',data=data)

@app.route('/PayFee',methods=["GET","POST"])
def PayFee():
    if request.method=="POST":
        ID = request.form['ID']
        PayFee = request.form['PayFee']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_FeePayment'
        cursor.execute("EXEC " + procedure_name + " ?, ?", ID, PayFee)
        connection.commit()
        #data = cursor.fetchall()
        #print(data)
        response = "Fee Paid successfully"
        return render_template('Response.html',response=response)
    return render_template('PayFee.html')

@app.route('/GetStudentDetails',methods=["GET","POST"])
def GetStudentDetails():
    if request.method=="POST":
        ClassInput = request.form['Class']
        SectionInput = request.form['Section']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_GetStudentDetails'
        cursor.execute("EXEC " + procedure_name + " ?, ?", ClassInput, SectionInput)
        data = cursor.fetchall()
        #print(data)
        return render_template('StudentDetails.html',data=data)
    return render_template('StudentDetailsForm.html')

@app.route('/GetFeeDetailsHistory',methods=["GET","POST"])
def GetFeeDetailsHistory():
    if request.method=="POST":
        ID = request.form['ID']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_GetFeeDetailsOfStudent'
        cursor.execute("EXEC " + procedure_name + " ?", ID)
        data = cursor.fetchall()
        print(data)
        return render_template('FeeDetailsHistory.html',data=data)
    return render_template('Index.html')

@app.route('/AddStudentDetails',methods=["GET","POST"])
def AddStudentDetails():
    if request.method=="POST":
        ID = request.form['ID']
        StudentName = request.form['StudentName']
        ClassInput = request.form['Class']
        SectionInput = request.form['Section']
        DOJ = request.form['DOJ']
        print(DOJ)
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_InsertStudentDetails'
        cursor.execute("EXEC " + procedure_name + " ?, ?, ?, ?, ?", ID, StudentName,ClassInput,SectionInput,DOJ)
        connection.commit()
        #data = cursor.fetchall()
        #print(data)
        #response = "Fee Paid successfully"
        return render_template('AddPersonalDetails.html')
    return render_template('AddStudentDetails.html')

@app.route('/AddPersonalDetails',methods=["GET","POST"])
def AddPersonalDetails():
    if request.method=="POST":
        ID = request.form['ID']
        FatherName = request.form['FatherName']
        MotherName = request.form['MotherName']
        GuardianName = request.form['GuardianName']
        MOB = request.form['MOB']
        AMOB = request.form['AMOB']
        DOB = request.form['DOB']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_InsertPersonalDetails'
        cursor.execute("EXEC " + procedure_name + " ?, ?, ?, ?, ?, ?, ?", ID, FatherName,MotherName,GuardianName,MOB,AMOB,DOB)
        connection.commit()
        #data = cursor.fetchall()
        #print(data)
        #response = "Fee Paid successfully"
        return render_template('AddAddressDetails.html')
    return render_template('AddPersonalDetails.html')

@app.route('/AddAddressDetails',methods=["GET","POST"])
def AddAddressDetails():
    if request.method=="POST":
        ID = request.form['ID']
        Street = request.form['Street']
        Door = request.form['Door']
        City = request.form['City']
        Village = request.form['Village']
        Pin = request.form['Pin']
        State = request.form['State']
        Country = request.form['Country']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_InsertAddressDetails'
        cursor.execute("EXEC " + procedure_name + " ?, ?, ?, ?, ?, ?, ?, ?", ID, Street,Door,City,Village,Pin,State,Country)
        connection.commit()
        #data = cursor.fetchall()
        #print(data)
        #response = "Fee Paid successfully"
        return render_template('AddFeeDetails.html')
    return render_template('AddAddressDetails.html')

@app.route('/AddFeeDetails',methods=["GET","POST"])
def AddFeeDetails():
    if request.method=="POST":
        ID = request.form['ID']
        FTB = request.form['FTB']
        FeePaid = request.form['FeePaid']
        Due = request.form['Due']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_InsertFeeDetails'
        cursor.execute("EXEC " + procedure_name + " ?, ?, ?, ?", ID, FTB,FeePaid,Due)
        connection.commit()
        #data = cursor.fetchall()
        #print(data)
        response = "Student Added successfully"
        return render_template('Response.html',response = response)
    return render_template('AddFeeDetails.html')

@app.route('/DeleteStudent',methods=["GET","POST"])
def DeleteStudent():
    if request.method=="POST":
        ID = request.form['ID']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_DeleteStudent'
        cursor.execute("EXEC " + procedure_name + " ?", ID)
        connection.commit()
        #data = cursor.fetchall()
        #print(data)
        response = "Student Deleted successfully"
        return render_template('Response.html',response = response)
    return render_template('DeleteStudent.html')

@app.route('/UpdateStudent',methods=["GET","POST"])
def UpdateStudent():
    if request.method=="POST":
        ID = request.form['ID']
        ClassInput = request.form['Class']
        SectionInput = request.form['Section']
        FTB = request.form['FTB']
        #print(ClassInput,SectionInput)
        procedure_name = 'FMS_UpdateStudent'
        cursor.execute("EXEC " + procedure_name + " ?, ?, ?, ?", ID,ClassInput,SectionInput,FTB)
        connection.commit()
        #data = cursor.fetchall()
        #print(data)
        response = "Student Updated successfully"
        return render_template('Response.html',response = response)
    return render_template('UpdateStudent.html')

if __name__ == '__main__':
    app.run(debug=True)
