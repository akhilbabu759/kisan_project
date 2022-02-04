from flask import Flask, render_template, request, redirect, session
from DBConnection import Db
import datetime

app = Flask(__name__)
app.secret_key = "abc"

syspath=r"C:\Users\akhil\PycharmProject\flaskProject5\static\kisan\\"

@app.route('/',methods=['GET','POST'])
def login():
    if request.method=="POST":
        uname=request.form['username']
        password=request.form['password']

        db = Db()
        res = db.selectOne("select * from login where user_name = '"+uname+"' and password = '"+password+"' ")
        session["lid"] = res['login_id']

        if res is not None:
            if res['user_type'] == 'admin':
                return redirect('/home')

            elif res['user_type'] == 'center':

                return redirect('/center_home')

            elif res['user_type'] == 'user':
                 return render_template('user/user_home.html')

            else:
                return "invalid user type"
        else:
            return "user not found"






    else:
        return render_template("login.html")



@app.route('/view_approved_center')
def view_approved_center():
    qry = "select *from center where status='pending'"
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/Approve Center.html", res=res)

@app.route('/approved_center_view')########################################
def approved_center_view():
    qry = "select *from center where status='approved'"
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/Approved Center View.html",res=res)

@app.route('/soil_report')
def soil_report():
    qry = "select * from soil_report,user where soil_report.user_id=user.user_id and soil_report.status='booked'"
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/View Booking Master.html",res=res)

@app.route('/booking_master_report/<b_id>',methods=['GET','POST'])
def booking_master_report(b_id):
    if request.method=="POST":
        rprt=request.files['fileField']
        d=datetime.datetime.now().strftime("%Y%m%d%H%M%S")
        rprt.save(syspath+d+'.pdf')
        path='/static/kisan/'+d+'.pdf'
        db = Db()
        db.update("update soil_report set status = '"+path+"' where soilreport_id='" +str( b_id) + "' ")
        return "OK"

    else:
        return render_template("admin/Booking Master Report.html")

@app.route('/complaint')
def complaint():
    qry = "select * from complaint,user where complaint.user_id=user.user_id;"
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/View Complaint.html",res=res)

@app.route('/complaint_replay/<c_id>',methods=['GET','POST'])
def complaint_replay(c_id):
    if request.method=="POST":
        reply=request.form['textarea']
        db = Db()
        db.update("update complaint set reply = '"+reply+"', reply_date=curdate() where compaint_id = '"+c_id+"'")
        return ''' <script> alert("Send Sucessfully");window.location = "/complaint"  </script>'''
    else:
        return render_template("admin/Complaint Replay.html")

@app.route('/feedback')
def feedback():
    qry = "select *from feedback"
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/View feedback.html",res=res)

@app.route('/rating')
def rating():
    qry = "SELECT rating.user_id ,rating.rating,user.user_name FROM rating INNER JOIN user ON rating.user_id=user.user_id;"
    obj = Db()
    res = obj.select(qry)
    print(res)
    return render_template("admin/view _rating.html",data=res)

@app.route('/product')
def product():
    qry = "select * from product"
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/View Product.html",res=res)

@app.route('/booking')
def booking():
    qry = " select * from booking_master,user where  booking_master.user_id=user.user_id and booking_master.status='booked'"
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/View BOOKING.HTML",res=res)

@app.route('/view_booked_products/<mid>')
def view_booked_products(mid):
    qry = " select  booking.*,product.*,booking.quantity*product.price as sum from booking,product where  booking.product_id=product.product_id and booking.master_id='"+mid+"'"
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/View booked products.HTML",res=res)

@app.route('/payment')
def payment():
    qry = "select * from user,payment where user.user_id=payment.user_id; "
    obj = Db()
    res = obj.select(qry)
    return render_template("admin/View Payment.html",res=res)

@app.route('/user')
def user():
    qry= "select *from user"
    obj=Db()
    res=obj.select(qry)
    return render_template("admin/View User.html", res=res)

@app.route('/home')
def home():
    return render_template("admin/admin home.html")



@app.route('/approve_center/<center_id>')
def approve_center(center_id):
    db = Db()
    ##db.update("update center set status = 'center' where c_id='"+center_id+"' ")
    db.update("update center set status = 'approved' where c_id='" + center_id + "' ")

    return 'ok'
    # return render_template("admin/admin home.html")
@app.route('/reject_center/<center_id>')
def reject_center(center_id):
    db = Db()
    db.delete("DELETE FROM center where c_id ='"+center_id+"' ")
    return "OK"

##CENTER


@app.route('/center_registration',methods=['GET','POST'])
def center_registration():
    if request.method=='POST':
        name=request.form['abc']
        street=request.form['str']
        locality=request.form['local']
        district=request.form['district']
        phn=request.form['ph']
        email=request.form['eml']
        passw= request.form['pas']
        db=Db()
        pen="pending"
        ce="center"
        db.insert("insert into center VALUE ('','"+name+"','"+street+"','"+locality+"','"+district+"','"+phn+"','"+email+"','"+pen+"')")
        db.insert("insert into login VALUE('','"+name+"','"+passw+"','"+ce+"')")
        return ''' <script> alert("Send Sucessfully");window.location = "/"  </script>'''


    else:
        return render_template('center/center_registraction.html')


