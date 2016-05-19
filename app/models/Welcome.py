""" 
    Sample Model File

    A Model should be in charge of communicating with the Database. 
    Define specific model method that query the database for information.
    Then call upon these model method in your controller.

    Create a model using this template.
"""
from system.core.model import Model
import re
class Welcome(Model):
    def __init__(self):
        super(Welcome, self).__init__()

    def select_user(self, user_id):
        return self.db.query_db("Select * from users WHERE id= :user_id",{'user_id':user_id})


    
    def add_user(self, info):
        EMAIL_REGEX = re.compile(r'^[a-za-z0-9\.\+_-]+@[a-za-z0-9\._-]+\.[a-za-z]*$')
        password = info['password']
        print info
        errors = []
        if len(info['first_name']) < 2 or len(info['last_name']) < 2: 
            errors.append('Fisrt Name and Last Name must contain at least 2 Characters') 
        if not EMAIL_REGEX.match(info['email']):   
            errors.append('Invailid email address!')
        if len(info['password']) < 4:
            errors.append('password must be at least length of 4')   
        if info['password'] != info['confirm_password']:
            errors.append('password dose NOT match!')
        if errors:         
            return {'status':False, 'errors':errors}
        
        else:
            hash_pw = self.bcrypt.generate_password_hash(password)
            checkuser = self.db.query_db("Select * From users") 
            print checkuser
            if checkuser == []:
                level = 3
            else:
                level = 0
            query = "INSERT INTO users (first_name, last_name, email, password, level, Created_at) VALUES ( :first_name, :last_name, :email, :password, :level, NOW())"
            value = {   
                'first_name': info['first_name'],
                'last_name': info['last_name'],
                'email': info['email'],
                'password' : hash_pw,
                'level':level
            }
            self.db.query_db(query, value)
            userdata = self.db.query_db("Select * From users WHERE email= :email", {'email':info['email']})
            #print userdata
            return {'status': True, 'personal': userdata}

    def all_users(self):
        print ' ------ Models --------- all_users ---------'
        return self.db.query_db("Select * from users")

    def user_login(self, info):
        print ' ------ Models --------- user_login ---------'
        print info
        errors = []
        password = info['password']
        checklogin = self.db.query_db("Select * from users WHERE email= :email", {'email':info['email']})
        
        if checklogin == []:
            errors.append('Email address dose NOT exist! Please register first!')
            return {'status':False, 'errors' : errors}
        elif self.bcrypt.check_password_hash(checklogin[0]['password'], password):
            print '------------  password matched Welcome !!! ----------------' 
            return {'status':True, 'personal': checklogin[0]}    
        else:
            print 'password dose Not Match!!'
            errors.append('Email address dose NOT exist! Please register first!')
            return {'status':False, 'errors' : errors}
        
    def change_info(self, info, user_id):
        user = self.db.query_db("Select * FROM users WHERE id= :user_id",{'user_id':user_id})
        print user
        if info['email'] == "":
            print 'blank email address'
            info['email'] = user[0]['email']
        if info['first_name'] == "":
            info['first_name'] = user[0]['first_name']
        if info['last_name'] == "":
            info['last_name'] = user[0]['last_name']  
        query = "UPDATE users SET email= :email, first_name= :first_name, last_name= :last_name WHERE id= :user_id"
        value = { 
            'email':info['email'], 
            'first_name':info['first_name'],
            'last_name': info['last_name'],
            'user_id': user_id
            }
        return self.db.query_db(query, value)

    def change_pw(self, info, user_id):
        password = info['password']
        if password == info['confirm_password']:   
            hash_pw = self.bcrypt.generate_password_hash(password)
            query = "UPDATE users SET password= :password WHERE id= :user_id"
            value = { 
              'password' : hash_pw
                }
            return self.db.query_db(query, value)
        else:
            errors=["Password does NOT match!! Please try again!!"]
            print "Password does NOT match!!"
            return {'status':False, 'errors':errors} 
    def all_posts(self):
        return self.db.query_db("SELECT posts.wall_id As wall_id, posts.id AS post_id, users.id AS poster_id, users.first_name AS poster_fname, users.last_name AS poster_lname ,posts.created_at AS post_date, posts.post AS post FROM posts join users ON users.id = posts.user_id order by posts.id DESC")

    def add_post(self, info):   
        print info
        query = "INSERT INTO POSTS (post, wall_id, created_at, user_id) VALUES (:post, :wall_id, NOW(), :user_id) "
        value = { 'post': info['post'], 'wall_id': info['wall_id'], 'user_id': info['user_id'] }
        return self.db.query_db(query, value)

    def add_comment(self, info):
        query = "INSERT INTO comments(comment, created_at, user_id, post_id) VALUES ( :comment, NOW(), :user_id, :post_id)"
        value = {
                'comment':info['comment'], 
                'user_id':info['user_id'], 
                'post_id':info['post_id']
                }
        print info
        return self.db.query_db(query, value)

    def all_comments(self):
        print ' ---------------  Model all_comments   ------------------------ '
        query = "select * from posts join comments ON posts.id = comments.post_id"
        return self.db.query_db(query)