@app.route('/center_view_profile')
def center_view_profile():
    obj=Db()
    print(session["lid"])
    qry="select * from center where c_id= '"+str(session["lid"])+"'"
    res = obj.selectOne(qry)
    return render_template('center/center profile view.html', res=res)



@app.route('/center_home')
def center_home():
    return render_template("center/center home.html")



@app.route('/notification')#####################################################
def notification():
    if request.method == "POST":
        reply = request.form['textarea']
        db = Db()
        db.update(
            "update complaint set reply = '" + reply + "', reply_date=curdate() where compaint_id = '" + c_id + "'")
        return ''' <script> alert("Send Sucessfully");window.location = "/complaint"  </script>'''
    else:
        return render_template('center/notification.html')



@app.route('/query')
def query():
    qry = "select * from query,user where query.user_id=user.user_id;"
    obj = Db()
    res = obj.select(qry)
    return render_template("center/Query view.html",res=res)

@app.route('/query_reply/<Q_id>',methods=['GET','POST'])
def query_reply(Q_id):

    if request.method=="POST":
        reply=request.form['textarea']
        db = Db()
        db.update("update query set reply = '"+reply+"', reply_date=curdate() where q_id = '"+Q_id+"'")
        return ''' <script> alert("Send Sucessfully");window.location = "/query"  </script>'''
    else:
        return render_template("center/Query reply.html")

@app.route('/view_center_bookings')
def view_center_bookings():
    qry = "select * from delvery,center where delvery.statuse='pending' AND center.locality=delvery.locality AND center.c_id='"+str(session["lid"])+"'"
    obj = Db()

    res = obj.select(qry)
    print(res)
    return render_template("center/view booking.html", res=res)


#@app.route('/qu_reply/<Q_id>',methods=['GET','POST'])
#def query_reply(Q_id):
    #return render_template("center/Query reply.html")

# @app.route('/center_update/<c_id>',methods=['GET','POST'])
# def center_update(c_id):
#     db = Db()
#     qry = "select * from center where c_id=c_id"
#     res=db.selectOne(qry)
#     if request.method=='POST':
#         db=Db()
#         name=request.form['abc']
#         street=request.form['str']
#         locality=request.form['local']
#         district=request.form['district']
# +       phn=request.form['ph']
        # email=request.form['eml']
        # passw= request.form['pas']
        # db=Db()
        # db.update("update center set c_name = '" + name + "',street = '"+street+"',locality = '"+locality+"', district = '"+district+"', phone_no='"+phn+"',email='"+email+"'  where c_id ='"+c_id+"'")
        # db.update("update login set user_name='" + name + "',password='"+passw+"' where login_id='"+c_id+"'")
        # return ''' <script> alert("Send Sucessfully");window.location = "/center_view/<c_id>"  </script>'''
    # else:
    #
    #     return render_template('center/update_'
    #                            center.html',res=res)


# @app.route('/view_booking_center'/<u_id>',methods=['GET','POST'])
# def view_booking_center(u_id):
#     db = Db()
#     qry = "select * from booking,center,user where booking.street =center.street"
#     res=db.select(qry)
#     if request.method=='POST':
#         db=Db()
#         noet=request.form['textarea']
#
#         db.insert("insert into notification VALUE('','"+noet+"','" + u_id + "','"+curdate()+"','" + curtime()+ "')")
#         return ''' <script> alert("Send Sucessfully");window.location = "/center_view/<c_id>"  </script>'''
#
#
#     else:
#
#         return render_template('center/update_center.html',res=res)
#############################################USER##################################
@app.route('/user_view_profile')######
def user_view_profile():
    obj=Db()
    print(session["lid"])
    res = obj.selectOne("select * from user where user_id= '"+str(session["lid"])+"'")
    print(res)
    return render_template('user/user profile view.html', res=res)

@app.route('/user_update/<c_id>',methods=['GET','POST'])
def center_update(c_id):
    db = Db()
    qry = "select * from user where user_id='"+str(session["lid"])+"'"
    res=db.selectOne(qry)
    if request.method=='POST':
       db=Db()
       name=request.form['abc']
       street=request.form['str']
       locality=request.form['local']
       district=request.form['district']
       phn=request.form['ph']
       # email=request.form['eml']
       passw= request.form['pas']
       db.update("update user set user_name = '" + name + "',street = '"+street+"',locality = '"+locality+"', district = '"+district+"', phone_number='"+phn+"'  where user_id ='"+str(session['lid'])+"'")
       db.update("update login set user_name='" + name + "',password='"+passw+"' where login_id='"+str(session["lid"])+"'")
       return ''' <script> alert("Send Sucessfully");window.location = "/center_view/<c_id>"  </script>'''
    else:

         return render_template('user/update user.html',res=res)


# @app.route('/insert/<u_id>',methods=['GET','POST'])
# def update_user(u_id):
#      db = Db()
#      qry = "select * from booking,center,user where booking.street =center.street"
#      res=db.select(qry)
#      if request.method=='POST':
#          db=Db()
#          noet=request.form['textarea']
#
#          db.insert("insert into notification VALUE('','"+noet+"','" + u_id + "',curdate(),datetime.now())")
#          return ''' <script> alert("Send Sucessfully");window.location = "/center_view/<c_id>"  </script>'''#
#      else:
#
#         return render_template('center/update_center.html',res=res)
@app.route('/cart')
def cart():
    return render_template("user/cart view.html")


@app.route('/user_feedback',methods=['GET','POST'])
def user_feedback():
    if request.method == 'POST':
        db=Db()
        noet=request.form['textarea']
        db.insert("insert into feedback VALUE('','" + noet +"', '"+str(session["lid"])+"',curdate(),curtime())")
        return ''' <script> alert("Send Sucessfully");window.location = "/center_view/<c_id>"  </script>'''
    else:
        return render_template("user/feedback.html")@app.route('/user_feedback',methods=['GET','POST'])
def user_feedback():
    if request.method == 'POST':
        db=Db()
        noet=request.form['textarea']
        db.insert("insert into feedback VALUE('','" + noet +"', '"+str(session["lid"])+"',curdate(),curtime())")
        return ''' <script> alert("Send Sucessfully");window.location = "/center_view/<c_id>"  </script>'''
    else:
        return render_template("user/feedback.html")


@app.route('/soil_request',methods=['GET','POST'])
def soil_request():
    db=Db()
    obj=db.selectOne("select * from user where user_id='"+str(session["lid"])+"'")
    if request.method == 'POST':
        db=Db()
        name = request.form['abc']
        street = request.form['def']
        locality = request.form['jkl']
        phn= request.form['mno']
        amnt=500
        res = db.insert("insert into soil_report VALUE('', '"+str(session["lid"])+"','"+str(amnt)+"',curdate(),'pending')")
        session['soil_id']=res
        return ''' <script> alert("Send Sucessfully");window.location = "/soil_payment"  </script>'''
    else:
        return render_template("user/sent soil report.html",res=obj)

@app.route('/view_booking')
def view_booking():
    db=Db()
    obj=db.selectOne("select * from delvery where user_id='"+str(session["lid"])+"'")

    return render_template("user/view booking.html", res=obj)



@app.route('/soil_payment',methods=['GET','POST'])
def soil_payment():


    if request.method == 'POST':
        db = Db()
        acc = request.form['abc']
        # car = request.form['efg']
        # mon = request.form['ijk']
        # yr = request.form['lmn']
        # cvv = request.form['hjk']
        res=db.selectOne("select * from payment WHERE account_no='"+acc+"' and user_id='"+str(session["lid"])+"'")
        amount1 = int(res['amount'])
        if res is not None:
            if amount1 >=500:
                db.update("update soil_report set status='booked' where soilreport_id='" + str(session['soil_id']) + "' ")
                db.update("update payment set amount='"+str(amount1-500)+"' where user_id='" + str(session["lid"]) + "' and account_no='"+acc+"' ")
                return ''' <script> alert("Booked Successfully");window.location = "/soil_payment"  </script>'''
            else:
                return ''' <script> alert("insufficient Balance");window.location = "/soil_payment"  </script>'''


        else:
            return ''' <script> alert("Enter Correct Account Number");window.location = "/soil_payment"  </script>'''
        # et = db.selectOne("select amount from payment WHERE user_id='" + str(session["lid"]) + "'")
        # print(ed,et,acc)
        # if ed==str(acc):
        #     if et>=500:
        #         db.update("update soil_report set status='booked' where user_id='" + str(session["lid"]) + "' ")
        #         db.update("update payment set amount=amount-500 where user_id='" + str(session["lid"]) + "'")
        #         return ''' <script> alert("Send Sucessfully");window.location = "/"  </script>'''
        #     else:
        #         return ''' <script> alert("insufficient Balance");window.location = "/soil_payment"  </script>'''
        # else:
        #     return ''' <script> alert("Enter Correct Account Number");window.location = "/soil_payment"  </script>'''


    else:
        return render_template("user/soil payment.html" )



@app.route('/view_soil_booking')
def view_soil_booking():
        qry = "select * from soil_report where user_id='"+str(session["lid"])+"';"
        obj = Db()
        res = obj.select(qry)
        return render_template("user/view soil report.html", res=res)


@app.route('/user_complaint')
def user_complaint():
    if request.method == 'POST':
        db=Db()
        noet=request.form['textarea']
        db.insert("insert into complaint VALUE('','" + noet +"', '"+str(session["lid"])+"',curdate(),curtime())")
        return ''' <script> alert("Send Sucessfully");window.location = "/center_view/<c_id>"  </script>'''
    else:
        return render_template("user/feedback.html")

if __name__ == '__main__':
    app.run()
